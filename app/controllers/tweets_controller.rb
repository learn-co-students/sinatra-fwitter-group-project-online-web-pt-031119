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
			@user = Helpers.current_user(session)
			erb :'/tweets/new'
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		user = Helpers.current_user(session)
		if params[:content] != ""
			tweet = Tweet.create(content: params[:content], user_id: user.id)
			redirect "/tweets/#{tweet.id}"
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/:id/edit' do
		if Helpers.is_logged_in?(session)
			@user = Helpers.current_user(session)
			@tweet = Tweet.find_by(id: params[:id])
			if @tweet.user_id == @user.id
				erb :'/tweets/edit_tweet'
			else
				redirect '/tweets'
			end
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id' do
		if Helpers.is_logged_in?(session) && params[:content] != ""
			@tweet = Tweet.find_by(id: params[:id])
			@tweet.update(content: params[:content])
			redirect "/tweets/#{@tweet.id}"
		else
			redirect "/tweets/#{params[:id]}/edit"
		end
	end
	

	delete '/tweets/:id/delete' do
		@user = Helpers.current_user(session)
		@tweet = Tweet.find_by(id: params[:id])	
		if @tweet.user_id == @user.id
			@tweet.destroy
			redirect '/tweets'
		else
			redirect '/tweets'
		end
  	end

	get '/tweets/:id' do
		if Helpers.is_logged_in?(session)
			@user = Helpers.current_user(session)
			@tweet = Tweet.find_by(id: params[:id])
			erb :'/tweets/show_tweet'
		else
			redirect '/login'
		end
	end
end
