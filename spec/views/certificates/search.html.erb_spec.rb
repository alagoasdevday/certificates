require 'rails_helper'

RSpec.describe "certificates/search.html.erb", type: :view do
  before(:all) do
    @participant = create(:participant)
    @events = @participant.events
  end

  after(:all) do
    @participant.destroy
    @events.collect { |event| event.destroy }
  end

  before(:each) do
    render
  end

  it "defines search result template" do

    render

    assert_select "h1"
    assert_select "div[class=?]", "row" do
      @events.each do |event|
        assert_select "div[id=?][class=?]", dom_id(event), "col-md-6 event btn btn-default" do
          assert_select "a[href=?][target=_blank]", show_certificate_path(event, @participant, format: :pdf)
        end
      end
    end

    assert_select "form[action=?][method=?][class=?]", search_events_path, "get", "form-horizontal" do
      assert_select "div[class=?]", "form-group col-md-12" do
        assert_select "input#email[name=?][class=?]", "email", "form-control input-lg"
      end
      assert_select "button[class=?][type=?]", "btn btn-primary", "submit"
    end
  end

  it "must have participant information" do
    expect(rendered).to match(/#{@participant.name}/)
  end

  it "must have all events information" do
    @events.each do |event|
      expect(rendered).to match(/#{event.name}/)
      expect(rendered).to match(/#{show_certificate_path(event, @participant, format: :pdf)}/)
    end
  end
end
