# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :create_user, resolver: Mutations::Users::CreateUser
    field :login_user, resolver: Mutations::Users::LoginUser

    field :create_survey, resolver: Mutations::Surveys::CreateSurvey
    field :update_survey, resolver: Mutations::Surveys::UpdateSurvey
  end
end
