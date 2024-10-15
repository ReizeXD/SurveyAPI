module Mutations
    module Options
        class UpdateOption < Mutations::BaseMutation
            input_object_class Types::Inputs::Option::UpdateOptionInput
            description "Editando uma Option"

            field :option, Types::OptionType, null: false
    
            def resolve(**arguments)
                if what_role=="coordinator"
                    begin
                        update = OptionServices.new(context[:current_user].id,arguments).call
                        {option: update}
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