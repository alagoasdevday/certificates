class CertificatesController < ApplicationController
  def index
  end

  def search
    @participant = Participant.find_by(email: params[:email])
    render action: :index, alert: "Nenhum participante encontrado com o e-mail \"#{params[:email]}\"", status: :not_found if @participant.nil?
    @events = @participant.events unless @participant.nil?
  end

  def show
    @event = Event.find(params[:event_id])
    @participant = @event.participants.find(params[:participant_id]) rescue nil
    if @participant
      respond_to do |format|
        format.pdf do
          render pdf_hash
        end
      end
    else
      @participant = Participant.find(params[:participant_id]) rescue nil
      if @participant
        @events = @participant.events
        render action: :search, formats: [:html], alert: "Participante não esteve no evento #{@event.name}", status: :not_found
      else
        render action: :index, formats: [:html], alert: "Participante não encontrado", status: :not_found
      end
    end
  end

  private

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
