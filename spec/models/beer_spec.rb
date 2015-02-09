require 'rails_helper'

RSpec.describe Beer, :type => :model do
  let!(:style) { FactoryGirl.create :style }
  it 'has name and style set correctly' do
    beer = Beer.create name:'Beer', style: style

    expect(beer.name).to eq 'Beer'
    expect(beer.style).to eq style
    expect(Beer.count).to eq 1
  end

  it 'is not created without a name' do
    beer = Beer.create style: style

    expect(beer.valid?).to eq false
    expect(Beer.count).to eq 0
  end

  it 'is not created without a style' do
    beer = Beer.create name:'Beer'

    expect(beer.valid?).to eq false
    expect(Beer.count).to eq 0
  end

end
