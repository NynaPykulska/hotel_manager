Rails.application.routes.draw do
  get 'manager/issues', to: 'manager#issues', as: 'issues'
  get 'manager/dayLog', to: 'manager#dayLog', as: 'day_log'
  get 'manager/roomStatus', to: 'manager#roomStatus', as: 'room_status'
  get 'manager/employees', to: 'manager#employees', as: 'employees'

  root 'manager#issues'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   get 'memo/list'
   get 'memo/new'
   post 'memo/create'
   patch 'memo/update'
   get 'memo/list'
   get 'memo/show'
   get 'memo/edit'
   get 'memo/delete'
   get 'memo/update'
   get 'memo/show_subjects'

end
