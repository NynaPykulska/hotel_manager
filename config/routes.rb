Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/dayLog/list')
  resources :memos
  resources :issues
   
   post 'dayLog/list', to: 'memos#list'
   get 'roomStatus/list', to: 'room#list'
   get 'issueLog/list', to: 'issues#list'
   get 'dayLog/memos/mark_ready', to: 'memos#mark_ready'
   get 'issueLog/issue/mark_ready', to: 'issues#mark_ready'
   get 'dayLog/memos/reopen', to: 'memos#reopen'
   get 'issueLog/issue/reopen', to: 'issues#reopen'
   get 'dayLog/memos/delete', to: 'memos#delete'
   get 'issueLog/issue/delete', to: 'issues#delete'
   get 'dayLog/memos/delete_recurrence', to: 'memos#delete_recurrence'

   get 'dayLog/list', to: 'memos#list'
   get 'memos/new'
   post 'memos/new', to: 'memos#create'
   post 'memos/create'
   post 'room/create'
   post 'issues/create'
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
