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

  context 'publication category relations validation' do
    should belong_to(:publication)
    should belong_to(:category)
  end
end
