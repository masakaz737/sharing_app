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
      it 'self.searchの戻り値が4個、かつitem1,item2,item3,item4が含まれること' do
        expect(Item.search('', '').count).to eq 4
        expect(Item.search('', '')).to include(item1, item2, item3, item4)
      end
    end

    context '名前「アイテムA」、カテゴリ「カテゴリ1」で検索した場合' do
      it 'self.searchの戻り値が1個、かつitem1が含まれること' do
        expect(Item.search('アイテムA', category1.id).count).to eq 1
        expect(Item.search('アイテムA', category1.id)).to include(item1)
      end
    end

    context '名前「アイテムA」、カテゴリ「指定なし」で検索した場合' do
      it 'self.searchの戻り値が2個、かつitem1,item2が含まれること' do
        expect(Item.search('アイテムA', '').count).to eq 2
        expect(Item.search('アイテムA', '')).to include(item1, item2)
      end
    end

    context '名前を空欄、カテゴリ「カテゴリ1」で検索した場合' do
      it 'self.searchの戻り値が2個、かつitem1,item3が含まれること' do
        expect(Item.search('', category1.id).count).to eq 2
        expect(Item.search('', category1.id)).to include(item1, item3)
      end
    end

    context '名前「アイテム」、カテゴリ「指定なし」で検索した場合' do
      it 'self.searchの戻り値が3個、かつitem1,item2,item3が含まれること' do
        expect(Item.search('アイテム', '').count).to eq 3
        expect(Item.search('アイテム', '')).to include(item1, item2, item3)
      end
    end

    context '名前「A」、カテゴリ「指定なし」で検索した場合' do
      it 'self.searchの戻り値が0個であること' do
        expect(Item.search('A', '').count).to eq 0
        expect(Item.search('A', '')).to eq []
      end
    end

    context '存在しない名前「アイテムC」、カテゴリ「指定なし」で検索した場合' do
      it 'self.searchの戻り値が0個であること' do
        expect(Item.search('アイテムC', '').count).to eq 0
        expect(Item.search('アイテムC', '')).to eq []
      end
    end
  end
end
