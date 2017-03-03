Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/dayLog/list')
  resources :memos
   
   post 'dayLog/list', to: 'memos#list'
   get 'roomStatus/list/:group', to: 'room#list'
   get 'issues/list', to: 'issue#list'
   get 'dayLog/memos/mark_ready', to: 'memos#mark_ready'
   get 'issues/issue/mark_ready', to: 'issue#mark_ready'
   get 'dayLog/memos/reopen', to: 'memos#reopen'
   get 'issues/issue/reopen', to: 'issue#reopen'
   get 'dayLog/memos/delete', to: 'memos#delete'
   get 'issues/issue/delete', to: 'issue#delete'
   get 'dayLog/memos/delete_recurrence', to: 'memos#delete_recurrence'

   get 'dayLog/list', to: 'memos#list'
   get 'memos/new'
   post 'memos/new'
   post 'memos/create'
   post 'room/create'
   post 'issue/create'
   patch 'memos/update'
   get 'memos/show'
   get 'memos/edit'
   get 'memos/delete'
   get 'memos/delete_recurrence'
   get 'memos/update'
   get 'memos/show_subjects'
   get 'memos/mark_ready'
   get 'memos/reopen'


end
