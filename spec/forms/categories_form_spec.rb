require 'rails_helper'

RSpec.describe CategoriesForm, type: :model do
  describe 'save_all' do
    context 'カンマで区切られた3つの文字列を入力した場合' do
      let(:valid_form){ CategoriesForm.new({name: "a, b,  c  "}) }

      it '3つのCategoryが登録されること' do
        valid_form.save_all
        expect(Category.all.count).to eq 3
        expect(Category.first.name).to eq 'a'
        expect(Category.last.name).to eq 'c'
      end
    end

    context '空文字を入力した場合' do
      let(:invalid_form){ CategoriesForm.new({name: ""}) }

      it 'バリデーションエラーが発生すること' do
        invalid_form.save_all
        expect(invalid_form.errors[:name]).to include("を入力してください")
      end
    end
  end
end