class Member::ItemsController < Member::ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items
  def index
    @items = Item.where(user_id: current_user)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    redirect_to member_item_deals_path(@item), notice: ' 進行中の取引があります。' if @item.deals_in_progress?
  end

  # POST /items
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id

    if @item.save
      redirect_to [:member, @item], notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      redirect_to [:member, @item], notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to member_items_url, notice: 'Item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :description, :condition, :price, :available, category_ids: [])
    end
end
