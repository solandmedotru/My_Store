class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @items = Item.all
  end

  def show
    unless @item = Item.where(id: params[:id]).first
      render :text => 'Not Found', :status => '404'
    end
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])

  end

  def create
    @item = Item.create(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "edit"
    end

  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to action: "index"
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :weight, :real, :description)
  end
end
