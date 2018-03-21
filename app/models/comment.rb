class Comment < ApplicationRecord
    include PageableTree

    has_tree_container :comment_thread

    belongs_to :user

    validates_presence_of :text
    validates_presence_of :user
end
