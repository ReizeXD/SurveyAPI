class ApplicationController < ActionController::API

  def current_user
        if decode_token
          params = decoded_token
          if params[:user_id].present?
            user = User.find_by(id: params[:user_id])
            if user
              @current_user ||= user
            else
              raise GraphQL::ExecutionError, "Usuário não encontrado com o ID fornecido"
            end
          else
            raise GraphQL::ExecutionError, "ID do usuário não presente no token"
          end
        end
    end
      


    def decode_token
        auth_header=request.headers['Authorization']
        token=auth_header.split(' ').last if auth_header
        if token
            begin
              @decoded_token ||= JsonWebToken.decode(token)
            rescue ActiveRecord::RecordNotFound => e
              raise GraphQL::ExecutionError.new("Usuário não encontrado: #{e.message}")
            rescue JWT::DecodeError => e
              raise GraphQL::ExecutionError.new("Erro ao decodificar o token: #{e.message}")
            end
        end
    end
end

