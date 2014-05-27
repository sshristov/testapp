class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :street_no

      t.timestamps
    end
  end
end
