class CreateAccesstokens < ActiveRecord::Migration[6.1]
  def change
    create_table :accesstokens do |t|
      t.string :token, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
