class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :bowling_type
      t.string :batting_hand
      t.string :bowling_hand
      t.boolean :keeper

      t.timestamps null: false
    end
  end
end
