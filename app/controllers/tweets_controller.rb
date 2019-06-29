class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in? 
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect to '/login'
        end 
    end 

    get '/tweets/new' do   # new
        if logged_in?
            erb :'tweets/new' 
        else 
            redirect to '/login'
        end 
    end 

    post '/tweets' do      # create 
        @tweet = Tweet.new(params)
        @tweet.user = current_user
        @tweet.save
        redirect to '/tweets'
    end  

end
