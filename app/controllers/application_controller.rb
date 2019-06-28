require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
   		set :session_secret, "secret"
	end
  end

  get '/' do
  	erb :index
  end

  get '/signup' do
	erb :'users/signup'
  end

  post '/signup' do
	if params[:username] != "" && params[:email] != "" && params[:password] != ""
		@user = User.create(username: params[:username], email: params[:email], password: params[:password])
		redirect '/tweets'
	else
		redirect '/signup'
	end	
  end	

  get '/login' do
  	if session[:id] = ""
  		erb :login
  	else
  		redirect '/tweets'  #placeholder until individual show page is created
  	end
  end

  post '/login' do
  	if @user = User.find_by(email: params[:email], password: params[:password])
  		session[:id] = @user.id
  		redirect 'login/:id'  #placeholder until individual show page is created
  	else
  		redirect '/login'
  	end
  end

  get '/logout' do
  	if session[:id] != ""

  	else
  		redirect '/'
  	end

  	redirect '/login'
  end

  get '/tweets' do
  	if session[:id] != ""
  		erb :index
  	else
  		redirect '/login'
  	end
end
