require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :home
  end

  get '/signup' do
    redirect '/tweets' if logged_in?
    erb :signup
  end

  post '/signup' do
    if empty_fields?(params.values) 
      redirect '/signup'
    else 
      user = User.create(params)
      login(user.username, user.password)

      redirect '/tweets'
    end
  end

  get '/login' do 
    if logged_in?
      redirect '/tweets'
    else  
      erb :'/login'
    end
  end

  post '/login' do 
      if empty_fields?(params.values)
          redirect '/login'
      else 
          login(params[:username], params[:password])

          redirect '/tweets'
      end
  end

  get '/logout' do
      if logged_in?
          session.clear
          redirect '/login'
      else
          redirect '/'
      end
  end


  helpers do
    def empty_fields?(inputs)
      inputs.any? {|input| input==""}
    end

    def login(username, password)
      user = User.find_by(username: username)
      if user && user.authenticate(password)
        session[:email] = user.email
      else
        redirect '/login'
      end
    end

    def current_user
      User.find_by(email: session[:email]) if session[:email]
    end

    def logged_in?
      !!current_user
    end
  end

end
