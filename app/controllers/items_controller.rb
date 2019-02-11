class ItemsController < ApplicationController
  before_action :set_item, only: :show

  # GET /items
  # GET /items.json
  def index
    @items = Item.search(
      params[:name],
      params[:category][:category_id]
    ).includes(
        :user,
        :item_categories,
        :categories
      )
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
end
