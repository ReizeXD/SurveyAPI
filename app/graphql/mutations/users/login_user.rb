module Mutations
    module Users 
        class LoginUser < Mutations::BaseMutation
            input_object_class Types::Inputs::User::LoginUserInput

            field :user, Types::UserType, null: false
            field :token, String, null: false
            def resolve(**arguments)
                login=UserServices.new(arguments).call
                { user: login[:user], token: login[:token] }
            rescue ActiveRecord::RecordInvalid => e
                raise GraphQL::ExecutionError, e.message
            end
        end
    end
end