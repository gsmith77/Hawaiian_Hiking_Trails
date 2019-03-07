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
    @new_user = User.create(email: params[:user][:email], password_digest: params[:user][:password_digest])
    @user = User.find_by(:email => params[:user][:email])
    if @user != nil && @user.password_digest == params[:user][:password_digest]
      session[:user_id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    if @user
      @user
      erb :account
    else
      erb :error
    end
  end

  post '/account/details' do
    @user = User.find_by(session[:user_id])
    @trail = Trail.create(name: params[:trail][:name], length: params[:trail][:length],
      duration: params[:trail][:duration], location: params[:trail][:location],
      difficulty: params[:trail][:difficulty], user_id: @user.id)
    @trails = Trail.all
    erb :show
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
