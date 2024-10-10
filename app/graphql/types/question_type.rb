# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :question_type, String
    #field :formmated_type_question, String
    field :survey_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :options, [Types::OptionType], null: true


    def question_type
      Question::TYPE_QUESTION[object.question_type]
    end

  end
end
