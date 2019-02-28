require 'rails_helper'

RSpec.describe Deal, type: :model do
  describe 'self.destroy_closed_deals' do
    let(:user){ create(:user) }
    let(:item){ create(:item, user: user) }

    before do
      # open状態のdeal作成
      create(:deal, item: item, status: :submitted, deleted_at: nil)
      create(:deal, item: item, status: :return, deleted_at: nil)
      # closed状態のdeal作成
      create(:deal, item: item, status: :rejected, deleted_at: nil)
      create(:deal, item: item, status: :cancelled, deleted_at: nil)

      Deal.destroy_closed_deals(user)
    end

    it 'open状態のdealが削除されていないこと' do
      expect(user.lending_deals.open.count).to eq 2
    end

    it 'closed状態のdealが削除されていること' do
      expect(user.lending_deals.closed.count).to eq 0
    end
  end
end
