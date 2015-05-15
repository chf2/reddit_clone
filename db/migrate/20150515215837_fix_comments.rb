class FixComments < ActiveRecord::Migration
  def change
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type
    add_column :comments, :post_id, :integer
    change_column :comments, :post_id, :integer, null: false
    add_index :comments, :post_id
  end

end
