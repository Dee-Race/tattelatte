class UsersController < ApplicationController

  get '/signup' do
    if !session[:user_id]
      erb :'/users/new'
    else
      redirect '/lattes'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      @user.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/lattes'
    end
  end

end
