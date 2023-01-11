# frozen_string_literal: true

module Types
  class QueryTypes::DashboardType < Types::BaseObject
    field :point_of_interest, GraphQL::Types::JSON, null: true
    field :point_of_interest_for_categories, GraphQL::Types::JSON, null: true
    field :event_record, GraphQL::Types::JSON, null: true
    field :news_item, GraphQL::Types::JSON, null: true

    def point_of_interest
      pois = PointOfInterest.filtered_for_current_user(context[:current_user])
      {
        total_count: pois.count,
        cache_key: pois.cache_key
      }
    end

    def point_of_interest_for_categories
      category_meta_info = []

      category_ids = context[:current_user].try(:data_provider).try(:roles).fetch("role_point_of_interest_category_ids")
      category_ids.each do |category_id|
        pois = PointOfInterest.filtered_for_current_user(context[:current_user]).by_category(category_id)
        category_meta_info << {
          category_id: category_id,
          total_count: pois.count,
          cache_key: pois.cache_key
        }
      end
      category_meta_info
    end

    def event_record
      events = EventRecord.upcoming(context[:current_user])
      {
        total_count: events.count,
        cache_key: events.cache_key
      }
    end

    def news_item
      news_items = NewsItem.filtered_for_current_user(context[:current_user])
      {
        total_count: news_items.count,
        cache_key: news_items.cache_key
      }
    end

  end
end
