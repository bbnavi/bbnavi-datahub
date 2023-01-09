# frozen_string_literal: true

#
# All locations which are interesting and attractive for the public
# and the surrounding area
#
class PointOfInterest < Attraction
  include FilterByRole

  BLACKLISTED_FORM_FIELDS_FOR_CMS = [:id, :visible, :created_at, :updated_at, :category, :settings, :active, :data_provider].freeze

  attr_accessor :force_create

  belongs_to :data_provider

  has_many :data_resource_categories, -> { where(data_resource_type: "PointOfInterest") }, foreign_key: :data_resource_id
  has_many :categories, through: :data_resource_categories
  has_many :opening_hours, as: :openingable, dependent: :destroy
  has_many :price_informations, as: :priceable, class_name: "Price", dependent: :destroy
  has_many :lunches, dependent: :destroy
  has_one :open_street_map, as: :osm_able, class_name: "OpenStreetMap"

  accepts_nested_attributes_for :price_informations, :opening_hours, :lunches, :open_street_map

  def unique_id
    generate_external_id_for_rideshare_points
    return external_id if external_id.present?

    fields = [name, type]

    first_address = addresses.first
    address_keys = %i[street zip city kind]
    address_fields = address_keys.map { |a| first_address.try(:send, a) }

    generate_checksum(fields + address_fields)
  end

  def settings
    data_provider.data_resource_settings.where(data_resource_type: "PointOfInterest").first.try(:settings)
  end

  def content_for_facebook
    {
      message: [name, description].compact.join("\n\n"),
      link: ""
    }
  end

  def to_geojson
    current_category = try(:categories).try(:first)
    {
      type: "Feature",
      properties: {
        data_provider: data_provider.as_json(only: [:name, :description, :notice]),
        name: name,
        popupContent: geojson_description,
        description: description,
        opening_hours_description: opening_hours.map(&:description).flatten.compact.join,
        category: current_category.try(:name),
        location: location.as_json(
          except: [:id, :created_at, :updated_at, :region_id],
          include: { geo_location: { only: [:latitude, :longitude] } }),
        tags: tag_list,
        icon: {
          id: "tmbIcon",
          svg: geojson_icon(current_category)
        }
      },
      geometry: {
        type: "Point",
        coordinates: location.try(:geo_location).try(:coordinates)
      }
    }
  end

  def geojson_description
    [description, opening_hours.map(&:description) ].flatten.compact.join("\n\n")
  end

  def geojson_icon(current_category)
    fallback = "<svg xmlns=\"http://www.w3.org/2000/svg\" id=\"Ebene_1\" data-name=\"Ebene 1\" viewBox=\"0 0 32.53 32.54\">  <defs>    <style>      .cls-2{fill:#fff}    </style>  </defs>  <path fill=\"#000001\" d=\"M313.29 384.05A16.27 16.27 0 11297 367.78a16.27 16.27 0 0116.26 16.27\" transform=\"translate(-280.76 -367.78)\"/>  <path d=\"M299.66 384.6a1.43 1.43 0 01-1.05-.44 1.35 1.35 0 01-.46-1 1.56 1.56 0 011.51-1.51 1.42 1.42 0 011 .45 1.51 1.51 0 01.44 1.06 1.5 1.5 0 01-1.48 1.47zm-7.87 4.89a3.55 3.55 0 012.65 1.09 3.62 3.62 0 011.07 2.67 3.66 3.66 0 01-3.72 3.72 3.65 3.65 0 01-2.67-1.07 3.55 3.55 0 01-1.09-2.65 3.72 3.72 0 013.76-3.76zm0 6.36a2.59 2.59 0 002.6-2.6 2.53 2.53 0 00-.76-1.86 2.45 2.45 0 00-1.84-.78 2.66 2.66 0 00-2.64 2.64 2.46 2.46 0 00.78 1.84 2.53 2.53 0 001.86.76zm4.32-7.49l1.65 1.73v4.63h-1.47V391l-2.43-2.11a1.18 1.18 0 01-.42-1.05 1.45 1.45 0 01.42-1.06l2.11-2.11a1.19 1.19 0 011.06-.42 1.86 1.86 0 011.19.42l1.44 1.45a3.68 3.68 0 002.67 1.12v1.51a5.18 5.18 0 01-3.79-1.58l-.6-.6zm6.15 1.13a3.72 3.72 0 013.76 3.76 3.55 3.55 0 01-1.09 2.65 3.62 3.62 0 01-2.67 1.07 3.66 3.66 0 01-3.72-3.72 3.62 3.62 0 011.07-2.67 3.55 3.55 0 012.65-1.09zm0 6.36a2.53 2.53 0 001.86-.76 2.46 2.46 0 00.78-1.84 2.66 2.66 0 00-2.64-2.64 2.46 2.46 0 00-1.84.78 2.53 2.53 0 00-.76 1.86 2.59 2.59 0 002.6 2.6zM304 374.92a.38.38 0 01.38.14.65.65 0 01.15.48v1.86a.51.51 0 01-.57.58h-7.4a3.46 3.46 0 01-1.34 1.58 3.67 3.67 0 01-2.07.61 3.79 3.79 0 01-2.22-.69 3.33 3.33 0 01-1.33-1.79h3.55v-2.44h-3.55a3.8 3.8 0 013.54-2.48 3.76 3.76 0 012.08.61 3.46 3.46 0 011.34 1.58z\" class=\"cls-2\" transform=\"translate(-280.76 -367.78)\"/></svg>"
    return fallback if current_category.blank?
    return fallback if current_category.svg_icon.blank?

    current_category.svg_icon
  end

  private

  # POIs in der Kategorie "Mitfahrpunkte" haben ein eigenes ExternalID Schema
  # z.b.: "bbnavi:12345:0001"
  def generate_external_id_for_rideshare_points
    return if external_id.blank?

    # wenn der POi nicht im Unterbaum "Mitfahrpunkte" ist, dann abbrechen
    category_ids_to_check = Category.find_by(name: "Mitfahrpunkte").descendant_ids
    return unless (category_ids & category_ids_to_check).any?

    # Die RideShare haben folgendes Schema:
    # bbnavi:12345:0001
    rideshare_cat_schema = "bbnavi\:\\d{5}\:\\d+"
    # wenn external_id existiert und dem Schema entspricht, dann nichts machen
    return if external_id.match(rideshare_cat_schema).present?

    # wenn external_id existiert und dem Schema nicht entspricht, dann neu generieren.
    # die external_id beinhaltet dann bisher den 5 stellige allgemeinen Gemeindeschlüssel.
    # dieser wird dann nach dem Schema oben mit einer noch nicht verwendeten fortlaufenden Zahl neu generiert.
    last_used_id = PointOfInterest.where("external_id LIKE 'bbnavi:#{external_id}:%'").pluck(:external_id).map{|a| a.split(":").last.to_i}.max
    new_id = (last_used_id.to_i + 1).to_s.rjust(4, "0")
    update(external_id: "bbnavi:#{external_id}:#{new_id}")
  end
end

# == Schema Information
#
# Table name: attractions
#
#  id                      :bigint           not null, primary key
#  external_id             :text
#  name                    :string
#  description             :text
#  mobile_description      :text
#  active                  :boolean          default(TRUE)
#  length_km               :integer
#  means_of_transportation :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  type                    :string           default("PointOfInterest"), not null
#  data_provider_id        :integer
#  visible                 :boolean          default(TRUE)
#
