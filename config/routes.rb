# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    resources :comments, except: %i[index], module: 'posts', shallow: true
  end

  devise_for :users
  root to: 'posts#index'
end
