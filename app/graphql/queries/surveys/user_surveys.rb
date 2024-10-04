module Queries
    module Surveys
        class UserSurveys < Queries::BaseQuery
            type [Types::SurveyType], null: false
        
            def resolve
                if what_role=='coordinator'
                    Survey.where(user_id: context[:current_user].id)
                else
                    raise GraphQL::ExecutionError, "Acesso negado: usuário não é coordenador"
                end
            end
        end
    end
end