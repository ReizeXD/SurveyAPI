module Mutations
    module Questions
        class CreateQuestion < Mutations::BaseMutation
            input_object_class Types::Inputs::Question::CreateQuestionInput
            
            description "Criando uma questão"

            field :question, Types::QuestionType, null: false
    
            def resolve(**arguments)
                if what_role=="coordinator"
                    begin
                        create = QuestionServices.new(context[:current_user].id,arguments).call
                        
                        create[:question_type] = Question.question_types[create[:question_type]] if create[:question_type].is_a?(String)

                        {question: create}
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