class TrailController < Sinatra::Base

  #create CRUD and RESTful routes

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/trails'
  end

  get '/trails' do #index
    @trails = Trail.all
    erb :index
  end

  get '/trails/new' do #new
    erb :new
  end

  post '/trails' do #create
    @trail = Trail.create(params)
    redirect "/trails/#{@trail.id}"
  end

  get '/trails/:id' do #show
    @trail = Trail.find(params[:id])
    erb :show
  end

  get '/trails/:id/edit' do #edit
    @trail = Trail.find_by_id(params[:id])
    erb :edit
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
