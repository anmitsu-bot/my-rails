class AlterOrders < ActiveRecord::Migration[7.0]
  def up
    Order.where(use_point: nil).update_all(use_point: 0)
    change_column :orders, :use_point, :integer, null: false, default: 0
  end
end
