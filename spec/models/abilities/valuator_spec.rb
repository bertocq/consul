require 'rails_helper'
require 'cancan/matchers'

describe "Abilities::Valuator" do
  subject(:ability) { Ability.new(user) }

  let(:user) { valuator.user }
  let(:valuator) { create(:valuator) }
  let(:non_assigned_investment) { create(:budget_investment) }

  let(:assigned_investment) { create(:budget_investment, budget: create(:budget, phase: 'valuating')) }
  before { assigned_investment.valuators << valuator }

  let(:finished_assigned_investment) { create(:budget_investment, budget: create(:budget, phase: 'finished')) }

  before { finished_assigned_investment.valuators << valuator }

  it { is_expected.to be_able_to(:read, SpendingProposal) }
  it { is_expected.to be_able_to(:update, SpendingProposal) }
  it { is_expected.to be_able_to(:valuate, SpendingProposal) }

  it { is_expected.not_to be_able_to(:update, non_assigned_investment) }
  it { is_expected.not_to be_able_to(:valuate, non_assigned_investment) }

  it { is_expected.to be_able_to(:update, assigned_investment) }
  it { is_expected.to be_able_to(:valuate, assigned_investment) }

  it { is_expected.not_to be_able_to(:update, finished_assigned_investment) }
  it { is_expected.not_to be_able_to(:valuate, finished_assigned_investment) }
end
