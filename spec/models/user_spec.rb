require "rails_helper"

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  reset_password_token            :string
#  reset_password_sent_at          :datetime
#  remember_created_at             :datetime
#  sign_in_count                   :integer          default(0), not null
#  current_sign_in_at              :datetime
#  last_sign_in_at                 :datetime
#  current_sign_in_ip              :string
#  last_sign_in_ip                 :string
#  confirmation_token              :string
#  confirmed_at                    :datetime
#  confirmation_sent_at            :datetime
#  unconfirmed_email               :string
#  failed_attempts                 :integer          default(0), not null
#  unlock_token                    :string
#  locked_at                       :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  data_provider_id                :integer
#  role                            :integer          default("user")
#  authentication_token            :text
#  authentication_token_created_at :datetime
#
