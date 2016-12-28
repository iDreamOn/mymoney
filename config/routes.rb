Rails.application.routes.draw do
  resources :schedules
  resources :account_balances do
    member do
      get :make_payments
      get :undo_payments
    end

    collection do
      get :balances_by_day
    end
  end

  resources :accounts

  resources :income_sources

  root	'static_pages#home'
  get	'home'	=>	'static_pages#home'

  resources :categories

  devise_for :users
  resources :users, only: [:show, :index, :update] do
    member do
      get :add_contributor
      get :remove_contributor
    end
  end

  resources :spendings do
    collection do
      get :spendings_by_month
      get :spendings_by_category
      get :spendings_by_payment_method
      get :spendings_by_payment_method_type
      get :cc_purchase_vs_payment
    end
  end

  resources :budgets do
    collection do
      get :budgets_by_month
      get :spendings_by_category
    end
  end

  resources :payment_methods

  resources :debts

  resources :debt_balances do
    collection do
      get :ccs_by_month
      get :loans_by_month
      get :loans_change_by_month
    end

    member do
      get :close
    end
  end
end
