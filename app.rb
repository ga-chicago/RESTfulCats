require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'restfulcats'
)

# does our model and sinatra work? let's see...
get '/' do
  # cat = Cat.create({ :name => 'Adventure Kitty', :breed => 'ORANGE CAT' }).to_json

  # @cat = Cat.new
  # @cat.name = 'Bidala'
  # @cat.breed = 'persian'
  # @cat.save
  # @cat.to_json
end

## OK, we need an API... because the internet needs us

# GET: List
get '/api/cats' do
  Cat.all.to_json
end

# GET: By Id
get '/api/cats/:id' do
  puts params
  Cat.find(params[:id]).to_json
end

# POST: Create
post '/api/cats' do
  puts params
  Cat.create({
    :name => params[:name],
    :breed => params[:breed]
  }).to_json
end

# PATCH: Update by Id
# you should never, ever, ever ever ever...
# update the ID of a model (table row)
patch '/api/cats/:id' do
  cat_args = { :name => params[:name], :breed => params[:breed] }
  # this is similar to the following in rails..
  # params.require(:cat).permit(:name, :breed)

  @cat = Cat.find(params[:id])
  @cat.update(cat_args)
  @cat.to_json

end

put '/api/cats/:id' do
  cat_args = { :name => params[:name], :breed => params[:breed] }
  # this is similar to the following in rails..
  # params.require(:cat).permit(:name, :breed)

  @cat = Cat.find(params[:id])
  @cat.update(cat_args)
  @cat.to_json

end

delete '/api/cats/:id' do
  Cat.destroy(params[:id]).to_json
end
