module Types
  module Inputs
    module Survey
      class CreateSurveyInput < Types::BaseInputObject
          argument :title, String, required: true
          argument :description, String, required: false
          argument :start_date, GraphQL::Types::ISO8601Date, required: true
          argument :end_date, GraphQL::Types::ISO8601Date, required: true
          argument :closed, Boolean, required: false
      end
    end
  end
end
    