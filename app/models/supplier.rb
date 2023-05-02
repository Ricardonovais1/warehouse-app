class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, :email, uniqueness: true
  validates :registration_number, length: { is: 13 }

  def full_description 
    "#{corporate_name} | #{brand_name}"
  end
end
