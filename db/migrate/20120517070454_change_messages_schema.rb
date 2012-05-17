class ChangeMessagesSchema < ActiveRecord::Migration
  def up
    change_column :messages, :name, :string, :limit => 50
    change_column :messages, :email, :string, :limit => 50
  end

  def down
    change_column :messages, :name, :string
    change_column :messages, :email, :string
  end
end
