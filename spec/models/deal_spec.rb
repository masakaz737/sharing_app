require 'rails_helper'

RSpec.describe Deal, type: :model do
  describe 'self.destroy_all_closed_deals' do
    let(:user){ create(:user) }
    let(:item){ create(:item, user: user) }

    context 'openな取引が2つ、closedな取引が2つ存在する場合' do
      before do
        create(:deal, item: item, status: :submitted, deleted_at: nil)
        create(:deal, item: item, status: :return, deleted_at: nil)
        create(:deal, item: item, status: :rejected, deleted_at: nil)
        create(:deal, item: item, status: :cancelled, deleted_at: nil)
      end
      it 'self.destroy_all_closed_dealsの実行後、deleted_atがnilでない取引が2つ存在すること' do
        Deal.destroy_all_closed_deals(user)
        expect(user.lending_deals.where.not(deleted_at: nil).count).to eq 2
      end
    end
  end
end
