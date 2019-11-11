# frozen_string_literal: true

class CreateTableEventsParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :events_participants do |table|
      table.belongs_to :event, index: true
      table.belongs_to :participant, index: true
    end
    add_foreign_key :events_participants, :events
    add_foreign_key :events_participants, :participants
  end
end
