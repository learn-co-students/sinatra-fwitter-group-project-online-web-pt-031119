class UsersController < ApplicationController

    get '/signup' do
        if !logged_in? 
            erb :'users/signup'
        else
            redirect to '/tweets'
        end 
    end 

    post '/signup' do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?  
            @user = User.new(params)
            @user.save
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end          
    end 


end
