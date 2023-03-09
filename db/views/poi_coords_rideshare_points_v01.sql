 SELECT geo_locations.coords,
    attractions.external_id as id,
    attractions.id as datahub_id,
    attractions.name,
    categories.svg_icon
   FROM attractions
     JOIN addresses ON addresses.addressable_id = attractions.id AND addresses.addressable_type::text = 'Attraction'::text
     JOIN geo_locations ON geo_locations.geo_locateable_id = addresses.id AND geo_locations.geo_locateable_type::text = 'Address'::text
     JOIN data_resource_categories data_resource_categories_attractions_join ON data_resource_categories_attractions_join.data_resource_id = attractions.id AND data_resource_categories_attractions_join.data_resource_type::text = 'PointOfInterest'::text
     JOIN categories ON categories.id = data_resource_categories_attractions_join.category_id
     JOIN data_resource_categories ON attractions.id = data_resource_categories.data_resource_id
  WHERE attractions.type::text = 'PointOfInterest'::text
    AND attractions.visible = true
    AND (data_resource_categories.category_id = 101 OR data_resource_categories.category_id = 102 OR data_resource_categories.category_id = 103 OR data_resource_categories.category_id = 104)
    AND data_resource_categories.data_resource_type::text = 'PointOfInterest'::text;
