# frozen_string_literal: true

#
# Table for all regions which are relevant.
#
class Region < ApplicationRecord
  has_one :event_record
  has_and_belongs_to_many :attractions
  has_many :locations
end

# == Schema Information
#
# Table name: regions
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
