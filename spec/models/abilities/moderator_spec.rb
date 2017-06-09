require 'rails_helper'
require 'cancan/matchers'

describe "Abilities::Moderator" do
  subject(:ability) { Ability.new(user) }

  let(:user) { moderator.user }
  let(:moderator) { create(:moderator) }

  let(:other_user) { create(:user) }

  let(:debate) { create(:debate) }
  let(:comment) { create(:comment) }
  let(:proposal) { create(:proposal) }
  let(:legislation_question) { create(:legislation_question) }

  let(:own_debate) { create(:debate, author: user) }
  let(:own_comment) { create(:comment, author: user) }
  let(:own_proposal) { create(:proposal, author: user) }

  let(:hidden_debate) { create(:debate, :hidden) }
  let(:hidden_comment) { create(:comment, :hidden) }
  let(:hidden_proposal) { create(:proposal, :hidden) }

  it { is_expected.to be_able_to(:index, Debate) }
  it { is_expected.to be_able_to(:show, debate) }
  it { is_expected.to be_able_to(:vote, debate) }

  it { is_expected.to be_able_to(:index, Proposal) }
  it { is_expected.to be_able_to(:show, proposal) }

  it { is_expected.to be_able_to(:read, Organization) }

  describe "organizations" do
    let(:pending_organization)  { create(:organization) }
    let(:rejected_organization) { create(:organization, :rejected) }
    let(:verified_organization) { create(:organization, :verified) }

    it { is_expected.to be_able_to(    :verify, pending_organization)  }
    it { is_expected.to be_able_to(    :reject, pending_organization)  }

    it { is_expected.not_to be_able_to(:verify, verified_organization) }
    it { is_expected.to be_able_to(    :reject, verified_organization) }

    it { is_expected.not_to be_able_to(:reject, rejected_organization) }
    it { is_expected.to be_able_to(    :verify, rejected_organization) }
  end

  describe "hiding, reviewing and restoring" do
    let(:ignored_comment)  { create(:comment, :with_ignored_flag) }
    let(:ignored_debate)   { create(:debate,  :with_ignored_flag) }
    let(:ignored_proposal) { create(:proposal,:with_ignored_flag) }

    it { is_expected.to be_able_to(:hide, comment) }
    it { is_expected.to be_able_to(:hide_in_moderation_screen, comment) }
    it { is_expected.not_to be_able_to(:hide, hidden_comment) }
    it { is_expected.not_to be_able_to(:hide, own_comment) }

    it { is_expected.to be_able_to(:moderate, comment) }
    it { is_expected.not_to be_able_to(:moderate, own_comment) }

    it { is_expected.to be_able_to(:hide, debate) }
    it { is_expected.to be_able_to(:hide_in_moderation_screen, debate) }
    it { is_expected.not_to be_able_to(:hide, hidden_debate) }
    it { is_expected.not_to be_able_to(:hide, own_debate) }

    it { is_expected.to be_able_to(:hide, proposal) }
    it { is_expected.to be_able_to(:hide_in_moderation_screen, proposal) }
    it { is_expected.not_to be_able_to(:hide, hidden_proposal) }
    it { is_expected.not_to be_able_to(:hide, own_proposal) }

    it { is_expected.to be_able_to(:ignore_flag, comment) }
    it { is_expected.not_to be_able_to(:ignore_flag, hidden_comment) }
    it { is_expected.not_to be_able_to(:ignore_flag, ignored_comment) }
    it { is_expected.not_to be_able_to(:ignore_flag, own_comment) }

    it { is_expected.to be_able_to(:ignore_flag, debate) }
    it { is_expected.not_to be_able_to(:ignore_flag, hidden_debate) }
    it { is_expected.not_to be_able_to(:ignore_flag, ignored_debate) }
    it { is_expected.not_to be_able_to(:ignore_flag, own_debate) }

    it { is_expected.to be_able_to(:moderate, debate) }
    it { is_expected.not_to be_able_to(:moderate, own_debate) }

    it { is_expected.to be_able_to(:ignore_flag, proposal) }
    it { is_expected.not_to be_able_to(:ignore_flag, hidden_proposal) }
    it { is_expected.not_to be_able_to(:ignore_flag, ignored_proposal) }
    it { is_expected.not_to be_able_to(:ignore_flag, own_proposal) }

    it { is_expected.to be_able_to(:moderate, proposal) }
    it { is_expected.not_to be_able_to(:moderate, own_proposal) }

    it { is_expected.not_to be_able_to(:hide, user) }
    it { is_expected.to be_able_to(:hide, other_user) }

    it { is_expected.not_to be_able_to(:block, user) }
    it { is_expected.to be_able_to(:block, other_user) }

    it { is_expected.not_to be_able_to(:restore, comment) }
    it { is_expected.not_to be_able_to(:restore, debate) }
    it { is_expected.not_to be_able_to(:restore, proposal) }
    it { is_expected.not_to be_able_to(:restore, other_user) }

    it { is_expected.to be_able_to(:comment_as_moderator, debate) }
    it { is_expected.to be_able_to(:comment_as_moderator, proposal) }
    it { is_expected.to be_able_to(:comment_as_moderator, legislation_question) }
    it { is_expected.not_to be_able_to(:comment_as_administrator, debate) }
    it { is_expected.not_to be_able_to(:comment_as_administrator, proposal) }
    it { is_expected.not_to be_able_to(:comment_as_administrator, legislation_question) }
  end
end
