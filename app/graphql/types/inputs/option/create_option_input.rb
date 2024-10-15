module Types
    module Inputs
        module Option
            class CreateOptionInput < Types::BaseInputObject
                argument :content, String, required: true
                argument :question_id, ID, required: true
            end
        end
    end
end
    