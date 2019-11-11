# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'certificates/pdf.pdf.erb', type: :view do
  let(:event) { create(:event) }
  let(:participant) { create(:participant, events: [event]) }

  before do
    assign(:participant, participant)
    assign(:event, event)

    render
  end

  it 'defines pdf basic template' do
    assert_select 'img'
    assert_select 'h3'
  end

  it 'must have participant name' do
    expect(rendered).to match(/#{participant.name}/)
  end

  it 'must have participant type' do
    expect(rendered).to match(/#{participant.participation_type}/)
  end

  it 'must have event name' do
    expect(rendered).to match(/#{event.name}/)
  end

  it 'must have event location' do
    expect(rendered).to match(/#{event.location}/)
  end

  it 'must have event workload' do
    expect(rendered).to match(/#{event.workload}/)
  end

  it 'must have event start date' do
    expect(rendered).to match(/#{event.start_date.strftime('%d/%m/%Y')}/)
  end

  it 'must have event end date' do
    expect(rendered).to match(/#{event.end_date.strftime('%d/%m/%Y')}/)
  end
end
