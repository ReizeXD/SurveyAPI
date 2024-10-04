module Queries
    module Surveys
        class SurveyById < Queries::BaseQuery
            type Types::SurveyType, null: false
            
            argument :id, ID, required: true, description: "ID do usuario"
            def resolve(id:)
                if what_role=="coordinator"
                    begin
                        Survey.find(id)
                    rescue ActiveRecord::RecordNotFound => e
                        raise GraphQL::ExecutionError, "Pesquisa não encontrada"
                    end
                else
                    raise GraphQL::ExecutionError, "Acesso negado: usuário não é coordenador"
                end
            end
        end
    end
end