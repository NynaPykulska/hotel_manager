Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/dayLog/list')
   
   post 'dayLog/list', to: 'memo#list'
   get 'roomStatus/list/:group', to: 'room#list'
   get 'issues/list', to: 'issue#list'
   get 'dayLog/memo/mark_ready', to: 'memo#mark_ready'
   get 'issues/issue/mark_ready', to: 'issue#mark_ready'
   get 'dayLog/memo/reopen', to: 'memo#reopen'
   get 'issues/memo/reopen', to: 'issue#reopen'
   get 'dayLog/memo/delete', to: 'memo#delete'
   get 'dayLog/memo/delete_recurrence', to: 'memo#delete_recurrence'

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
   get 'memo/delete_recurrence'
   get 'memo/update'
   get 'memo/show_subjects'
   get 'memo/mark_ready'
   get 'memo/reopen'


end
