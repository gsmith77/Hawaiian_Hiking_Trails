class UserController < Sinatra::Base

  #create CRUD and RESTful routes

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  
end
