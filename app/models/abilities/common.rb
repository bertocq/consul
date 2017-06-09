module Abilities
  class Common
    include CanCan::Ability

    def initialize(user)
      self.merge Abilities::Everyone.new(user)

      can %i[read update], User, id: user.id

      can :read, Debate
      can :update, Debate do |debate|
        debate.editable_by?(user)
      end

      can :read, Proposal
      can :update, Proposal do |proposal|
        proposal.editable_by?(user)
      end
      can %i[retire_form retire], Proposal, author_id: user.id

      can :create, Comment
      can :create, Debate
      can :create, Proposal

      can :suggest, Debate
      can :suggest, Proposal

      can %i[flag unflag], Comment
      cannot %i[flag unflag], Comment, user_id: user.id

      can %i[flag unflag], Debate
      cannot %i[flag unflag], Debate, author_id: user.id

      can %i[flag unflag], Proposal
      cannot %i[flag unflag], Proposal, author_id: user.id

      unless user.organization?
        can :vote, Debate
        can :vote, Comment
      end

      if user.level_two_or_three_verified?
        can :vote, Proposal
        can :vote_featured, Proposal
        can :vote, SpendingProposal
        can :create, SpendingProposal

        can :create, Budget::Investment,               budget: { phase: "accepting" }
        can :destroy, Budget::Investment,              budget: { phase: ["accepting", "reviewing"] }, author_id: user.id
        can :vote,   Budget::Investment,               budget: { phase: "selecting" }
        can %i[show create], Budget::Ballot,          budget: { phase: "balloting" }
        can %i[create destroy], Budget::Ballot::Line, budget: { phase: "balloting" }

        can :create, DirectMessage
        can :show, DirectMessage, sender_id: user.id
        can :answer, Poll do |poll|
          poll.answerable_by?(user)
        end
        can :answer, Poll::Question do |question|
          question.answerable_by?(user)
        end
      end

      can %i[create show], ProposalNotification, proposal: { author_id: user.id }

      can :create, Annotation
      can %i[update destroy], Annotation, user_id: user.id
    end
  end
end
