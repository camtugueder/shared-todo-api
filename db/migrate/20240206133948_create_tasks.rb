class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :status
      t.references :friend, null: false, foreign_key: true

      t.timestamps
    end
  end
end
