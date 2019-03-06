class TrailController < Sinatra::Base

  #create CRUD and RESTful routes

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/trails'
  end

  get '/trails' do
    @trails = Trail.all
    erb :index
  end

  get '/trails/new' do
    erb :new
  end

  post '/trails' do
    @trail = Trail.create(params)
    redirect "/trails/#{@trail.id}"
  end

  get '/trails/:id' do
    @trail = Trail.find(params[:id])
    erb :show
  end


end
