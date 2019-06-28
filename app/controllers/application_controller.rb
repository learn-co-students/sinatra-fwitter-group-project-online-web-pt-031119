require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
   		set :session_secret, "secret"
  end

  get '/' do
  	erb :index
  end

  get '/signup/' do
  	if session[:id] == nil
		erb :'/users/signup'
	else
		redirect '/tweets'
	end
  end

  post '/signup' do
	if params[:username] != "" && params[:email] != "" && params[:password] != ""
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		session[:id] = @user.id  #Signs in user after creating an account
		redirect '/tweets'
	else
		redirect '/signup'
	end	
  end	

  get '/login' do
  	if session[:id] == nil
  		erb :'/users/login'
  	else
  		redirect '/tweets'  #placeholder until individual show page is created
  	end
  end

  post '/login' do
  	if @user = User.find_by(username: params[:username], password: params[:password])
  		session[:id] = @user.id
  		redirect '/tweets'  #placeholder until individual show page is created
  	else
  		redirect '/login'
  	end
  end

  get '/logout' do
  	if session[:id] != nil
  		session.clear
  		redirect '/login'
  	else
  		redirect '/'
  	end
  end

  get '/tweets' do
  	if session[:id] != nil
  		@user = Helpers.current_user(session)
  		erb :'/tweets/tweets'
  	else
  		redirect '/login'
  	end
  end
end
