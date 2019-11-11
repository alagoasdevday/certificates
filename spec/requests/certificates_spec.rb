# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Certificates', type: :request do
  describe 'GET /' do
    context 'when shows home page' do
      before do
        get root_path
      end

      it 'is successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET /search' do
    context 'when no email is provided' do
      before do
        get search_events_path, params: { email: nil }
      end

      it 'responds with not found error' do
        expect(response).to have_http_status(:not_found)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when a email is provided, but is not from a participant' do
      before do
        get search_events_path, params: { email: Faker::Internet.email }
      end

      it 'responds with not found error' do
        expect(response).to have_http_status(:not_found)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when a valid participant email is provided' do
      let(:event) { create(:event) }
      let(:participant) { create(:participant, events: [event]) }

      before do
        get search_events_path, params: { email: participant.email }
      end

      it 'is successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders search template' do
        expect(response).to render_template(:search)
      end

      it 'has event name' do
        expect(response.body).to include(event.name)
      end
    end
  end

  describe 'GET /show/:event_id/:participant_id' do
    let(:event) { create(:event) }
    let(:participant) { create(:participant, events: [event]) }

    context 'with PDF certificate' do
      before do
        get show_certificate_path(event, participant, format: :pdf)
      end

      it 'is successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders pdf template' do
        expect(response).to render_template('certificates/pdf.pdf.erb')
      end

      it do
        expect(response).to render_template(layout: 'layouts/pdf.html')
      end
    end

    context 'with PDF certificate from friendly_id' do
      before do
        get show_certificate_path(event, participant.friendly_id, format: :pdf)
      end

      it 'is successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders pdf template' do
        expect(response).to render_template('certificates/pdf.pdf.erb')
      end

      it 'renders pdf layout' do
        expect(response).to render_template(layout: 'layouts/pdf.html')
      end
    end

    context "when a participant hasn't participated on the event" do
      let(:participant) { create(:participant, events: []) }

      before do
        get show_certificate_path(event, participant, format: :pdf)
      end

      it 'responds with not found error' do
        expect(response).to have_http_status(:not_found)
      end

      it 'renders search template' do
        expect(response).to render_template(:search)
      end
    end

    context 'when participant was not found' do
      before do
        get show_certificate_path(event, 'a-random-participant-friendly-name', format: :pdf)
      end

      it 'responds with not found error' do
        expect(response).to have_http_status(:not_found)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end
  end
end
