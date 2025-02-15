# frozen_string_literal: true

module Types
  class QueryTypes::PointOfInterestType < Types::BaseObject
    field :id, ID, null: true
    field :external_id, String, null: true
    field :visible, Boolean, null: true
    field :settings, QueryTypes::SettingType, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :mobile_description, String, null: true
    field :addresses, [QueryTypes::AddressType], null: true
    field :active, Boolean, null: true
    field :category, QueryTypes::CategoryType, null: true
    field :categories, [QueryTypes::CategoryType], null: true
    field :location, QueryTypes::LocationType, null: true
    field :data_provider, QueryTypes::DataProviderType, null: true
    field :contact, QueryTypes::ContactType, null: true
    field :open_street_map, QueryTypes::OpenStreetMapType, null: true
    field :web_urls, [QueryTypes::WebUrlType], null: true
    field :media_contents, [QueryTypes::MediaContentType], null: true
    field :operating_company, QueryTypes::OperatingCompanyType, null: true
    field :opening_hours, [QueryTypes::OpeningHourType], null: true
    field :price_informations, [QueryTypes::PriceType], null: true
    field :certificates, [QueryTypes::CertificateType], null: true
    field :accessibility_information, QueryTypes::AccessibilityInformationType, null: true
    field :tag_list, [String], null: true
    field :lunches, [QueryTypes::LunchType], null: true
    field :updated_at, String, null: true
    field :created_at, String, null: true
  end
end
