require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'owner?' do
    let(:user1){ create(:user) }
    let(:user2){ create(:user) }

    context 'アイテムのオーナーの場合' do
      let(:item){ create(:item, user: user1) }
      it 'owner?の結果がtrueであること' do
        expect(item.owner?(user1)).to be true
      end
    end

    context 'アイテムのオーナーでない場合' do
      let(:item){ create(:item, user: user2) }
      it 'owner?の結果がfalseであること' do
        expect(item.owner?(user1)).to be false
      end
    end
  end

  describe 'exist_progress_deals?' do
    let(:item){ create(:item) }

    context '進行中の取引が存在する場合' do
      let!(:deal){ create(:deal, item: item, status: :delivered) }
      it 'exist_progress_deals?の結果がtrueであること' do
        expect(item.exist_progress_deals?).to be true
      end
    end

    context '進行中の取引きが存在しない場合' do
      let!(:deal){ create(:deal, item: item, status: :return) }
      it 'exist_progress_deals?の結果がfalseであること' do
        expect(item.exist_progress_deals?).to be false
      end
    end

    context '取引が存在しない場合' do
      it 'exist_progress_deals?の結果がfalseであること' do
        expect(item.exist_progress_deals?).to be false
      end
    end
  end
end
