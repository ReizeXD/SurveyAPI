module Types
  module Inputs
    module User 
      class CreateUserInput < Types::BaseInputObject
        argument :name, String, required: true
        argument :email, String, required: true
        argument :password, String, required: true
        argument :role, String, required: false
      end
    end
  end
end
  