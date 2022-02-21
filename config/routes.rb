# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    resources :comments, except: %i[index], module: 'posts', shallow: true
    resources :likes, only: %i[create destroy], module: 'posts', shallow: true
  end

  devise_for :users
end
