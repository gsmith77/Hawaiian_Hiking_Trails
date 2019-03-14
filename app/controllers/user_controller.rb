class UserController < ApplicationController

  #create CRUD and RESTful routes

  get '/' do
    erb :'/registrations/signup'
  end

  post '/account_creation' do
    @user = User.create(email: params[:user][:email], password: params[:user][:password])
    @user = current_user
    session[:id] = @user.id
    redirect '/account'
  end

  post '/login' do
    @user = User.find_by(:email => params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      current_user = @user
      session[:id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    @user = current_user
    if @user
      @user
      @trails = @user.trails
      erb :account
    else
      erb :error
    end
  end

  #test to see if any of the fields are empty and if they are empty then just make it go to account/details to show all of the exisiting trails

  get '/logout' do
    session.clear
    current_user != @user
    redirect '/'
  end


end
