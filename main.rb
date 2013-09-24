require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'active_support/all'
require 'active_record'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/rider_and_bicycles')

# ActiveRecord::Base.establish_connection(
#   :adapter => "postgresql",
#   :host => "localhost",
#   :username => "0rkish", 
#   :password => "",
#   :database => "rider_and_bicycles"
# )

ActiveRecord::Base.logger = Logger.new(STDOUT)

class Rider < ActiveRecord::Base
	has_many :bikes
end

class Bike < ActiveRecord::Base
	belongs_to :rider
end

before do 
	@nav_riders = Rider.all
end

get '/' do
	erb :home
end

get '/riders' do
	@nav_riders = Rider.all
	erb :riders
end

get '/riders/new' do
	erb :new
end

post '/riders/create' do
	rider = Rider.new(params[:rider])
	rider.save
	redirect '/riders'
end

get '/riders/:rider_id' do

	@rider = Rider.find(params[:rider_id])
	
	erb :rider
end

get '/riders/:rider_id/edit/' do
	@rider = Rider.find(params[:rider_id])
	erb :new
end

post '/riders/:rider_id' do
	rider = Rider.find(params[:rider_id])
	rider.update_attributes(params[:rider])
	redirect '/riders'
end

post '/riders/:rider_id/delete' do
	rider = Rider.find(params[:rider_id])
	rider.destroy
	redirect '/riders'
end

get '/riders/:rider_id/new_bicycle' do
	@rider_id = params[:rider_id]
	erb :new_bicycle
end

post '/riders/:rider_id/create_bicycle' do
	id = params[:rider_id]
	rider = Rider.find(id)
	bike = rider.bikes.new
	bike.bike_type = params[:bike][:bike_type]
	bike.bike_material = params[:bike][:bike_material]
	bike.save

	redirect '/riders'
end










