class RemoveResponseColumn < ActiveRecord::Migration
  def change
    remove_column :messages, :response_id
  end
end
