require 'rails_helper'

RSpec.describe Brewery, :type => :model do
  describe 'has the name and year set correctly and is saved to database' do
    subject{ Brewery.create name: 'Schlenkerla', year: 1674 }

    it { should be_valid }
    its(:name) { should eq 'Schlenkerla' }
    its(:year) { should be 1674 }
  end

  describe 'without a name' do
    subject { Brewery.create name: '', year:1674 }
    it {should be_invalid}
  end
end
