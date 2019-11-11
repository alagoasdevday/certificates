require 'rails_helper'

RSpec.describe "Certificates", type: :request do
  describe "GET /" do
    it "shows home page" do
      get root_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /search" do
    it "fails if no email is provided" do
      get search_events_path, params: { email: nil }
      expect(response).to have_http_status(404)
      expect(response).to render_template(:index)
    end

    it "fails if a email is provided, but is not from a participant" do
      get search_events_path, params: { email: Faker::Internet.email }
      expect(response).to have_http_status(404)
      expect(response).to render_template(:index)
    end

    it "succeed if a valid participant email is provided" do
      event = create(:event)
      participant = create(:participant, events: [event])

      get search_events_path, params: { email: participant.email }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:search)
      expect(response.body).to include(event.name)
    end
  end

  describe "GET /show/:event_id/:participant_id" do
    before(:all) do
      @event = create(:event)
      @participant = create(:participant, events: [@event])
    end

    it "renders PDF certificate" do
      get show_certificate_path(@event, @participant, format: :pdf)

      expect(response).to have_http_status(200)
      expect(response).to render_template('certificates/pdf.pdf.erb')
      expect(response).to render_template(layout: 'layouts/pdf.html')
    end

    it "renders PDF certificate from friendly_id" do
      get show_certificate_path(@event, @participant.friendly_id, format: :pdf)

      expect(response).to have_http_status(200)
      expect(response).to render_template('certificates/pdf.pdf.erb')
      expect(response).to render_template(layout: 'layouts/pdf.html')
    end

    it "renders an error if participant hasn't participated on the event" do
      participant = create(:participant, events: [])
      get show_certificate_path(@event, participant, format: :pdf)

      expect(response).to have_http_status(404)
      expect(response).to render_template('certificates/search')
      expect(response).to render_template(layout: 'layouts/application')
    end

    it "renders an error if participant was not found" do
      get show_certificate_path(@event, 'a-random-participant-friendly-name', format: :pdf)

      expect(response).to have_http_status(404)
      expect(response).to render_template('certificates/index')
      expect(response).to render_template(layout: 'layouts/application')
    end
  end
end
