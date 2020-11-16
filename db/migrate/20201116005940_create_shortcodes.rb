class CreateShortcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :shortcodes do |t|
      t.string :original_url
      t.string :short_url
      t.integer :popularity
      t.string :title
      t.timestamps
    end
  end
end
