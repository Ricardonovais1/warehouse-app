class ProductModel < ApplicationRecord
  belongs_to :supplier
  
  has_many :order_items

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20 }
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 } 
end
