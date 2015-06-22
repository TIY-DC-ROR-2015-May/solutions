class AddMetroStations < ActiveRecord::Migration
  def change
    create_table "metro_stations" do |t|
      t.string "code"
      t.string "name"
      t.float  "lat"
      t.float  "long"
      t.text   "address"
    end
  end
end
