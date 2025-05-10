class CreateDebts < ActiveRecord::Migration[7.1]
  def change
    create_table :debts do |t|
      t.references :payment, null: false, foreign_key: true
      t.references :from_user, foreign_key: { to_table: :users }
      t.references :to_user, foreign_key: { to_table: :users }
      t.integer :amount
      t.boolean :paid
      t.date :due_date

      t.timestamps
    end
  end
end
