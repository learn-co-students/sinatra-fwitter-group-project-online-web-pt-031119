require './config/environment'
class ApplicationController < Sinatra::Base
  # register Sinatra::ActiveRecordExtension
  # set :views, Proc.new { File.join(root, "../views/") }


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if !logged_in?
      erb :'users/home'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
