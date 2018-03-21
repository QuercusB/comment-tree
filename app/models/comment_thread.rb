class CommentThread < ApplicationRecord
    include PageableTreeContainer

    contains_paged_tree_of :comments, includes: :user
end
