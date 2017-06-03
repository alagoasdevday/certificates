class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :pdf_layout, default: 'pdf'
      t.string :pdf_template, default: 'pdf'
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :workload, default: 0

      t.timestamps null: false
    end
  end
end
