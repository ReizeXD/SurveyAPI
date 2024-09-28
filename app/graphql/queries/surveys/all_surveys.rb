module Queries
    module Surveys
        class AllSurveys < Queries::BaseQuery
            type [Types::SurveyType], null: false
        
            def resolve
                if what_role=="coordinator"
                    Survey.all
                else
                    Survey.where(closed: false).where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
                end
            end
        end
    end
end