class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :participation_type

      t.timestamps null: false
    end
  end
end
