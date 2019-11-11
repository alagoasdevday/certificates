# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |table|
      table.string :name
      table.string :pdf_layout, default: 'pdf'
      table.string :pdf_template, default: 'pdf'
      table.string :location
      table.date :start_date
      table.date :end_date
      table.integer :workload, default: 0

      table.timestamps null: false
    end
  end
end
