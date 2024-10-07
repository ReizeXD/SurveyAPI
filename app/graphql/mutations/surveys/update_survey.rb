module Mutations
    module Surveys
        class UpdateSurvey < Mutations::BaseMutation
            input_object_class Types::Inputs::Survey::UpdateSurveyInput
            
            description "Editando uma pesquisa"

            field :survey, Types::SurveyType, null: false
    
            def resolve(**arguments)
                if what_role=="coordinator"
                    begin
                        edit = SurveyServices.new(context[:current_user].id,arguments).call
                        {survey: edit}
                    rescue ActiveRecord::RecordInvalid => e
                        raise GraphQL::ExecutionError, e.message
                    end
                else
                    raise GraphQL::ExecutionError, "Acesso negado: usuário não é coordenador"
                end
            end
        end
    end
end