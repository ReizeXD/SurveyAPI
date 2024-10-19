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
    field :delete_survey, resolver: Mutations::Surveys::DeleteSurvey
    
    
    field :create_question, resolver: Mutations::Questions::CreateQuestion
    field :update_question, resolver: Mutations::Questions::UpdateQuestion
    field :delete_quetion, resolver: Mutations::Questions::DeleteQuestion
    
    field :create_option, resolver: Mutations::Options::CreateOption
    field :update_option, resolver: Mutations::Options::UpdateOption
    field :delete_option, resolver: Mutations::Options::DeleteOption
    
    field :create_response, resolver: Mutations::Responses::CreateResponse


  end
end


