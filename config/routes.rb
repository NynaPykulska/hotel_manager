Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/dayLog/list')
   
   post 'dayLog/list', to: 'memo#list'
   get 'roomStatus/list/:group', to: 'room#list'
   get 'issues/list/:group', to: 'issue#list'

   get 'dayLog/list', to: 'memo#list'
   get 'memo/new'
   post 'memo/new'
   post 'memo/create'
   post 'room/create'
   post 'issue/create'
   patch 'memo/update'
   get 'memo/show'
   get 'memo/edit'
   get 'memo/delete'
   get 'memo/update'
   get 'memo/show_subjects'
   get 'memo/mark_ready'

end
