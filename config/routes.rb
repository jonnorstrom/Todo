Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get     'tasks' => 'tasks#index'
  get     'tasks/new' => 'tasks#new'
  post    'tasks/new' => 'tasks#create'

  get     'tasks/:id' => 'tasks#show'
  patch   'tasks/:id' => 'tasks#update'
  put     'tasks/:id' => 'tasks#update'
  delete  'tasks/:id' => 'tasks#destroy'

  get     'tasks/edit/:id' => 'tasks#edit'

end
