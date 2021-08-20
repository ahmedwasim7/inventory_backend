# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, except: %i[new edit], defaults: { format: 'json' } do
    namespace :v1 do
      resources :auth do
        collection do
          post :login
        end
      end

      resources :inventories
    end
  end
end
