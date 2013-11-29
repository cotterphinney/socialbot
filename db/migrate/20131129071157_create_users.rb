class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :number
      t.boolean :cold_text
      t.datetime :last_cold_text
      t.timestamps
    end
  end
end
