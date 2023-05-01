class OrdersController < ApplicationController  
  before_action :set_order, only: [:show]
  before_action :authenticate_user!

  def new 
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create 
    @order = Order.new(params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date))
    @order.user = current_user
    @order.save!
    redirect_to @order, notice: 'Pedido cadastrado com sucesso'
  end

  def show; end

  private 

  def set_order
    @order = Order.find(params[:id])
  end
end