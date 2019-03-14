require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET')
  end

  helpers do
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

    def redirect_if_not_logged_in
      if !is_logged_in?
        redirect '/'
      end
    end
  end


end
