class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, default: "", null: false
      t.integer :nausea
      t.integer :happiness
      t.integer :tickets
      t.integer :height
      t.string  :password_digest

      t.timestamps null: false
    end
    add_index "users", ["name"], name: "index_users_on_name", unique: true
  end
end
