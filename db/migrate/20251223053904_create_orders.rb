class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :member, null: false                  #外部キー
      t.boolean :create_start, default: false            #作成開始
      t.boolean :created, default: false                 #作成完了
      t.boolean :reserved, default: false                #受け渡し完了
      t.datetime :reserve_time, null: false              #受け渡し時刻
      t.integer :use_point                               #使用ポイント
      t.integer :amount                                  #支払い金額
      t.timestamps
    end
  end
end
