require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
   		set :session_secret, "secret"
  end

  get '/' do
  	if Helpers.is_logged_in?(session)
  		redirect '/tweets'
  	else
  		erb :index
  	end
  end

  get '/signup' do
  	if session[:user_id] == nil
		erb :'/users/signup'
	else
		redirect '/tweets'
	end
  end

  post '/signup' do
	if params[:username] != "" && params[:email] != "" && params[:password] != ""
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		session[:user_id] = @user.id  #Signs in user after creating an account
		redirect '/tweets'
	else
		redirect '/signup'
	end	
  end	

  get '/login' do
  	if session[:user_id] == nil
  		erb :'/users/login'
  	else
  		redirect '/tweets'  #placeholder until individual show page is created
  	end
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect '/tweets'  
  	else
  		redirect '/login'
  	end
  end


  get '/logout' do
  	if session[:user_id] != nil
  		session.clear
  		redirect '/login'
  	else
  		redirect '/'
  	end
  end

  get '/tweets' do
  	if session[:user_id] != nil
  		@user = Helpers.current_user(session)
  		erb :'/tweets/tweets'
  	else
  		redirect '/login'
  	end
  end
end
