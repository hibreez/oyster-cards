require 'oystercard'

describe "User Stories" do
  let(:card) { Oystercard.new }

  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card has a balance of 0' do
    expect(card.balance).to eq 0
  end

  #In order to keep using public transport
  #As a customer
  #I want to add money to my card
  it 'can add money to card' do
    card.top_up! 10
    expect(card.balance).to eq 10
  end

  #In order to protect my money from theft or loss
  #As a customer
  #I want a maximum limit (of £90) on my card
  it 'card has a maximum balance of 90' do
    card.top_up! Oystercard::BALANCE_LIMIT
    expect{card.top_up! 1}.to raise_error 'Cannot exceed balance of 90!'
  end

  #In order to get through the barriers.
  #As a customer
  #I need to touch in and out.
  it 'can touch in and touch out' do
    card.top_up! Oystercard::TRAVEL_BALANCE
    card.touch_in!
    expect(card).to be_in_journey
  end

  #In order to pay for my journey
  #As a customer
  #I need to have the minimum amount (£1) for a single journey.
  it 'must have at least £1 balance to touch in' do
    expect{card.touch_in!}.to raise_error "Top up needed!"
  end

  #In order to pay for my journey
  #As a customer
  #I need my fare deducted from my card
  #In order to pay for my journey
  #As a customer
  #When my journey is complete, I need the correct amount deducted from my card
  it 'tapping out deducts a fare from the balance' do
    card.top_up! Oystercard::TRAVEL_BALANCE
    card.touch_in!
    expect {card.touch_out!}.to change{card.balance}.by(-Oystercard::FARE)
  end
end
