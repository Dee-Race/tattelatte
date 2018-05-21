class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/lattes'
    else !logged_in?
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect :'/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/lattes'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/lattes'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/lattes'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

end
