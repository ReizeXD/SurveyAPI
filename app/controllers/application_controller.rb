class ApplicationController < ActionController::API
    def current_user
        if decoded_token
          params = decode_token
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
        else
          raise GraphQL::ExecutionError, "Token inválido ou ausente"
        end
      end
      


    def decoded_token
        puts "Headers: #{request.headers.to_h.inspect}"
        auth_header=request.headers['Authorization']
        puts "Auth Header: #{auth_header.inspect}" 
        token=auth_header.split(' ').last if auth_header
        puts "Decoded Token: #{token}"
        if token
            begin
              @decoded_token ||= JsonWebToken.decode(token)
            rescue ActiveRecord::RecordNotFound => e
              raise GraphQL::ExecutionError.new("Usuário não encontrado: #{e.message}")
            rescue JWT::DecodeError => e
              raise GraphQL::ExecutionError.new("Erro ao decodificar o token: #{e.message}")
            end
        else
            raise GraphQL::ExecutionError.new("Token não fornecido no cabeçalho de autorização")
        end
    end
end

