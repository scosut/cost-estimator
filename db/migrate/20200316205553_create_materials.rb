class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
		create_table :materials do |t|
			t.string  :name
			t.string  :quantity, null: false, default: 'no'
			t.decimal :cost, precision: 10, scale: 2
		end
		
		add_reference :materials, :group, foreign_key: true
  end
end
