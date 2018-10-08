describe Card, type: Class do
  it "is initialized with a suite and rank" do
    card = Card.new("Hearts", "Ace")
    expect(card.suit).to be "Hearts"
    expect(card.rank).to be "Ace"
  end
end