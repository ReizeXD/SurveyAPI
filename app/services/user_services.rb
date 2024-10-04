class UserServices
    def initialize(attributes)
        @attributes=attributes.to_hash
    end
    def call
        if @attributes[:name].present?
            new_user
        else
            login_user
        end
    end

    private

    def new_user
        user=User.new(@attributes)
        if user.save
            token = JsonWebToken.encode({user_id: user.id, role: user.role})
            if token
                { user: user, token: token }
            else
                raise GraphQL::ExecutionError.new(I18n.t('errors.user.token_not_created'))
            end
        else
            raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
        end
    end
    
    def login_user
        user=User.find_by(email: @attributes[:email])
        if user && user.authenticate(@attributes[:password])
            token = JsonWebToken.encode({user_id: user.id, role: user.role})
            if token
                { user: user, token: token }
            else
                raise GraphQL::ExecutionError.new(I18n.t('errors.user.token_not_created'))
            end
        else
            raise GraphQL::ExecutionError, I18n.t('errors.user.invalid_credentials')
        end
    end
end