Rails.application.routes.draw do
  resources :image_containers
  devise_for :admins
  get 'welcome/doc'
  get 'welcome/about'
  get 'welcome/home'
  get 'welcome/resize_icons'
  post 'welcome/home'
  get 'welcome/set_local_session_tz'
  get 'welcome/gallery_name_filter'
  get 'welcome/modal_image_resize'
  get 'pictures/modal_picture_annotate'
  get 'galleries/remove_gallery_picture'
  get 'galleries/add_gallery_pictures'
#  get "galleries/manage" => 'galleries#manage' , as => :manage
  resources :galleries
  resources :gallery_pictures
  resources :pictures

  get 'manage' , to: 'galleries#manage'    #This syntax needed to not require 'id'
  root 'welcome#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
