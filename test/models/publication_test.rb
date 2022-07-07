# == Schema Information
#
# Table name: publications
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :integer
#  city        :string
#  address     :string
#  phone       :string
#  visible     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class PublicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
