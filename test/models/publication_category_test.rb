# == Schema Information
#
# Table name: publication_categories
#
#  id             :integer          not null, primary key
#  publication_id :integer          not null
#  category_id    :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class PublicationCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
