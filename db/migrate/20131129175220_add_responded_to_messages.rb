class AddRespondedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :responded, :boolean, :default => false
  end
end
