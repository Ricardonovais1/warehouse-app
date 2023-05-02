class OrdersController < ApplicationController  
  before_action :set_order, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index 
    @orders = current_user.orders
  end

  def new 
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create 
    @order = Order.new(set_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso'
    else  
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = 'Não foi possível cadastrar o pedido'
      render :new
    end
  end

  def show
    if @order.user != current_user
      redirect_to root_path, alert: 'Você não possui acesso a este pedido'
    end
  end

  def search 
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit 
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    if @order.user != current_user
      redirect_to root_path, alert: "Você não tem permissão para editar este pedido"
    end
  end

  def update 
    if @order.user != current_user
      return redirect_to root_path, alert: "Você não tem permissão para editar este pedido"
    else 
      
    end
    if @order.update(set_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso'
    end
  end
  
  private 

  def set_order
    @order = Order.find(params[:id])
  end

  def set_params 
    @set_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end