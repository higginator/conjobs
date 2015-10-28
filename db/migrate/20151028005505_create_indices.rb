class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.integer :start_index
      t.integer :end_index

      t.timestamps
    end
  end
end
