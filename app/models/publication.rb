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
#
class Publication < ApplicationRecord
  #validations
  validates :title, presence: { message: "El titulo es obligatorio" }
  validates :description, presence: { message: "La descipcion es obligatorio"}
  validates :description, length: {minimum: 50, message: "La descripcion debe tener almenos 50 caracteres"}
  validates :price, presence: { message: "El precio es obligatorio"}
  validates :price, numericality: { only_integer: true, message: "El precio debe tener solo numeros" }
  validates :city, presence: { message: "La ciudad es obligatorio"}
  validates :address, presence: { message: "La direccion es obligatorio"}
  validates :phone, presence: { message: "El telefono es obligatorio"}
  validates :phone, numericality: { only_integer: true, message: "El telefono debe tener solo numeros" }

  #relations
  has_many :publication_categories, :dependent => :destroy
  has_many :categories, through: :publication_categories
  belongs_to :user

  #scopes
  scope :visible, -> { where(visible: true) }

  #nested attributes
  accepts_nested_attributes_for :categories

  #upload images files
  has_many_attached :images, :dependent => :destroy

  #slug
  extend FriendlyId
  friendly_id :title, use: :slugged
end
