module Queries
    class BaseQuery < GraphQL::Schema::Resolver
    

        def current_user
            context[:current_user]
        end

        def is_logged?
            unless current_user
                raise GraphQL::ExecutionError, "Usuario não está logado"
            end
            true
        end

        def what_role
            if is_logged?
                current_user.role
            end
        end
    end
end