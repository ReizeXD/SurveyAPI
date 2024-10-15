module Mutations
    module Questions
        class DeleteQuestion < Mutations::BaseMutation
            
            description "Deletando uma questao"
            field :message, String, null: false

            argument :id, ID, required: true
            def resolve(id:)
                if what_role=="coordinator"
                    begin
                        delete = QuestionServices.new(context[:current_user].id, {id: id, delete:true}).call
                        {message: delete}
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