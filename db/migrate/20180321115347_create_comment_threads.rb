class CreateCommentThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_threads do |t|
      t.timestamps
    end
  end
end
