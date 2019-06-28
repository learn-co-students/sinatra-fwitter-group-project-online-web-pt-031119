class TweetsController < ApplicationController

	get '/tweets/:id' do
		if session[:id] != nil
			@tweet = Tweet.find_by(id: params[:id])
			erb :'/tweets/show_tweet'
		else
			redirect '/login'
		end
	end
end
