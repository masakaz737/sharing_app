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

  describe 'self.search_by' do
    let(:category1){ create(:category, name: 'カテゴリ1')}
    let(:category2){ create(:category, name: 'カテゴリ2')}

    context '検索条件が存在しない場合' do
      before do
        create(:item)
      end

      it 'self.search_byの戻り値が1つであること' do
        expect(Item.search_by.count).to eq 1
      end
    end

    context '検索条件が存在する場合' do
      context 'name検索' do
        before do
          create(:item, name: 'アイテム1')
          create(:item, name: 'アイテム')
          create(:item, name: 'ITEM')
        end

        it 'self.search_byの戻り値が2つであること' do
          expect(Item.search_by('アイテム', '').count).to eq 2
        end
      end

      context 'category検索' do
        before do
          create(:item, categories: [category1])
          create(:item, categories: [category2])
        end

        it 'self.search_byの戻り値が1つであること' do
          expect(Item.search_by('', category1.id).count).to eq 1
        end
      end

      context '複合検索' do
        before do
          create(:item, name: 'アイテム1', categories: [category1])
          create(:item, name: 'アイテム1', categories: [category2])
          create(:item, name: 'アイテム2', categories: [category1])
          create(:item, name: 'アイテム2', categories: [category2])
        end

        it 'self.search_byの戻り値が1つであること' do
          expect(Item.search_by('アイテム1', category1.id).count).to eq 1
        end
      end
    end
  end
end
