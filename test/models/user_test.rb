# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class UserTest < ActiveSupport::TestCase

  context 'user inputs validations' do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should validate_presence_of(:password)
    should validate_confirmation_of(:password)
    should validate_uniqueness_of(:email).ignoring_case_sensitivity
  end

  context 'user relations validation' do
    should have_many(:publications)
  end
end
