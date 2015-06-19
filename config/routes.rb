Rails.application.routes.draw do
  resources :employees
  resources :managers
  get '/daily_reports/unit/:name', controller: 'employees', action: 'unit_show', as: :unit_show
  get '/daily_reports/:access_token', controller: "employees", action: 'daily_report', as: :employee_report
  post '/daily_reports/:access_token/update', controller: "employees", action: 'update_daily_report', as: :update_employee_report
  post '/daily_reports/:employee_id/new', controller: "employees", action: 'email_report', as: :email_employee_report
  get '/admin/daily_reports/:id', controller: "employees", action: 'show_daily_report', as: :daily_report

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
