# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_09_152425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "accessibility_informations", force: :cascade do |t|
    t.text "description"
    t.string "types"
    t.string "accessable_type"
    t.bigint "accessable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addition"
    t.string "city"
    t.string "street"
    t.string "zip"
    t.integer "kind", default: 0
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type"
  end

  create_table "app_user_contents", force: :cascade do |t|
    t.text "content"
    t.string "data_type"
    t.string "data_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attractions", force: :cascade do |t|
    t.text "external_id"
    t.string "name"
    t.text "description"
    t.text "mobile_description"
    t.boolean "active", default: true
    t.integer "length_km"
    t.integer "means_of_transportation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", default: "PointOfInterest", null: false
    t.integer "data_provider_id"
    t.boolean "visible", default: true
    t.index ["data_provider_id"], name: "index_attractions_on_data_provider_id"
    t.index ["external_id"], name: "index_attractions_on_external_id"
    t.index ["name"], name: "index_attractions_on_name"
    t.index ["type"], name: "index_attractions_on_type"
  end

  create_table "attractions_certificates", force: :cascade do |t|
    t.bigint "attraction_id"
    t.bigint "certificate_id"
  end

  create_table "attractions_regions", force: :cascade do |t|
    t.bigint "region_id"
    t.bigint "attraction_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "tmb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.text "svg_icon"
    t.text "form_configurations"
  end

  create_table "certificates", force: :cascade do |t|
    t.string "name"
    t.bigint "point_of_interest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "fax"
    t.string "email"
    t.string "contactable_type"
    t.bigint "contactable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_blocks", force: :cascade do |t|
    t.text "title"
    t.text "intro"
    t.text "body"
    t.string "content_blockable_type"
    t.bigint "content_blockable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_providers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "always_recreate"
    t.text "roles"
    t.integer "data_type", default: 0
    t.text "notice"
  end

  create_table "data_resource_categories", force: :cascade do |t|
    t.integer "data_resource_id"
    t.string "data_resource_type"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_data_resource_categories_on_category_id"
    t.index ["data_resource_id", "data_resource_type"], name: "index_drc_on_dr_id_and_dr_type"
  end

  create_table "data_resource_settings", force: :cascade do |t|
    t.integer "data_provider_id"
    t.string "data_resource_type"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "event_records", force: :cascade do |t|
    t.integer "parent_id"
    t.bigint "region_id"
    t.text "description"
    t.boolean "repeat"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "data_provider_id"
    t.string "external_id"
    t.boolean "visible", default: true
  end

  create_table "external_references", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unique_id"
    t.integer "data_provider_id"
    t.integer "external_id"
    t.string "external_type"
  end

  create_table "fixed_dates", force: :cascade do |t|
    t.date "date_start"
    t.date "date_end"
    t.string "weekday"
    t.time "time_start"
    t.time "time_end"
    t.text "time_description"
    t.boolean "use_only_time_description", default: false
    t.string "dateable_type"
    t.bigint "dateable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generic_items", force: :cascade do |t|
    t.string "generic_type"
    t.text "author"
    t.datetime "publication_date"
    t.datetime "published_at"
    t.text "external_id"
    t.boolean "visible", default: true
    t.text "title"
    t.text "teaser"
    t.text "description"
    t.integer "data_provider_id"
    t.text "payload"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geo_locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "geo_locateable_type"
    t.bigint "geo_locateable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geometry "coords", limit: {:srid=>0, :type=>"geometry"}
    t.index ["coords"], name: "index_geo_locations_on_coords"
    t.index ["geo_locateable_id", "geo_locateable_type"], name: "index_geo_locations_on_locable_id_and_locaable_type"
    t.index ["latitude", "longitude"], name: "index_geo_locations_on_latitude_and_longitude"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "department"
    t.string "district"
    t.string "state"
    t.string "country"
    t.string "locateable_type"
    t.bigint "locateable_id"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lunch_offers", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.integer "lunch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lunches", force: :cascade do |t|
    t.text "text"
    t.integer "point_of_interest_id"
    t.string "point_of_interest_attributes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media_contents", force: :cascade do |t|
    t.text "caption_text"
    t.string "copyright"
    t.string "height"
    t.string "width"
    t.string "content_type"
    t.string "mediaable_type"
    t.bigint "mediaable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news_items", force: :cascade do |t|
    t.string "author"
    t.boolean "full_version"
    t.integer "characters_to_be_shown"
    t.datetime "publication_date"
    t.datetime "published_at"
    t.boolean "show_publish_date"
    t.string "news_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "data_provider_id"
    t.text "external_id"
    t.string "title"
    t.boolean "visible", default: true
    t.datetime "push_notifications_sent_at"
  end

  create_table "notification_devices", force: :cascade do |t|
    t.string "token"
    t.integer "device_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_notification_devices_on_token", unique: true
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.string "owner_type"
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "open_street_maps", force: :cascade do |t|
    t.string "parking"
    t.integer "capacity"
    t.string "capacity_charging"
    t.string "capacity_disabled"
    t.string "surface"
    t.string "fee"
    t.text "website"
    t.string "lit"
    t.string "shelter"
    t.string "utilization"
    t.string "osm_able_type"
    t.bigint "osm_able_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["osm_able_type", "osm_able_id"], name: "index_open_street_maps_on_osm_able_type_and_osm_able_id"
  end

  create_table "open_weather_maps", force: :cascade do |t|
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opening_hours", force: :cascade do |t|
    t.string "weekday"
    t.date "date_from"
    t.date "date_to"
    t.time "time_from"
    t.time "time_to"
    t.integer "sort_number"
    t.boolean "open"
    t.string "description"
    t.string "openingable_type"
    t.bigint "openingable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operating_companies", force: :cascade do |t|
    t.string "name"
    t.string "companyable_type"
    t.bigint "companyable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.string "name"
    t.float "amount"
    t.boolean "group_price"
    t.integer "age_from"
    t.integer "age_to"
    t.integer "min_adult_count"
    t.integer "max_adult_count"
    t.integer "min_children_count"
    t.integer "max_children_count"
    t.text "description"
    t.string "category"
    t.string "priceable_type"
    t.bigint "priceable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repeat_durations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.boolean "every_year"
    t.bigint "event_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_record_id"], name: "index_repeat_durations_on_event_record_id"
  end

  create_table "static_contents", force: :cascade do |t|
    t.string "name"
    t.string "data_type"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "version"
  end

  create_table "survey_comments", force: :cascade do |t|
    t.integer "survey_poll_id"
    t.text "message"
    t.boolean "visible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_polls", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: true
    t.integer "data_provider_id"
    t.boolean "can_comment", default: true
    t.boolean "is_multilingual", default: false
  end

  create_table "survey_questions", force: :cascade do |t|
    t.integer "survey_poll_id"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allow_multiple_responses", default: false
  end

  create_table "survey_response_options", force: :cascade do |t|
    t.integer "survey_question_id"
    t.text "title"
    t.integer "votes_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "data_provider_id"
    t.integer "role", default: 0
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "waste_device_registrations", force: :cascade do |t|
    t.string "notification_device_token"
    t.string "street"
    t.string "city"
    t.string "zip"
    t.integer "notify_days_before", default: 0
    t.time "notify_at"
    t.string "notify_for_waste_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waste_location_types", force: :cascade do |t|
    t.string "waste_type"
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waste_pick_up_times", force: :cascade do |t|
    t.integer "waste_location_type_id"
    t.date "pickup_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "web_urls", force: :cascade do |t|
    t.text "url"
    t.text "description"
    t.string "web_urlable_type"
    t.bigint "web_urlable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id", name: "active_storage_attachments_blob_id_fkey"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"

  create_view "poi_coords", sql_definition: <<-SQL
      SELECT geo_locations.coords,
      attractions.id,
      attractions.name,
      categories.svg_icon,
      tags.name AS tag_name
     FROM (((((((attractions
       JOIN taggings ON (((taggings.taggable_id = attractions.id) AND ((taggings.taggable_type)::text = 'Attraction'::text) AND ((taggings.context)::text = 'tags'::text))))
       JOIN tags ON ((tags.id = taggings.tag_id)))
       JOIN addresses ON (((addresses.addressable_id = attractions.id) AND ((addresses.addressable_type)::text = 'Attraction'::text))))
       JOIN geo_locations ON (((geo_locations.geo_locateable_id = addresses.id) AND ((geo_locations.geo_locateable_type)::text = 'Address'::text))))
       JOIN data_resource_categories data_resource_categories_attractions_join ON (((data_resource_categories_attractions_join.data_resource_id = attractions.id) AND ((data_resource_categories_attractions_join.data_resource_type)::text = 'PointOfInterest'::text))))
       JOIN categories ON ((categories.id = data_resource_categories_attractions_join.category_id)))
       JOIN data_resource_categories ON ((attractions.id = data_resource_categories.data_resource_id)))
    WHERE (((attractions.type)::text = 'PointOfInterest'::text) AND (data_resource_categories.category_id = 15) AND ((data_resource_categories.data_resource_type)::text = 'PointOfInterest'::text));
  SQL
  create_view "poi_coords_bike_rentals", sql_definition: <<-SQL
      SELECT geo_locations.coords,
      concat('bike_rentals_', attractions.id) AS id,
      attractions.id AS datahub_id,
      attractions.name,
      categories.svg_icon,
      tags.name AS tag_name
     FROM (((((((attractions
       JOIN taggings ON (((taggings.taggable_id = attractions.id) AND ((taggings.taggable_type)::text = 'Attraction'::text) AND ((taggings.context)::text = 'tags'::text))))
       JOIN tags ON ((tags.id = taggings.tag_id)))
       JOIN addresses ON (((addresses.addressable_id = attractions.id) AND ((addresses.addressable_type)::text = 'Attraction'::text))))
       JOIN geo_locations ON (((geo_locations.geo_locateable_id = addresses.id) AND ((geo_locations.geo_locateable_type)::text = 'Address'::text))))
       JOIN data_resource_categories data_resource_categories_attractions_join ON (((data_resource_categories_attractions_join.data_resource_id = attractions.id) AND ((data_resource_categories_attractions_join.data_resource_type)::text = 'PointOfInterest'::text))))
       JOIN categories ON ((categories.id = data_resource_categories_attractions_join.category_id)))
       JOIN data_resource_categories ON ((attractions.id = data_resource_categories.data_resource_id)))
    WHERE (((attractions.type)::text = 'PointOfInterest'::text) AND (data_resource_categories.category_id = 15) AND ((data_resource_categories.data_resource_type)::text = 'PointOfInterest'::text) AND ((tags.name)::text = 'Fahrradvermietung'::text));
  SQL
  create_view "poi_coords_bike_repair_shops", sql_definition: <<-SQL
      SELECT geo_locations.coords,
      concat('bike_repair_shops_', attractions.id) AS id,
      attractions.id AS datahub_id,
      attractions.name,
      categories.svg_icon,
      tags.name AS tag_name
     FROM (((((((attractions
       JOIN taggings ON (((taggings.taggable_id = attractions.id) AND ((taggings.taggable_type)::text = 'Attraction'::text) AND ((taggings.context)::text = 'tags'::text))))
       JOIN tags ON ((tags.id = taggings.tag_id)))
       JOIN addresses ON (((addresses.addressable_id = attractions.id) AND ((addresses.addressable_type)::text = 'Attraction'::text))))
       JOIN geo_locations ON (((geo_locations.geo_locateable_id = addresses.id) AND ((geo_locations.geo_locateable_type)::text = 'Address'::text))))
       JOIN data_resource_categories data_resource_categories_attractions_join ON (((data_resource_categories_attractions_join.data_resource_id = attractions.id) AND ((data_resource_categories_attractions_join.data_resource_type)::text = 'PointOfInterest'::text))))
       JOIN categories ON ((categories.id = data_resource_categories_attractions_join.category_id)))
       JOIN data_resource_categories ON ((attractions.id = data_resource_categories.data_resource_id)))
    WHERE (((attractions.type)::text = 'PointOfInterest'::text) AND (data_resource_categories.category_id = 15) AND ((data_resource_categories.data_resource_type)::text = 'PointOfInterest'::text) AND ((tags.name)::text = 'Werkstatt / Reparatur'::text));
  SQL
  create_view "poi_coords_e_bike_charging_stations", sql_definition: <<-SQL
      SELECT geo_locations.coords,
      concat('e_bike_charging_stations_', attractions.id) AS id,
      attractions.id AS datahub_id,
      attractions.name,
      categories.svg_icon,
      tags.name AS tag_name
     FROM (((((((attractions
       JOIN taggings ON (((taggings.taggable_id = attractions.id) AND ((taggings.taggable_type)::text = 'Attraction'::text) AND ((taggings.context)::text = 'tags'::text))))
       JOIN tags ON ((tags.id = taggings.tag_id)))
       JOIN addresses ON (((addresses.addressable_id = attractions.id) AND ((addresses.addressable_type)::text = 'Attraction'::text))))
       JOIN geo_locations ON (((geo_locations.geo_locateable_id = addresses.id) AND ((geo_locations.geo_locateable_type)::text = 'Address'::text))))
       JOIN data_resource_categories data_resource_categories_attractions_join ON (((data_resource_categories_attractions_join.data_resource_id = attractions.id) AND ((data_resource_categories_attractions_join.data_resource_type)::text = 'PointOfInterest'::text))))
       JOIN categories ON ((categories.id = data_resource_categories_attractions_join.category_id)))
       JOIN data_resource_categories ON ((attractions.id = data_resource_categories.data_resource_id)))
    WHERE (((attractions.type)::text = 'PointOfInterest'::text) AND (data_resource_categories.category_id = 15) AND ((data_resource_categories.data_resource_type)::text = 'PointOfInterest'::text) AND ((tags.name)::text = 'E-Bike-Aufladestation'::text));
  SQL
  create_view "poi_coords_e_bike_rentals", sql_definition: <<-SQL
      SELECT geo_locations.coords,
      concat('e_bike_rentals_', attractions.id) AS id,
      attractions.id AS datahub_id,
      attractions.name,
      categories.svg_icon,
      tags.name AS tag_name
     FROM (((((((attractions
       JOIN taggings ON (((taggings.taggable_id = attractions.id) AND ((taggings.taggable_type)::text = 'Attraction'::text) AND ((taggings.context)::text = 'tags'::text))))
       JOIN tags ON ((tags.id = taggings.tag_id)))
       JOIN addresses ON (((addresses.addressable_id = attractions.id) AND ((addresses.addressable_type)::text = 'Attraction'::text))))
       JOIN geo_locations ON (((geo_locations.geo_locateable_id = addresses.id) AND ((geo_locations.geo_locateable_type)::text = 'Address'::text))))
       JOIN data_resource_categories data_resource_categories_attractions_join ON (((data_resource_categories_attractions_join.data_resource_id = attractions.id) AND ((data_resource_categories_attractions_join.data_resource_type)::text = 'PointOfInterest'::text))))
       JOIN categories ON ((categories.id = data_resource_categories_attractions_join.category_id)))
       JOIN data_resource_categories ON ((attractions.id = data_resource_categories.data_resource_id)))
    WHERE (((attractions.type)::text = 'PointOfInterest'::text) AND (data_resource_categories.category_id = 15) AND ((data_resource_categories.data_resource_type)::text = 'PointOfInterest'::text) AND ((tags.name)::text = 'E-Bike-Vermietung'::text));
  SQL
  create_view "poi_coords_rideshare_points", sql_definition: <<-SQL
      SELECT geo_locations.coords,
      attractions.external_id AS id,
      attractions.id AS datahub_id,
      attractions.name,
      categories.svg_icon
     FROM (((((attractions
       JOIN addresses ON (((addresses.addressable_id = attractions.id) AND ((addresses.addressable_type)::text = 'Attraction'::text))))
       JOIN geo_locations ON (((geo_locations.geo_locateable_id = addresses.id) AND ((geo_locations.geo_locateable_type)::text = 'Address'::text))))
       JOIN data_resource_categories data_resource_categories_attractions_join ON (((data_resource_categories_attractions_join.data_resource_id = attractions.id) AND ((data_resource_categories_attractions_join.data_resource_type)::text = 'PointOfInterest'::text))))
       JOIN categories ON ((categories.id = data_resource_categories_attractions_join.category_id)))
       JOIN data_resource_categories ON ((attractions.id = data_resource_categories.data_resource_id)))
    WHERE (((attractions.type)::text = 'PointOfInterest'::text) AND ((data_resource_categories.category_id = 101) OR (data_resource_categories.category_id = 102) OR (data_resource_categories.category_id = 103) OR (data_resource_categories.category_id = 104)) AND ((data_resource_categories.data_resource_type)::text = 'PointOfInterest'::text));
  SQL
end
