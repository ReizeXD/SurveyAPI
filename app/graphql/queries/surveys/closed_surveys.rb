module Queries
    module Surveys
        class ClosedSurveys < Queries::BaseQuery
        type [Types::SurveyType], null: false
            
            def resolve
                is_logged?
                Survey.where(closed: true)
            end
        end
    end
end