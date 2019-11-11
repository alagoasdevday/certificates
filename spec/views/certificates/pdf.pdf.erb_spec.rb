# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'certificates/pdf.pdf.erb', type: :view do
  before(:all) do
    @event = create(:event)
    @participant = create(:participant, events: [@event])
  end

  after(:all) do
    @event.destroy
    @participant.destroy
  end

  before do
    render
  end

  it 'defines pdf basic template' do
    assert_select 'img'
    assert_select 'h3'
  end

  it 'must have participant information' do
    expect(rendered).to match(/#{@participant.name}/)
    expect(rendered).to match(/#{@participant.participation_type}/)
  end

  it 'must have event information' do
    expect(rendered).to match(/#{@event.name}/)
    expect(rendered).to match(/#{@event.location}/)
    expect(rendered).to match(/#{@event.workload}/)
    expect(rendered).to match(/#{@event.start_date.strftime('%d/%m/%Y')}/)
    expect(rendered).to match(/#{@event.end_date.strftime('%d/%m/%Y')}/)
  end
end
