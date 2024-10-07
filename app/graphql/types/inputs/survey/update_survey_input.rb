module Types
    module Inputs
      module Survey
        class UpdateSurveyInput < Types::BaseInputObject
            argument :id, ID, required: true
            argument :title, String, required: false
            argument :description, String, required: false
            argument :start_date, GraphQL::Types::ISO8601Date, required: false
            argument :end_date, GraphQL::Types::ISO8601Date, required: false
            argument :closed, Boolean, required: false
        end
      end
    end
  end
    