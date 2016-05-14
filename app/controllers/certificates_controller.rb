class CertificatesController < ApplicationController
  def index
  end

  def search
    @participant = Participant.find_by(email: params[:email])
    render action: :index, alert: "Nenhum participante encontrado com o e-mail \"#{params[:email]}\"", status: :not_found if @participant.nil?
    @events = @participant.events unless @participant.nil?
  end

  def show
    # TODO: Improve error handling if participant is not on a particular event
    # TODO: Test above case
    @event = Event.find(params[:event_id])
    @participant = @event.participants.find(params[:participant_id])
    respond_to do |format|
      format.pdf do
        render pdf:                            "#{@event.name} - #{@participant.name}",
               disposition:                    'attachment',                 # default 'inline'
               template:                       "certificates/#{@event.pdf_template}.pdf.erb",
               layout:                         "#{@event.pdf_layout}.html",                   # use 'pdf.html' for a pdf.html.erb file
               show_as_html:                   params[:debug].present?,      # allow debugging based on url param
               orientation:                    'Landscape',                  # default Portrait
               page_size:                      'Letter',            # default A4
               margin:  {
                  top:               5,
                  bottom:            0,
                  left:              0,
                  right:             0
              },
              title:                          "Certificado #{@event.name}"            # otherwise first page title is used
      end
    end
  end
end
