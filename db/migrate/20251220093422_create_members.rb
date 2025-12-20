class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
     t.string :name, null: false #ユーザー名
     t.integer :point #ポイント残高
     t.integer :role, null: false, default: 1 #役割 (1:顧客, 2:店員, 3:管理者)
     t.string :password_digest #パスワード
     t.timestamps
    end
  end
end
