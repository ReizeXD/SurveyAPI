# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

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
