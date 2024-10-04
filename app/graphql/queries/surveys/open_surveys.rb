module Queries
    module Surveys
        class OpenSurveys < Queries::BaseQuery
            type [Types::SurveyType], null: false
        
            def resolve
                is_logged?
                Survey.where(closed: false).where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
            end
        end
    end
end