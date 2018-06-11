class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect '/lattes'
    else !logged_in?
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else User.find_by(username: username)
      flash[:message] = "This username is not available"
      redirect to '/signup'
    end
  end

  get '/login' do
    if session[:user_id]
      flash[:message] = "You're already logged in!"

      redirect '/lattes'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome #{@user.username}!"

      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    erb :'/users/show'
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
