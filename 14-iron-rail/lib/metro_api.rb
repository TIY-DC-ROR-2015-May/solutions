require 'httparty'

class MetroAPI
  include HTTParty
  base_uri "https://api.wmata.com/"
  default_options[:query] = { api_key: ENV["WMATA_KEY"] }

  def self.create_stations!
    response = get "/Rail.svc/json/jStations"
    response["Stations"].each do |s|
      MetroStation.where(
        code:    s["Code"],
        name:    s["Name"],
        lat:     s["Lat"],
        long:    s["Lon"],
        address: s["Address"].to_json
      ).first_or_create!
    end
  end

  def self.upcoming_trains code
    response = get "/StationPrediction.svc/json/GetPrediction/#{code}"
    trains = response["Trains"] || [] # FIXME: this might happen if the request errors
    trains.map { |t| MetroTrain.new(t) }
  end
end
