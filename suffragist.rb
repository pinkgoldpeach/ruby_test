require 'sinatra'
require 'yaml/store'

	Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
  'QUI' => 'Quiche',
  'KAE' => 'Kässpätzle',
  'JAU' => 'Jause',
  'POM' => 'Pommes'
}


get '/' do
	@title = 'Welcome to the Suffragist!'
erb :index
end

post '/cast' do
  @title = 'Thanks for casting your vote! Are you hungry now?'
  
  @vote  = params['vote']
  if @vote == 'POM'
  	redirect 'http://mcdonalds.at/'
  end
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/hello' do

end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end