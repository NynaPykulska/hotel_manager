Rails.application.routes.draw do
  get '/issues', to: 'manager#issues', as: 'issues'
  get '/dayLog', to: 'manager#dayLog', as: 'day_log'
  get '/roomStatus', to: 'manager#roomStatus', as: 'room_status'
  get '/employees', to: 'manager#employees', as: 'employees'

  root 'manager#dayLog'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   get 'memo/list'
   get 'memo/new'
   post 'memo/create'
   patch 'memo/update'
   get 'memo/list'
   get 'memo/list_open'
   get 'memo/list_ready'
   get 'memo/show'
   get 'memo/edit'
   get 'memo/delete'
   get 'memo/update'
   get 'memo/show_subjects'

end
