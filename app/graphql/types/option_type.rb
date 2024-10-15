# frozen_string_literal: true

module Types
  class OptionType < Types::BaseObject
    field :id, ID, null: false
    field :content, String
    field :question_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
