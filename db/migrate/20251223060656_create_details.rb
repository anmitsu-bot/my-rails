class CreateDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :details do |t|
      t.references :order, null: false
      t.references :item, null: false
      t.integer :number              #個数
      t.integer :subtotal             #ポイント差し引き前の値段
      t.timestamps
    end
  end
end
