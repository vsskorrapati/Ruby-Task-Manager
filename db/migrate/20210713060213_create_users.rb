class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :image
      t.string :provider

      t.timestamps
    end
  end
end
