class CreateLattes < ActiveRecord::Migration
  def change
    create_table :lattes do |t|
      t.string :name
      t.string :size
      t.integer :user_id
    end
  end
end
