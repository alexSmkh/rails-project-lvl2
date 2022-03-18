# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: %i[create edit update destroy], module: 'posts', shallow: true
    resources :likes, only: %i[create destroy], module: 'posts'
  end

  devise_for :users
end
