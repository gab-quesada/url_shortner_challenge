class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url, unique: true
      t.integer :access_count, default: 0

      t.timestamps
    end

    add_index :urls, :short_url, unique: true
  end
end
