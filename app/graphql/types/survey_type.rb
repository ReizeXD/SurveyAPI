# frozen_string_literal: true

module Types
  class SurveyType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :start_date, GraphQL::Types::ISO8601Date
    field :end_date, GraphQL::Types::ISO8601Date
    field :closed, Boolean
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
