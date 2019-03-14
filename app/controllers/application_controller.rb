require './config/environment'

class ApplicationController < Sinatra::Base


#watch Dakota's video to make the session_secret actually secret
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    #This method should use the user_id from the
    #session hash to find the user in the database and return that user.
    def current_user
      @user = User.find_by(id: session[:id])
    end

    def is_logged_in?
      !!current_user
    end

    def trail_params
      params.select do |k, v|
      ["name", "length", "duration", "location", "difficulty"].include?(k)
      end
    end
  end


end
