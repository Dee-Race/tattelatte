class LattesController < ApplicationController

  get '/lattes' do
    if logged_in?
      @lattes = Latte.all
      erb :'/lattes/lattes'
    else
      redirect '/login'
    end
  end

  post '/lattes' do
    if logged_in?
      @latte = Latte.create(name: params[:name], flavor: params[:flavor], size: params[:size], description: params[:description], user_id: current_user.id)
      redirect to "/lattes/#{@latte.id}"
    else
      redirect '/'
    end
  end

  get '/lattes/new' do
    if logged_in?
      erb :'/lattes/create_latte'
    else
      redirect :'/login'
    end
  end

  get '/lattes/:id' do
    if logged_in?
      @latte = Latte.find_by_id(params[:id])
      erb :'/lattes/show'
    else
      redirect '/login'
    end
  end

  get '/lattes/:id/edit' do
    if logged_in?
      @latte = Latte.find_by_id(params[:id])
      erb :'/lattes/edit'
    else
      redirect '/login'
    end
  end

  post '/lattes/:id' do
    @latte = Latte.find_by_id(params[:id])
    redirect "/lattes/#{@latte.id}"
  end



  patch '/lattes/:id' do
    if logged_in?

      if !name.empty? && !flavor.empty? && !size.empty? && !description.empty?
        @latte = Latte.find_by_id(params[:id])
        @latte.update(name: params[:name], flavor: params[:flavor], size: params[:size], description: params[:description])
        @latte.save
        redirect to "/lattes/#{@latte.id}"
      else
        redirect "/lattes/#{@latte.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  post '/lattes/:id/delete' do
    if logged_in?
      @latte = Latte.find_by_id(params[:id])
      if @latte && current_user.id == @latte.user_id
        @latte.delete
        redirect '/lattes'
      end
    elsif !logged_in?
      redirect '/login'
    else
      redirect "/lattes/#{@latte.id}"
    end
  end

end
