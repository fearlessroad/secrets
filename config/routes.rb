Rails.application.routes.draw do
  get 'session/new'

	root 'session#new'
	post '/session/create' => 'session#create'
	post '/users/create' => 'users#create'
	get '/users/new' => 'users#new'
	get '/users/:id/edit'=> 'users#edit'
	get '/secrets' => 'secrets#index'
	get '/users/:id' => 'users#show'
	patch '/users/:id' => 'users#update'
	delete '/session'=>'session#delete'
	delete '/users/:id' =>'users#destroy'
	post '/secrets/create'=> 'secrets#create'
	delete '/secrets/:id'=> 'secrets#destroy'
	delete '/likes/:id'=>'likes#destroy'
	post '/likes/:id'=>'likes#create'
end
