class UserController < ApplicationController

  #create CRUD and RESTful routes

  get '/' do
    erb :'/registrations/signup'
  end

  post '/account_creation' do
    @user = User.create(email: params[:user][:email], password_digest: params[:user][:password_digest])
    session[:id] = @user.id
    redirect '/account'
  end

  post '/login' do
    @user = User.find_by(:email => params[:user][:email])
    #how to turn params[:password] into password_digest so that the two match inside of User.all
    if @user != nil && @user.password_digest == params[:user][:password_digest]
      session[:id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    @user = current_user
    binding.pry
    if @user
      @user
      @trails = @user.trails
      erb :account
    else
      erb :error
    end
  end

  post '/account/details' do
    current_user
    if !params[:user][:trail].values.include?("")
      if !@user.trails.find_by(params[:user][:trail])
          @trail = Trail.create(name: params[:user][:trail][:name], length: params[:user][:trail][:length],
          duration: params[:user][:trail][:duration], location: params[:user][:trail][:location],
          difficulty: params[:user][:trail][:difficulty], user_id: @user.id)
        @user.trails << @trail
      end
    end
    @trails = @user.trails
    erb :show
  end

  #test to see if any of the fields are empty and if they are empty then just make it go to account/details to show all of the exisiting trails

  get '/logout' do
    session.clear
    redirect '/'
  end


end
