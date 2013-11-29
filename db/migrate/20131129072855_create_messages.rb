class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to_number
      t.string :from_number
      t.boolean :artificial
      t.text :body
      t.belongs_to :user
      
      t.integer :parent_id
      t.integer :response_id
      
      t.timestamps
    end
  end
end
