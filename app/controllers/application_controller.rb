class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/recipes' do
    @recipe = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes/new' do
    @recipe = Recipe.create(name: params[:name], 
    ingredients: params[:ingredients], cook_time: params[:cook_time])
      #@recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update(name: params[:name])
    redirect "/recipes/show/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id]) #finding the "recipe"
    @recipe.delete                             #delete the object
  end
end
