class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :predator
      t.integer :prey
      t.float :alpha
      t.float :beta
      t.float :gamma
      t.float :delta
      t.integer :time
      t.float :increment
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
