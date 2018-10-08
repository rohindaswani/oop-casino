# Pretend we are a casino, and we’ve hired you to design a library for us.
# This library will provide the functionality of a deck of playing cards, using any object-oriented language.
# It can be in Ruby or the language of your choice.
# We are not looking for a game or simulation, but just a library that another developer could use and reasonably trust.

# At a minimum, the library should be able to shuffle the deck of cards, deal a hand,
# and take back discarded cards from a hand. We would also like a developer to easily
# provide their own shuffle algorithm if your default one needs to change.

class Card
  attr_accessor :rank, :suit

  def initialize(suite, rank)
    @suit = suite
    @rank = rank
  end

  def show
    puts "The #{@rank} of #{@suit}"
  end
end

class Deck
  def initialize
    @cards = []
    @discarded = []
    @suits = %w[Hearts Spades Clubs Diamonds]
    @rank = %w[Ace 2 3 4 5 6 7 8 9 10 Jack Queen King]

    @suits.each do |suite|
      @rank.each do |value|
        @cards << Card.new(suite, value)
      end
    end
  end

  def shuffle(shuffler)
    if shuffler
      shuffler.call(@cards)
    else
      @cards.shuffle!
    end
  end

  def deal(num)
    cards = []
    cards.push(*@cards.shift(num))
    cards
  end

  def discard(cards)
    @discarded.push(*cards)
  end

  def remaining_cards
    @cards.size
  end

  def discarded_cards
    @discarded.size
  end
end

class Hand
  def initialize
    @cards = []
  end

  def draw(deck, num)
    @cards.push(*deck.deal(num))
  end

  def discard(deck, num)
    deck.discard(@cards.shift(num))
  end

  def show
    @cards.each {|card| card.show}
  end
end

def dealer(shuffler = nil)
  deck = Deck.new
  deck.shuffle(shuffler)

  hand = Hand.new
  hand.draw(deck, 30)
  hand.show
  hand.discard(deck, 10)
  hand.show
  puts "deck.remaining_cards #{deck.remaining_cards.inspect}"
  puts "deck.discarded_cards #{deck.discarded_cards.inspect}"
end

shuffler = Proc.new do |deck|
  last = deck.size - 1

  while last >= 0 do
    i = Random.rand(0..last)
    copy = deck[last]
    deck[last] = deck[i]
    deck[i] = copy
    last -= 1
  end
end

dealer(shuffler)