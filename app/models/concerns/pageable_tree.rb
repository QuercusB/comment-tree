require 'active_support/concern'

module PageableTree
    extend ActiveSupport::Concern

    included do

        before_save :set_tree_path
        belongs_to :parent, class_name: 'Comment', optional: true
        has_many :comments, foreign_key: :parent_id

        def as_json(options = nil)
            super({ except: [:tree_path, :last_child_index], include: [:user] }.merge(options || {}))
        end

        private

        def set_tree_path
            if self.tree_path.blank?
                if parent.nil?
                    comment_thread.last_comment_index += 1
                    self.tree_path = "#{comment_thread.last_comment_index}"
                    comment_thread.save
                else
                    parent.last_child_index += 1
                    self.tree_path = "#{parent.tree_path}/#{parent.last_child_index}"
                    parent.save
                end
            end
        end
    end

    class_methods do 

        def has_tree_container(container)
            before_validation :set_tree_container
            belongs_to container
            validates_presence_of container
        
            define_method :set_tree_container do
                if self.send(container).nil? && !self.parent.nil?
                    self.send("#{container}=", self.parent.send(container))
                end
            end
        end
    end

end