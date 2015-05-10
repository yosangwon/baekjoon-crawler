Rails.application.routes.draw do
  root 'problems#index'
  
  get ':data/(:sort)' => 'problems#sort'
  get 'crawl' => 'problems#crawl'
end
