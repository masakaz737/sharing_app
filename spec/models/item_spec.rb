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

  describe 'self.search(name, category_id)' do
    let(:category1){ create(:category, name: 'カテゴリ1')}
    let(:category2){ create(:category, name: 'カテゴリ2')}
    let!(:item1){ create(:item, name: 'アイテムA', categories: [category1]) }
    let!(:item2){ create(:item, name: 'アイテムA', categories: [category2]) }
    let!(:item3){ create(:item, name: 'アイテムB', categories: [category1]) }
    let!(:item4){ create(:item, name: 'ITEM', categories: [category2]) }

    context '名前を空欄、カテゴリ「指定なし」で検索した場合' do
      let(:search_item_without_name_and_category){ Item.search('', '') }

      it 'self.searchの戻り値にitem1,item2,item3,item4が全て含まれること' do
        expect(search_item_without_name_and_category).to include(item1, item2, item3, item4)
      end
    end

    context '名前「アイテムA」、カテゴリ「カテゴリ1」で検索した場合' do
      let(:search_item_with_name_and_category){ Item.search('アイテムA', category1.id) }

      it 'self.searchの戻り値にitem1のみが含まれること' do
        expect(search_item_with_name_and_category).to include(item1)
        expect(search_item_with_name_and_category).not_to include(item2, item3, item4)
      end
    end

    context '名前「アイテムA」、カテゴリ「指定なし」で検索した場合' do
      let(:search_item_without_category){ Item.search('アイテムA', '') }

      it 'self.searchの戻り値にitem1,item2のみが含まれること' do
        expect(search_item_without_category).to include(item1, item2)
        expect(search_item_without_category).not_to include(item3, item4)
      end
    end

    context '名前を空欄、カテゴリ「カテゴリ1」で検索した場合' do
      let(:search_item_without_name){ Item.search('', category1.id) }

      it 'self.searchの戻り値にitem1,item3のみが含まれること' do
        expect(search_item_without_name).to include(item1, item3)
        expect(search_item_without_name).not_to include(item2, item4)
      end
    end

    context '名前「アイテム」、カテゴリ「指定なし」で検索した場合' do
      let(:search_item_with_name_kana){ Item.search('アイテム', '') }

      it 'self.searchの戻り値にitem1,item2,item3のみが含まれること' do
        expect(search_item_with_name_kana).to include(item1, item2, item3)
        expect(search_item_with_name_kana).not_to include(item4)
      end
    end

    context '名前「A」、カテゴリ「指定なし」で検索した場合' do
      let(:search_item_with_name_a){ Item.search('A', '') }

      it 'self.searchの戻り値が空であること' do
        expect(search_item_with_name_a).not_to include [item1, item2, item3, item4]
      end
    end

    context '存在しない名前「アイテムC」、カテゴリ「指定なし」で検索した場合' do
      let(:search_item_with_name_c){ Item.search('アイテムC', '') }

      it 'self.searchの戻り値が空であること' do
        expect(search_item_with_name_c).not_to include [item1, item2, item3, item4]
      end
    end
  end
end
