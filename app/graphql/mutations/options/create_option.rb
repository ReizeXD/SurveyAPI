module Mutations
    module Options
        class CreateOption < Mutations::BaseMutation
            input_object_class Types::Inputs::Option::CreateOptionInput

            description "Criando uma option"

            field :option, Types::OptionType, null: false
    
            def resolve(**arguments)
                if what_role=="coordinator"
                    begin
                        create = OptionServices.new(context[:current_user].id,arguments).call

                        {option: create}
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