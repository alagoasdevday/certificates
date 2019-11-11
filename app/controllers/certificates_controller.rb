# frozen_string_literal: true

class CertificatesController < ApplicationController
  def index; end

  def search
    @participant = Participant.find_by(email: email)
    if @participant
      @events = @participant.events
    else
      render action: :index,
             alert: "Nenhum participante encontrado com o e-mail \"#{email}\"",
             status: :not_found
    end
  end

  def show
    @event = Event.find(params[:event_id])
    begin
      @participant = @event.participants.find(params[:participant_id])
      render pdf_hash
    rescue StandardError
      participant_not_found
    end
  end

  private

  def email
    params[:email]
  end

  def participant_not_found
    @participant = Participant.find(params[:participant_id])
    @events = @participant.events
    render action: :search,
           formats: [:html],
           alert: "Participante não esteve no evento #{@event.name}",
           status: :not_found
  rescue StandardError
    render action: :index,
           formats: [:html],
           alert: 'Participante não encontrado',
           status: :not_found
  end

  def pdf_hash
    {
      pdf: "#{@event.name} - #{@participant.name}",
      disposition: 'attachment',
      template: "certificates/#{@event.pdf_template}.pdf.erb",
      layout: "#{@event.pdf_layout}.html",
      show_as_html: params[:debug].present?,
      orientation: 'Landscape',
      page_size: 'Letter',
      margin: { top: 5, bottom: 0, left: 0, right: 0 },
      title: "Certificado #{@event.name}"
    }
  end
end
