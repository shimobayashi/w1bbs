class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :position
      t.string :name
      t.text :body
      t.references :forum

      t.timestamps
    end
    add_index :messages, :forum_id
  end
end
