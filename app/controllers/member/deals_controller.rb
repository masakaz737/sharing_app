class Member::DealsController < Member::ApplicationController
  before_action :set_deal, only: %i[show edit update destroy]

  # GET /deals
  def index
    @deals = Deal.all
  end

  # GET /deals/1
  def show
  end

  # GET /deals/new
  def new
    @item = Item.find(params[:item_id])
    @deal = @item.deals.new
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  def create
    @deal = Deal.new(deal_params)

    if @deal.save
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
    redirect_to member_deals_url, notice: 'Deal was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def deal_params
      params.require(:deal).permit(:item_id, :lender_id, :borrower_id, :unit_price)
    end
end
