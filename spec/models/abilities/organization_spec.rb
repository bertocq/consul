require 'rails_helper'
require 'cancan/matchers'

describe "Abilities::Organization" do
  subject(:ability) { Ability.new(user) }

  let(:user) { organization.user }
  let(:organization) { create(:organization) }
  let(:debate) { create(:debate) }
  let(:proposal) { create(:proposal) }

  it { is_expected.to be_able_to(:show, user) }
  it { is_expected.to be_able_to(:edit, user) }

  it { is_expected.to be_able_to(:index, Debate) }
  it { is_expected.to be_able_to(:show, debate) }
  it { is_expected.not_to be_able_to(:vote, debate) }

  it { is_expected.to be_able_to(:index, Proposal) }
  it { is_expected.to be_able_to(:show, proposal) }
  it { is_expected.not_to be_able_to(:vote, Proposal) }

  it { is_expected.to be_able_to(:create, Comment) }
  it { is_expected.not_to be_able_to(:vote, Comment) }
end
