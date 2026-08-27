if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        # Redirect Kaminari's .per calls to WillPaginate's .per_page
        def per(value = nil)
          per_page(value)
        end

        def total_count
          count
        end
      end
    end

    module CollectionMethods
      alias_method :num_pages, :total_pages
    end
  end
end
