# frozen_string_literal: true

require 'csv'
namespace :import do
  desc 'Import from CSV File on tmp folder. CSV must be with [Name,Email] headers'
  task csv: :environment do
    events = Event.all
    puts 'Type the event id to import data into'
    events.each { |event| puts "#{event.id} - #{event.name}" }
    event_id = STDIN.gets.chomp
    begin
      event = Event.find(event_id.to_i)
      CSV.foreach(File.join(Rails.root, Dir.tmpdir, 'import.csv'), col_sep: ',', encoding: 'utf-8', headers: :first_row, skip_blanks: true) do |row|
        participant = Participant.find_by(email: row['Email'])
        if participant.nil?
          participant = Participant.create(
            name: row['Name'],
            email: row['Email'],
            participation_type: 'Ouvinte'
          )
        end
        unless participant.events.include?(event)
          puts "importing #{row['Name']} - #{row['Email']}"
          participant.events << event
        end
      end
    rescue StandardError
      puts "Event #{event_id} was not found"
    end
  end
end
