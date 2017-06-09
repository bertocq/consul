require 'rails_helper'

describe ProposalNotification do
  let(:notification) { build(:proposal_notification) }

  it "is valid" do
    expect(notification).to be_valid
  end

  it "is not valid without a title" do
    notification.title = nil
    expect(notification).not_to be_valid
  end

  it "is not valid without a body" do
    notification.body = nil
    expect(notification).not_to be_valid
  end

  it "is not valid without an associated proposal" do
    notification.proposal = nil
    expect(notification).not_to be_valid
  end

  describe "minimum interval between notifications" do

    before do
      Setting[:proposal_notification_minimum_interval_in_days] = 3
    end

    it "is not valid if below minium interval" do
      proposal = create(:proposal)

      notification1 = create(:proposal_notification, proposal: proposal)
      notification2 = build(:proposal_notification, proposal: proposal)

      proposal.reload
      expect(notification2).not_to be_valid
    end

    it "is valid if notifications above minium interval" do
      proposal = create(:proposal)

      notification1 = create(:proposal_notification, proposal: proposal, created_at: 4.days.ago)
      notification2 = build(:proposal_notification, proposal: proposal)

      proposal.reload
      expect(notification2).to be_valid
    end

    it "is valid if no notifications sent" do
      notification1 = build(:proposal_notification)

      expect(notification1).to be_valid
    end

  end

end
