class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false                #商品名
      t.integer :price                           #商品の単価
      t.integer :category, default: 1            #1がピザ、2がサイドメニュー、3がドリンクということにする
      t.string :explanation                      #商品説明
      t.timestamps
    end
  end
end
