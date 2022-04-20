FactoryBot.define do
  factory :media_content do
    caption_text { "MyString" }
    copyright { "MyString" }
    height { "MyString" }
    width { "MyString" }
    link { "MyString" }
    type { "" }
    source_url { "MyString" }
  end
end

# == Schema Information
#
# Table name: media_contents
#
#  id             :bigint           not null, primary key
#  caption_text   :text
#  copyright      :string
#  height         :string
#  width          :string
#  content_type   :string
#  mediaable_type :string
#  mediaable_id   :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
