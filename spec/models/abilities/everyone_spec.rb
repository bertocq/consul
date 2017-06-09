require 'rails_helper'
require 'cancan/matchers'

describe "Abilities::Everyone" do
  subject(:ability) { Ability.new(user) }

  let(:user) { nil }
  let(:debate) { create(:debate) }
  let(:proposal) { create(:proposal) }

  it { is_expected.to be_able_to(:index, Debate) }
  it { is_expected.to be_able_to(:show, debate) }
  it { is_expected.not_to be_able_to(:edit, Debate) }
  it { is_expected.not_to be_able_to(:vote, Debate) }
  it { is_expected.not_to be_able_to(:flag, Debate) }
  it { is_expected.not_to be_able_to(:unflag, Debate) }

  it { is_expected.to be_able_to(:index, Proposal) }
  it { is_expected.to be_able_to(:show, proposal) }
  it { is_expected.not_to be_able_to(:edit, Proposal) }
  it { is_expected.not_to be_able_to(:vote, Proposal) }
  it { is_expected.not_to be_able_to(:flag, Proposal) }
  it { is_expected.not_to be_able_to(:unflag, Proposal) }

  it { is_expected.to be_able_to(:show, Comment) }

  it { is_expected.to be_able_to(:index, SpendingProposal) }
  it { is_expected.not_to be_able_to(:create, SpendingProposal) }

  it { is_expected.to be_able_to(:index, Budget) }
end