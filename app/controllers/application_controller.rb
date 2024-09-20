class ApplicationController < ActionController::API
    def current_user
        if decoded_token
            params=decode_token
            user = User.find_by(id: params[:user_id]) if params[:user_id].present?
            @current_user ||= user if params[:user_id].present? && params[:role].present?
    end


    def decoded_token
        auth_header=request.headers['Authorization']
        token=auth_header.split(' ').last if auth_header
        if token
            begin
                @decoded_token ||=JsonWebToken.decode(token)
            rescue ActiveRecord::RecordNotFound=> e
                raise GraphQL::ExecutionError.new(e.message)
            rescue JWT::DecodeError=>e
                raise GraphQL::ExecutionError.new(e.message)
            end
        end
    end
end
