class UpdatePoiCoordsEBikeChargingStationsToVersion4 < ActiveRecord::Migration[5.2]
  def change
    update_view :poi_coords_e_bike_charging_stations, version: 4, revert_to_version: 3
  end
end
