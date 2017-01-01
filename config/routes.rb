Rails.application.routes.draw do
  devise_for :users
  get '/issues', to: 'manager#issues', as: 'issues'
  get '/dayLog', to: 'manager#dayLog', as: 'day_log'
  get '/roomStatus', to: 'manager#roomStatus', as: 'room_status'
  get '/employees', to: 'manager#employees', as: 'employees'


  root to: redirect('/dayLog/list/all')
  #root 'manager#dayLog'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   
   get 'dayLog/list/:group', to: 'memo#list'
   get 'memo/new'
   post 'memo/create'
   patch 'memo/update'
   get 'memo/show'
   get 'memo/edit'
   get 'memo/delete'
   get 'memo/update'
   get 'memo/show_subjects'
   get 'memo/mark_ready'

end
