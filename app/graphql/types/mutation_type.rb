# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # creations
    field :create_news_item, mutation: Mutations::CreateNewsItem
    field :create_generic_item, mutation: Mutations::CreateGenericItem
    field :create_tour, mutation: Mutations::CreateTour
    field :create_event_record, mutation: Mutations::CreateEventRecord
    field :create_point_of_interest, mutation: Mutations::CreatePointOfInterest
    field :create_app_user_content, mutation: Mutations::CreateAppUserContent
    field :create_waste_pick_up_time, mutation: Mutations::CreateWastePickUpTime

    # destroys
    field :destroy_record, mutation: Mutations::DestroyRecord
    field :change_visibility, mutation: Mutations::ChangeVisibility
  end
end
