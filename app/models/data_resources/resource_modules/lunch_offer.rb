# frozen_string_literal: true

class LunchOffer < ApplicationRecord
  belongs_to :lunch
end

# == Schema Information
#
# Table name: lunch_offers
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :string
#  lunch_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
