class BikeshareStation
  def self.all
    BikeshareAPI.stations
  end

  def self.nearby lat, long, rad
    rad ||= 1609.34 # 1 mile, in meters
    all.select  { |station| station.distance_to(lat, long) < Float(rad) }
  end

  attr_reader :name, :lat, :long, :num_bikes, :num_empty_docks, :last_update

  def initialize api_data
    @name            = api_data.fetch "name"
    @lat             = Float(api_data.fetch "lat")
    @long            = Float(api_data.fetch "long")
    @num_bikes       = Integer(api_data.fetch "nbBikes")
    @num_empty_docks = Integer(api_data.fetch "nbEmptyDocks")
    @last_update     = Integer(api_data.fetch "latestUpdateTime") / 1000
  end

  def distance_to other_lat, other_long
    Haversine.distance(self.lat, self.long, Float(other_lat), Float(other_long)).to_meters
  end

  def as_json opts
    {
      type:            "bikeshare",
      latitude:        lat.to_s,
      longitude:       long.to_s,
      name:            name,
      num_bikes:       num_bikes,
      num_empty_docks: num_empty_docks,
      last_update:     Time.at(last_update)
    }
  end
end
