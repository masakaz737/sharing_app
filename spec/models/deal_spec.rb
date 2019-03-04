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
      # closed状態のdeal削除
      Deal.destroy_closed_deals(user)
    end

    it 'open状態のdealが削除されていないこと' do
      expect(user.lending_deals.open.count).to eq 2
    end

    it 'closed状態のdealが削除されていること' do
      expect(user.lending_deals.closed.count).to eq 0
    end
  end

  describe 'approve_and_create_notification' do
    let(:user){ create(:user) }
    let(:item){ create(:item) }

    context 'statusがsubmittedのDealを承認した場合' do
      let(:deal){ create(:deal, status: 'submitted', item: item, borrower: user) }

      before do
        deal.approve_and_create_notification
      end

      it 'Dealのstatusがapprovedに変ること' do
        expect(deal.status).to eq 'approved'
      end

      it 'Dealに紐づくNotificationが生成されること' do
        expect(deal.notifications.first.user_id).to eq user.id
        expect(deal.notifications.first.message).to eq "#{item.name}のリクエストが承認されました"
      end
    end

    context 'statusがsubmittedでないDealを承認した場合' do
      let(:deal){ create(:deal, status: 'cancelled', item: item, borrower: user) }

      it 'RuntimeErrorが発生' do
        expect{ deal.approve_and_create_notification }.to raise_error(RuntimeError)
      end
    end
  end
end
