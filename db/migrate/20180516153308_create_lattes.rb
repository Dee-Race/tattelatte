class CreateLattes < ActiveRecord::Migration
  def change
    create_table :lattes do |t|
      t.string :name
      t.string :flavor
      t.string :size
      t.string :description
      t.integer :user_id
    end
  end
end
