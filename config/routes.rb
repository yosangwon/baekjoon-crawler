Rails.application.routes.draw do
  root 'problems#index'
  
  get 'crawl' => 'problems#crawl'
  get ':data/(:sort)' => 'problems#sort'
end
