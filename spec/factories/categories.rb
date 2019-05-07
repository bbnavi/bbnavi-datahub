FactoryBot.define do
  factory :category do
    name { "MyString" }
  end
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string(255)
#
