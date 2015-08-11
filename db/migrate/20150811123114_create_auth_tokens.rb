class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.integer :user_id, null: false
      t.string :token, null: false
      t.datetime :expired_at, null: false

      t.timestamps null: false
    end
    add_index :auth_tokens, :user_id
  end
end
