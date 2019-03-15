class TrailController < ApplicationController


  get '/trails' do #index
    @trails = Trail.all

    erb :'/trails/index'
  end

  get '/trails/new' do #new
    redirect_if_not_logged_in
    erb :'/trails/new'
  end

  post '/trails' do #create
    redirect_if_not_logged_in
    @trail = current_user.trails.create(trail_params)
    if @trail.valid?
      redirect "/trails/#{@trail.id}"
    else
      erb :'/trails/new'
    end
  end

  get '/trails/:id' do #show
    @trail = Trail.find(params[:id])
    erb :'trails/show'
  end

  get '/trails/:id/edit' do #edit
    redirect_if_not_logged_in
    @trail = Trail.find_by_id(params[:id])
    erb :'trails/edit'
  end

  patch '/trails/:id' do #update
    redirect_if_not_logged_in
    @trail = Trail.find_by_id(params[:id])
    if @trail && @trail.user == current_user
      @trail.name = params[:name]
      @trail.length = params[:length]
      @trail.duration = params[:duration]
      @trail.location = params[:location]
      @trail.difficulty = params[:difficulty]
      @trail.save
    end
    redirect "/trails/#{@trail.id}"
  end

  delete '/trails/:id/delete' do #delete
    @trail = Trail.find_by_id(params[:id])
    redirect_if_not_logged_in && current_user.trails.include?(@trail)
    if @trail && @trail.user == current_user
      @trail = Trail.delete(params[:id])
      redirect '/trails'
    end
    redirect '/account'
  end

end
