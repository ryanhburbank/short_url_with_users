class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string  :long_url, null: false
      t.string  :short_url, null: false
      t.integer :clicks, default: 0
      t.integer :user_id, default: nil
    end
  end
end
