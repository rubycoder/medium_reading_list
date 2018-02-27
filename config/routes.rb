Rails.application.routes.draw do
  root 'pages#home'
  get 'tag/:tag', to: 'pages#scrap'
end
