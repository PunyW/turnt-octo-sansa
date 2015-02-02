require 'rails_helper'

RSpec.describe Beer, :type => :model do
  it 'has name and style set correctly' do
    beer = Beer.create name:'Beer', style:'Lager'

    expect(beer.name).to eq 'Beer'
    expect(beer.style).to eq 'Lager'
    expect(Beer.count).to eq 1
  end

  it 'is not created without a name' do
    beer = Beer.create style:'Lager'

    expect(beer.valid?).to eq false
    expect(Beer.count).to eq 0
  end

  it 'is not created without a style' do
    beer = Beer.create name:'Beer'

    expect(beer.valid?).to eq false
    expect(Beer.count).to eq 0
  end

end
