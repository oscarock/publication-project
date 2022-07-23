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
#  visible     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#  slug        :string
#
require "test_helper"

class PublicationTest < ActiveSupport::TestCase

  context 'publication inputs validations' do
    should validate_presence_of(:title).with_message("El titulo es obligatorio")
    should validate_presence_of(:price).with_message("El precio es obligatorio")
    should validate_numericality_of(:price).only_integer.with_message("El precio debe tener solo numeros")
    should validate_presence_of(:city).with_message("La ciudad es obligatorio")
    should validate_presence_of(:address).with_message("La direccion es obligatorio")
    should validate_presence_of(:phone).with_message("El telefono es obligatorio")
    should validate_numericality_of(:phone).only_integer.with_message("El telefono debe tener solo numeros")
  end

  context 'publication relations validation' do
    should have_many(:publication_categories).dependent(:destroy)
    should have_many(:categories).through(:publication_categories)
    should belong_to(:user)
    should have_rich_text(:description)
    should accept_nested_attributes_for(:categories)
    should have_many_attached(:images)
  end
end
