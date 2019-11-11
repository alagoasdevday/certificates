require 'rails_helper'

RSpec.describe CertificatesController, type: :controller do
  let(:event) { create(:event) }
  let(:participant) { create(:participant, events: [event]) }

  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #search" do
    describe "if email is provided" do
      before(:each) do
        get :search, params: { email: participant.email }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the search template" do
        expect(response).to render_template(:search)
      end

      it "assigns @participant" do
        expect(assigns(:participant)).to eq(participant)
      end

      it "assigns @events" do
        expect(assigns(:events)).to eq([event])
      end
    end

    describe "if email is not provided" do
      before(:each) do
        get :search, params: { email: nil }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end
    end

    describe "if email is not in database" do
      before(:each) do
        get :search, params: { email: Faker::Internet.email }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #show" do
    describe "if email is provided" do
      before(:each) do
        get :show, params: { event_id: event.id, participant_id: participant.id, format: :pdf }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the default pdf template" do
        expect(response).to render_template('certificates/pdf.pdf.erb')
      end

      it "renders the pdf layout" do
        expect(response).to render_template(layout: 'layouts/pdf.html')
      end

      it "assigns participant" do
        expect(assigns(:participant)).to eq(participant)
      end

      it "assigns @event" do
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "if email is not provided" do
      let(:another_participant) { create(:participant, events: []) }

      before(:each) do
        get :show, params: { event_id: event.id, participant_id: another_participant.id, format: :pdf }
      end

      it "returns http success" do
        expect(response).to have_http_status(:not_found)
      end

      it "assigns @event" do
        expect(assigns(:event)).to eq(event)
      end
    end
  end
end
