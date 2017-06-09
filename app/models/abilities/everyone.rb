module Abilities
  class Everyone
    include CanCan::Ability

    def initialize(user)
      can %i[read map], Debate
      can %i[read map summary share], Proposal
      can :read, Comment
      can :read, Poll
      can :read, Poll::Question
      can %i[read welcome], Budget
      can :read, Budget::Investment
      can :read, SpendingProposal
      can :read, LegacyLegislation
      can :read, User
      can %i[search read], Annotation
      can [:read], Budget
      can [:read], Budget::Group
      can %i[read print], Budget::Investment
      can :new, DirectMessage
      can %i[read debate draft_publication allegations final_version_publication], Legislation::Process
      can %i[read changes go_to_version], Legislation::DraftVersion
      can [:read], Legislation::Question
      can [:create], Legislation::Answer
      can %i[search comments read create new_comment], Legislation::Annotation
    end
  end
end
