# frozen_string_literal: true

# This model provides an address to every other resource which needs one.
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true
  has_one :geo_location, as: :geo_locateable, dependent: :destroy
  has_many :waste_location_types, class_name: "Waste::LocationType"

  accepts_nested_attributes_for :geo_location,
                                reject_if: lambda { |attr|
                                  attr[:latitude].blank? || attr[:longitude].blank?
                                }

  enum kind: { default: 0, start: 1, end: 2 }, _prefix: :kind_of?
end

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addition         :string
#  city             :string
#  street           :string
#  zip              :string
#  kind             :integer          default("default")
#  addressable_type :string
#  addressable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
