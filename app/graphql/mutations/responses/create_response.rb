module Mutations
    module Responses
        class CreateResponse < Mutations::BaseMutation
            input_object_class Types::Inputs::Response::SubmitResponseInput
            
            description "Criando respostas"

            field :message, String, null: false
    
            def resolve(**arguments)
                is_logged?
                begin
                    ResponseServices.new(context[:current_user].id,arguments).call
                    { message: "Respostas criadas com sucesso!" }
                rescue ActiveRecord::RecordInvalid => e
                    raise GraphQL::ExecutionError, e.message
                end
            end
        end
    end
end