module Mutations
    module Users 
        class CreateUser < Mutations::BaseMutation
            input_object_class Types::Inputs::User::CreateUserInput
    
            description "Criando um usuario"

            field :user, Types::UserType, null: false
            field :token, String, null: false
    
            def resolve(**arguments)
                create = UserServices.new(arguments).call
                { user: create[:user], token: create[:token] }
            rescue ActiveRecord::RecordInvalid => e
                raise GraphQL::ExecutionError, e.message
            end
        end
    end
end