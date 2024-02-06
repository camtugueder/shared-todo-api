class CreateFriends < ActiveRecord::Migration[7.1]
  def change
    create_table :friends do |t|
      t.string :name
      t.string :color
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end