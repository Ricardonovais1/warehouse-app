class SuppliersController < ApplicationController 
    before_action :set_supplier, only: [:show]

    def index
        @suppliers = Supplier.all
    end

    def new
        @supplier = Supplier.new
    end

    def create 
        @supplier = Supplier.new(supplier_params)
        
        if @supplier.save
           redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
        else 
           flash[:notice] = 'Nenhum fornecedor cadastrado' 
           render 'new'
        end
    end

    def show 
    end

    private 
    
    def set_supplier 
        @supplier = Supplier.find(params[:id])
    end

    def supplier_params
        @supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, 
                                                            :registration_number,
                                                            :full_address, :city, :state, :email)
    end
end