class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.references :item, null: false #外部キー
      t.integer :number               #在庫の個数

      t.timestamps
    end
  end
end
