class Warehouse < ApplicationRecord
  validates :name, :description, :city, :address, :cep, :code, :area, presence: true
  validates :code, uniqueness: true

  def full_description 
    "#{code} - #{name}"
  end
end
