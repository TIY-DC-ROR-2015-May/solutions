require 'sinatra/base'
require 'tilt/erubis' # Fixes a warning
require 'rack/cors'

require 'haversine'
require 'httparty'

require 'pry'

require './db/setup'
require './lib/all'


class IronRail < Sinatra::Base
  enable :logging

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :get
    end
  end

  before do
    headers["Content-Type"] = "application/json"
  end

  get "/v1" do
    lat, long, rad = params[:latitude], params[:longitude], params[:radius]
    bikes  = BikeshareStation.nearby lat, long, rad
    metros = MetroStation.nearby lat, long, rad

    results = { locations: bikes + metros }
    return results.to_json
  end
end

IronRail.run! if $PROGRAM_NAME == __FILE__
