class TweetsController < ApplicationController

    get '/tweets' do
        if @current_user = current_user
            @tweets = Tweet.all
            erb :'/tweets/index'
        else 
            redirect '/login'
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'/tweets/new'
        else  
            redirect '/login'
        end
    end

    post '/tweets' do 
        if params[:content] != ""
            tweet = Tweet.create(content: params[:content])
            tweet.user = current_user
            tweet.save
        else  
            redirect '/tweets/new'
        end
    end

    delete '/tweets/:id' do 
        if logged_in?
            tweet = Tweet.find_by(id: params[:id])
            if tweet.user == current_user 
                tweet.destroy 
            else  
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? 
            @tweet = Tweet.find_by(id: params[:id])
            erb :'/tweets/edit'
        else  
            redirect '/login'
        end
    end
    
    patch '/tweets/:id' do 
        tweet = Tweet.find_by(id: params[:id])
        if params[:content] != ""
            tweet.update(content: params[:content]) 
        else  
            redirect "/tweets/#{tweet.id}/edit"
        end
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by(id: params[:id])
            erb :'/tweets/show'
        else  
            redirect '/login' 
        end
    end

end
