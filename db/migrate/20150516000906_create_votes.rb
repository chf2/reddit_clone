class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id, null: false
      t.string :votable_type, null: false
      t.integer :value, null: false

      t.timestamps null: false
    end

    add_index :votes, [:votable_id, :votable_type]
  end
end