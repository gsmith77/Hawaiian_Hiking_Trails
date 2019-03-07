class UserController < Sinatra::Base

  #create CRUD and RESTful routes


  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/registrations/signup'
  end

  post '/login' do
    if User.find_by(:email => params[:user][:email])
      @user = User.find_by(:email => params[:user][:email])
    else
      @new_user = User.create(email: params[:user][:email], password_digest: params[:user][:password_digest])
    end
    @trail = Trail.all
    if @user != nil && @user.password_digest == params[:user][:password_digest]
      session[:user_id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    #binding.pry
    @user = User.find_by_id(session[:user_id])
    @trails = Trail.all
    if @user
      @user
      erb :account
    else
      erb :error
    end
  end

  post '/account/details' do
    @user = User.find_by(session[:user_id])
    binding.pry
    if !params.empty?
       @user.trails << Trail.create(name: params[:user][:trail][:name], length: params[:user][:trail][:length],
      duration: params[:user][:trail][:duration], location: params[:user][:trail][:location],
      difficulty: params[:user][:trail][:difficulty], user_id: @user.id)
    end
    @trails = Trail.all
    erb :show
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
