require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'owner?' do
    let(:user1){ create(:user) }
    let(:user2){ create(:user) }

    context 'アイテムのオーナーの場合' do
      let(:item){ create(:item, user: user1) }
      it { expect(item.owner?(user1)).to be true }
    end

    context 'アイテムのオーナーでない場合' do
      let(:item){ create(:item, user: user2) }
      it { expect(item.owner?(user1)).to be false }
    end
  end

  describe 'exist_progress_deals?' do
    let(:item){ create(:item) }

    context '進行中の取引が存在する場合' do
      let!(:deal){ create(:deal, item: item, status: :delivered) }
      it { expect(item.exist_progress_deals?).to be true }
    end

    context '進行中でない取引のみ存在する場合' do
      let!(:deal){ create(:deal, item: item, status: :return) }
      it { expect(item.exist_progress_deals?).to be false }
    end

    context 'アイテムに紐付く取引がない場合' do
      it { expect(item.exist_progress_deals?).to be false }
    end
  end
end
