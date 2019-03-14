class TrailController < ApplicationController


  get '/trails' do #index
    @trails = Trail.all

    erb :'/trails/index'
  end

  get '/trails/new' do #new
    erb :'/trails/new'
  end

  post '/trails' do #create
    current_user
    if !params.values.include?("")
      @trail = current_user.trails.create(params)
    else
      redirect '/account'
    end

    redirect "/trails/#{@trail.id}"
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
  end

end
