module Mutations
    module Questions
        class UpdateQuestion < Mutations::BaseMutation
            input_object_class Types::Inputs::Question::UpdateQuestionInput
            
            description "Editando uma questão"

            field :question, Types::QuestionType, null: false
    
            def resolve(**arguments)
                if what_role=="coordinator"
                    begin
                        update = QuestionServices.new(context[:current_user].id,arguments).call
                        {question: update}
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