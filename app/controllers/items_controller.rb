class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_method
  def index
    if params[:user_id]
      items = User.find(params[:user_id]).items
      render json: items
    else 
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    if item
      render json: item
    end
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(permited_params)
      render json: item, status: :created
      
    end
  end

  private 
  def permited_params
    params.permit(:name, :description, :price)
  end
  def not_found_method
    render json: { error: "Item not found" }, status: :not_found
  end
end
