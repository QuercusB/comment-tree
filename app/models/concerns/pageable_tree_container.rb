require 'active_support/concern'

module PageableTreeContainer
    extend ActiveSupport::Concern

    class_methods do 

        def contains_paged_tree_of(items, options = nil)
            has_many items

            define_method "#{items}_page" do |page = nil, pageSize = nil|
                children = items.to_s.singularize.camelize.constantize.where(
                    { self.class.to_s.underscore => self }).order(:tree_path)
                unless options.nil? || options[:includes].nil?
                    children = children.includes(options[:includes])
                end
                unless page.nil? || pageSize.nil?
                    children = children.drop(page * pageSize).take(pageSize)
                else
                    children
                end
            end
        end
    end
    
end