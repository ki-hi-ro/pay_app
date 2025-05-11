class RemoveGroupIdFromPayments < ActiveRecord::Migration[7.1]
  def change
    remove_column :payments, :group_id, :integer
  end
end
