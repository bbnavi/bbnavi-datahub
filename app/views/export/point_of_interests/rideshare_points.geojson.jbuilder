json.type "FeatureCollection"
json.features do
  json.array! @rideshare_points.each do |rideshare_point|
    address = rideshare_point.addresses.first
    next if address.blank? || address.geo_location.blank? || address.geo_location.coordinates.blank?

    json.type "Feature"
    json.id rideshare_point.external_id
    json.properties do
      json.name rideshare_point.name
      json.description rideshare_point.description
      json.type rideshare_point.categories.map(&:name).join(", ")
      json.address do
        json.street address.try(:street)
        json.zip address.try(:zip)
        json.city address.try(:city)
        json.kind address.try(:kind)
        json.addition address.try(:addition)
      end
      osm = rideshare_point.open_street_map
      json.open_street_map do
        json.parking osm.try(:parking)
        json.capacity osm.try(:capacity)
        json.capacity_charging osm.try(:capacity_charging)
        json.capacity_disabled osm.try(:capacity_disabled)
        json.surface osm.try(:surface)
        json.fee osm.try(:fee)
        json.website osm.try(:website)
        json.lit osm.try(:lit)
        json.shelter osm.try(:shelter)
        json.utilization osm.try(:utilization)
      end
      json.contact do
        json.first_name rideshare_point.contact.try(:first_name)
        json.last_name rideshare_point.contact.try(:last_name)
        json.email rideshare_point.contact.try(:email)
        json.phone rideshare_point.contact.try(:phone)
        json.fax rideshare_point.contact.try(:fax)
        json.web_url do
          json.url rideshare_point.contact.try(:web_url).try(:url)
          json.description rideshare_point.contact.try(:web_url).try(:description)
        end
        json.media_contents rideshare_point.media_contents.each do |media_content|
          json.url media_content.try(:source_url).try(:url)
          json.copyright media_content.copyright
          json.content_type media_content.content_type
        end
      end
    end
    json.geometry do
      json.type "Point"
      json.coordinates address.try(:geo_location).try(:coordinates)
    end
  end
end
