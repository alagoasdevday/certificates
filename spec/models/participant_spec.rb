require 'rails_helper'

RSpec.describe Participant, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:participation_type) }
  it { expect(subject).to have_and_belong_to_many(:events).autosave(true) }

  it 'has a valid factory' do
    expect(build(:participant)).to be_valid
  end

  context 'is invalid' do
    let(:participant) { build(:participant) }

    before(:each) do
      participant.name = nil
      participant.email = nil
      participant.participation_type = nil
      participant.valid?
    end

    it 'without a name' do
      expect(participant.errors[:name]).to include("can't be blank")
    end

    it 'without a email' do
      expect(participant.errors[:email]).to include("can't be blank")
    end

    it 'without a participation_type' do
      expect(participant.errors[:participation_type]).to include("can't be blank")
    end
  end

  context 'is valid' do
    it 'without events' do
      participant = build(:participant, events: [])
      participant.valid?
      expect(participant.errors[:events]).to be_empty
    end
  end
end
