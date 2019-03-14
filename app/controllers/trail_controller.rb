class TrailController < ApplicationController

  #create CRUD and RESTful routes

  get '/trails' do #index
    @trails = Trail.all

    erb :'/trails/index'
  end

  get '/trails/new' do #new
    erb :'/trails/new'
  end

  post '/trails' do #create
    current_user.trails.create(params)

    redirect "/account"
  end

  get '/trails/:id' do #show
    @trail = Trail.find(params[:id])
    erb :'trails/show'
  end

  get '/trails/:id/edit' do #edit
    @trail = Trail.find_by_id(params[:id])
    erb :'trails/edit'
  end

  patch '/trails/:id' do #update
    @trail = Trail.find_by_id(params[:id])
    @trail.name = params[:name]
    @trail.length = params[:length]
    @trail.duration = params[:duration]
    @trail.location = params[:location]
    @trail.difficulty = params[:difficulty]
    @trail.save
    redirect "/trails/#{@trail.id}"
  end

  delete '/trails/:id/delete' do #delete
    @trail = Trail.delete(params[:id])
    redirect '/trails'

    #flash message to show the trail has been deleted and to say that it will now
    #show all Trails on the Webstie
  end

end
