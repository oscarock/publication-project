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
class PublicationCategory < ApplicationRecord
  belongs_to :publication
  belongs_to :category
end
