class CategoriesForm < Category
  include ActiveModel::Model

  attr_accessor :name

  def save_all
    return false if invalid?
    # stripで前後の空白を削除、splitで文字列をカンマで区切り配列に入れる
    names = name.strip.split(/\s*,\s*/)
    names.each do |n|
      category = Category.new(name: n)
      category.save!
    end
  end
end