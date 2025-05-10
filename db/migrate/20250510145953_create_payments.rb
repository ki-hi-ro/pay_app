class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :group, null: false, foreign_key: true
      t.references :payer, foreign_key: { to_table: :users }
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
