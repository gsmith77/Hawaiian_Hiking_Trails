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

  get '/registrations/signup' do
    erb :signup
  end

  post '/registrations' do
    @user = User.create(email: params[:email], password: params[:password])
    session[:id] = user.id

    redirect '/users/home'
  end

  get '/' do
    erb :home
  end

  get '/sessions/login' do
    erb :'/sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/users'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end


end
