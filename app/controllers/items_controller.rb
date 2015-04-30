class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @items = Item.all
  end

  def expensive
    @items = Item.where("price > 1000")
    render "index"
  end

  def show
    unless @item
      render :text => 'Not Found', :status => '404'
    end
  end

  def new
    @item = Item.new
  end

  def edit
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
    @item.update_attributes(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "edit"
    end
  end

  def destroy
    @item.destroy
    redirect_to action: "index"
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: "index"
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :weight, :real, :description)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
