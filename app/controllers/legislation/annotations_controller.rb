class Legislation::AnnotationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_user!, only: %i[create new_comment]
  before_action :convert_ranges_parameters, only: [:create]

  load_and_authorize_resource :process
  load_and_authorize_resource :draft_version, through: :process
  load_and_authorize_resource

  has_orders %w{most_voted newest}, only: :show

  def index
    @annotations = @draft_version.annotations
  end

  def show
    @commentable = @annotation

    if params[:sub_annotation_ids].present?
      @sub_annotations = Legislation::Annotation.where(id: params[:sub_annotation_ids].split(','))
      annotations = [@commentable, @sub_annotations]
    else
      annotations = [@commentable]
    end

    @comment_tree = MergedCommentTree.new(annotations, params[:page], @current_order)
    set_comment_flags(@comment_tree.comments)
  end

  def create
    if !@process.open_phase?(:allegations) || @draft_version.final_version?
      render(json: {}, status: :not_found) && return
    end

    existing_annotation = @draft_version.annotations.where(
      range_start: annotation_params[:ranges].first[:start], range_start_offset: annotation_params[:ranges].first[:startOffset].to_i,
      range_end: annotation_params[:ranges].first[:end], range_end_offset: annotation_params[:ranges].first[:endOffset].to_i
    ).first

    if @annotation = existing_annotation
      if comment = @annotation.comments.create(body: annotation_params[:text], user: current_user)
        render json: @annotation.to_json
      else
        render json: comment.errors.full_messages, status: :unprocessable_entity
      end
    else
      @annotation = @draft_version.annotations.new(annotation_params)
      @annotation.author = current_user
      if @annotation.save
        track_event
        render json: @annotation.to_json
      else
        render json: @annotation.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  def search
    @annotations = @draft_version.annotations.order("LENGTH(quote) DESC")
    annotations_hash = { total: @annotations.size, rows: @annotations }
    render json: annotations_hash.to_json(methods: :weight)
  end

  def comments
    @annotation = Legislation::Annotation.find(params[:annotation_id])
    @comment = @annotation.comments.new
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  def new_comment
    @draft_version = Legislation::DraftVersion.find(params[:draft_version_id])
    @annotation = @draft_version.annotations.find(params[:annotation_id])
    @comment = @annotation.comments.new(body: params[:comment][:body], user: current_user)
    @comment = @annotation.comments.new if @comment.save

    respond_to do |format|
      format.js { render :new_comment }
    end
  end

  private

    def annotation_params
      params
        .require(:legislation_annotation)
        .permit(:quote, :text, ranges: %i[start startOffset end endOffset])
    end

    def track_event
      ahoy.track "legislation_annotation_created".to_sym,
                 "legislation_annotation_id": @annotation.id,
                 "legislation_draft_version_id": @draft_version.id
    end

    def convert_ranges_parameters
      if params[:legislation_annotation] && params[:legislation_annotation][:ranges] && params[:legislation_annotation][:ranges].is_a?(String)
        params[:legislation_annotation][:ranges] = JSON.parse(params[:legislation_annotation][:ranges])
      end
    rescue JSON::ParserError
    end

end
