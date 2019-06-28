require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "test"
  end

  get '/' do   #homepage
    erb :index
  end 

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      if session[:user_id] 
        @current_user = User.find_by(session[:user_id])
      end   
    end
  end 
end
