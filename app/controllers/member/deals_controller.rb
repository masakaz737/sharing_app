class Member::DealsController < Member::ApplicationController
  before_action :set_deal, only: %i[show edit update destroy]
  before_action :set_item, only: %i[new create]
  before_action :require_item_owner, only: %i[edit update]


  # GET /deals
  def index
    @lender_deals = Deal.where(lender_id: current_user.id)
    @borrower_deals = Deal.where(borrower_id: current_user.id)
  end

  # GET /deals/1
  def show
  end

  # GET /deals/new
  def new
    @deal = @item.deals.new(
      lender_id: @item.user_id,
      borrower_id: current_user.id,
      unit_price: @item.price,
    )
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  def create
    @deal = @item.deals.new(deal_params)

    if @deal.borrower?(current_user) && @deal.save
      redirect_to [:member, @deal], notice: 'Deal was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /deals/1
  def update
    if @deal.update(deal_params)
      redirect_to [:member, @deal], notice: 'Deal was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /deals/1
  def destroy
    @deal.destroy
    redirect_to member_item_deals_url(@deal.item), notice: 'Deal was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    # Only allow a trusted parameter "white list" through.
    def deal_params
      params.require(:deal).permit(:item_id, :lender_id, :borrower_id, :unit_price, :status)
    end

    def require_item_owner
      redirect_to [:member, @deal], notice: '権限がありません。' if !@deal.item.owner?(current_user)
    end
end
