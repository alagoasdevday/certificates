# frozen_string_literal: true

class Participant < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name

  has_and_belongs_to_many :events, autosave: true

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :participation_type
end
