module Queries
    module Responses
        class GetSurveyResults < Queries::BaseQuery
            type Types::SurveyType, null: false
            

            argument :id, ID, required: true
            def resolve(id:)
                is_logged?
                survey=Survey.find(id)

                if !survey.closed?
                    raise GraphQL::ExecutionError, "Pesquisa ainda está aberta"
                end

                survey

            rescue ActiveRecord::RecordNotFound => e
                raise GraphQL::ExecutionError, "Pesquisa não encontrada"
            end
        end
    end
end