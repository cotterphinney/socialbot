class AddSidToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sid, :string
    add_column :messages, :account_sid, :string
  end
end
