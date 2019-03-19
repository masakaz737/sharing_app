class Member::ItemsController < Member::ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  before_action :check_progress_deals, only: %i[edit update]

  # GET /items
  def index
    @items = current_user.items.includes(:categories).order(created_at: "DESC").page params[:page]
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    set_images
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    @item = current_user.items.new(item_params)

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
      @item = current_user.items.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(
        :name,
        :description,
        :condition,
        :price,
        :available,
        category_ids: [],
        item_images_attributes: [:image, :image_cache, :remove_image, :id]
      )
    end

    def set_images
      3.times { @item.item_images.build }
    end

    def check_progress_deals
      redirect_to member_deals_path, notice: ' 進行中の取引があります。' if @item.exist_progress_deals?
    end
end
