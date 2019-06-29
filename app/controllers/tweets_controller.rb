class TweetsController < ApplicationController

	get '/tweets' do
	  	if session[:user_id] != nil
	  		@user = Helpers.current_user(session)
	  		erb :'/tweets/tweets'
	  	else
	  		redirect '/login'
	  	end
  	end

	get '/tweets/new' do
		if Helpers.is_logged_in?(session)
			erb :'/tweets/new'
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		if params[:content] != ""
			tweet = Tweet.create(content: params[:content], user_id: Helpers.current_user.id)
			redirect "/tweets/#{tweet.id}"
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/edit' do
	
	end

	get '/tweets/delete' do
	
	end

	get '/tweets/:id' do
		if Helpers.is_logged_in?(session)
			binding.pry
			@user = Helpers.current_user(session)
			@tweet = Tweet.find_by(id: params[:id])
			erb :'/tweets/show_tweet'
		else
			redirect '/login'
		end
	end
end
