require '../lib/card'

class Deck
  attr_reader :cards

  def initialize(args)
    @cards = args[:cards]
  end

  def mix
    self.cards.shuffle!
  end
end
