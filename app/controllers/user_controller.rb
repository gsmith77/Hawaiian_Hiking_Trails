class UserController < ApplicationController

  get '/' do
    erb :'/registrations/signup'
  end

  post '/account_creation' do

    if !User.all.find_by(email: params[:user][:email])
      @user = User.create(email: params[:user][:email], password: params[:user][:password])
      session[:id] = @user.id
      redirect '/account'
    end
    erb :error
  end

  post '/login' do
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    redirect_if_not_logged_in
    @user = current_user
    if @user
      @user
      @trails = @user.trails
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
