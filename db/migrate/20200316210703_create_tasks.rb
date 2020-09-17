class CreateTasks < ActiveRecord::Migration[5.2]
  def change
		create_table :tasks do |t|
			t.string  :name
			t.integer :minutes, :limit => 2
			t.integer :seconds, :limit => 2
			t.decimal :rate, precision: 10, scale: 2
		end
  end
end
