class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customers = Customer.find(params[:id])
  end

  def edit
    @customers = Customers.find(params[:id])
  end
  
  def update
    @customers = Customers.find(params[:id])
  end 
end
