# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  context 'category relations validation' do
    should have_many(:publication_categories)
  end
end
