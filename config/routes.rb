# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'certificates#index'
  get 'search', to: 'certificates#search', as: :search_events
  get 'show/:event_id/:participant_id', to: 'certificates#show', as: :show_certificate
end
