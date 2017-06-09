module Abilities
  class Valuator
    include CanCan::Ability

    def initialize(user)
      valuator = user.valuator
      can %i[read update valuate], SpendingProposal
      can %i[read update valuate], Budget::Investment, id: valuator.investment_ids
      cannot %i[update valuate], Budget::Investment, budget: { phase: 'finished' }
    end
  end
end
