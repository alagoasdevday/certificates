require 'rails_helper'

RSpec.describe Event, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:location) }
  it { expect(subject).to validate_presence_of(:start_date) }
  it { expect(subject).to validate_presence_of(:end_date) }
  it { expect(subject).to validate_presence_of(:workload) }
  it { expect(subject).to have_and_belong_to_many(:participants).autosave(true) }

  it 'has a valid factory' do
    expect(build(:event)).to be_valid
  end

  context 'is invalid' do
    let(:event) { build(:event) }

    before(:each) do
      event.name = nil
      event.location = nil
      event.start_date = nil
      event.end_date = nil
      event.workload = nil
      event.valid?
    end

    it 'without a name' do
      expect(event.errors[:name]).to include("can't be blank")
    end

    it 'without a location' do
      expect(event.errors[:location]).to include("can't be blank")
    end

    it 'without a start_date' do
      expect(event.errors[:start_date]).to include("can't be blank")
    end

    it 'without a end_date' do
      expect(event.errors[:end_date]).to include("can't be blank")
    end

    it 'without a workload' do
      expect(event.errors[:workload]).to include("can't be blank")
    end
  end

  context 'is valid' do
  end
end
