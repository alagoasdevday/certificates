# frozen_string_literal: true

class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :friendly_id_slugs do |table|
      table.string   :slug,           null: false
      table.integer  :sluggable_id,   null: false
      table.string   :sluggable_type, limit: 50
      table.string   :scope
      table.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, %i[slug sluggable_type]
    add_index :friendly_id_slugs, %i[slug sluggable_type scope], unique: true
    add_index :friendly_id_slugs, :sluggable_type
  end
end
