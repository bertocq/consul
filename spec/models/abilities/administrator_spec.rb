require 'rails_helper'
require 'cancan/matchers'

describe "Abilities::Administrator" do
  subject(:ability) { Ability.new(user) }

  let(:user) { administrator.user }
  let(:administrator) { create(:administrator) }

  let(:other_user) { create(:user) }
  let(:hidden_user) { create(:user, :hidden) }

  let(:debate) { create(:debate) }
  let(:comment) { create(:comment) }
  let(:proposal) { create(:proposal) }
  let(:legislation_question) { create(:legislation_question) }

  let(:hidden_debate) { create(:debate, :hidden) }
  let(:hidden_comment) { create(:comment, :hidden) }
  let(:hidden_proposal) { create(:proposal, :hidden) }

  it { is_expected.to be_able_to(:index, Debate) }
  it { is_expected.to be_able_to(:show, debate) }
  it { is_expected.to be_able_to(:vote, debate) }

  it { is_expected.to be_able_to(:index, Proposal) }
  it { is_expected.to be_able_to(:show, proposal) }

  it { is_expected.not_to be_able_to(:restore, comment) }
  it { is_expected.not_to be_able_to(:restore, debate) }
  it { is_expected.not_to be_able_to(:restore, proposal) }
  it { is_expected.not_to be_able_to(:restore, other_user) }

  it { is_expected.to be_able_to(:restore, hidden_comment) }
  it { is_expected.to be_able_to(:restore, hidden_debate) }
  it { is_expected.to be_able_to(:restore, hidden_proposal) }
  it { is_expected.to be_able_to(:restore, hidden_user) }

  it { is_expected.not_to be_able_to(:confirm_hide, comment) }
  it { is_expected.not_to be_able_to(:confirm_hide, debate) }
  it { is_expected.not_to be_able_to(:confirm_hide, proposal) }
  it { is_expected.not_to be_able_to(:confirm_hide, other_user) }

  it { is_expected.to be_able_to(:confirm_hide, hidden_comment) }
  it { is_expected.to be_able_to(:confirm_hide, hidden_debate) }
  it { is_expected.to be_able_to(:confirm_hide, hidden_proposal) }
  it { is_expected.to be_able_to(:confirm_hide, hidden_user) }

  it { is_expected.to be_able_to(:comment_as_administrator, debate) }
  it { is_expected.not_to be_able_to(:comment_as_moderator, debate) }

  it { is_expected.to be_able_to(:comment_as_administrator, proposal) }
  it { is_expected.not_to be_able_to(:comment_as_moderator, proposal) }

  it { is_expected.to be_able_to(:comment_as_administrator, legislation_question) }
  it { is_expected.not_to be_able_to(:comment_as_moderator, legislation_question) }

  it { is_expected.to be_able_to(:manage, Annotation) }

  it { is_expected.to be_able_to(:read, SpendingProposal) }
  it { is_expected.to be_able_to(:update, SpendingProposal) }
  it { is_expected.to be_able_to(:valuate, SpendingProposal) }
  it { is_expected.to be_able_to(:destroy, SpendingProposal) }

  it { is_expected.to be_able_to(:create, Budget) }
  it { is_expected.to be_able_to(:update, Budget) }

  it { is_expected.to be_able_to(:create, Budget::ValuatorAssignment) }

  it { is_expected.to be_able_to(:update, Budget::Investment) }
  it { is_expected.to be_able_to(:hide,   Budget::Investment) }

  it { is_expected.to be_able_to(:valuate, create(:budget_investment, budget: create(:budget, phase: 'valuating'))) }
  it { is_expected.to be_able_to(:valuate, create(:budget_investment, budget: create(:budget, phase: 'finished'))) }
end
