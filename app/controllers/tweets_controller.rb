class TweetsController < ApplicationController

  get '/tweets' do #index
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do #form for new tweets
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  post '/tweets' do #new tweet
    if params[:content] != ""
      @tweet = Tweet.new(params)
      @tweet.user = current_user
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do #show
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do #load form for edit
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :"tweets/edit_tweet"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do #patch edit
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] != ''
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do #delete
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
        redirect "/tweets"
    else
      redirect "/login"
    end
  end

end
