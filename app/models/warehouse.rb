class Warehouse < ApplicationRecord
  has_many :stock_products
  validates :name, :description, :city, :address, :cep, :code, :area, presence: true
  validates :code, uniqueness: true

  def full_description 
    "#{code} - #{name}"
  end
end
