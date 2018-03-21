class AddTreeFields < ActiveRecord::Migration[5.1]
  def change
    change_table :comments do |t|
      t.integer :last_child_index, default: 0
      t.string :tree_path, index: true
      t.references :parent, index: true
    end

    change_table :comment_threads do |t|
      t.integer :last_comment_index, default: 0
    end
  end
end
