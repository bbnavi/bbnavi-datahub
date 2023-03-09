 SELECT geo_locations.coords,
    CONCAT('bike_rentals_', attractions.id) as id,
    attractions.id as datahub_id,
    attractions.name,
    categories.svg_icon,
    tags.name AS tag_name
   FROM attractions
     JOIN taggings ON taggings.taggable_id = attractions.id AND taggings.taggable_type::text = 'Attraction'::text AND taggings.context::text = 'tags'::text
     JOIN tags ON tags.id = taggings.tag_id
     JOIN addresses ON addresses.addressable_id = attractions.id AND addresses.addressable_type::text = 'Attraction'::text
     JOIN geo_locations ON geo_locations.geo_locateable_id = addresses.id AND geo_locations.geo_locateable_type::text = 'Address'::text
     JOIN data_resource_categories data_resource_categories_attractions_join ON data_resource_categories_attractions_join.data_resource_id = attractions.id AND data_resource_categories_attractions_join.data_resource_type::text = 'PointOfInterest'::text
     JOIN categories ON categories.id = data_resource_categories_attractions_join.category_id
     JOIN data_resource_categories ON attractions.id = data_resource_categories.data_resource_id
  WHERE attractions.visible = true AND attractions.type::text = 'PointOfInterest'::text AND data_resource_categories.category_id = 15 AND data_resource_categories.data_resource_type::text = 'PointOfInterest'::text AND tags.name::text = 'Fahrradvermietung'::text;
