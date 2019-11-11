# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |table|
      table.string :name
      table.string :email
      table.string :participation_type

      table.timestamps null: false
    end
  end
end
