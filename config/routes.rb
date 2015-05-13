Rails.application.routes.draw do
  root 'problems#index'
  
  get 'crawl' => 'problems#crawl'
  get 'folder/(*folder)' => 'folder#index', as: 'folder'
  get ':data/(:sort)' => 'problems#sort'
end
