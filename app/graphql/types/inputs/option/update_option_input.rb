module Types
    module Inputs
        module Option
            class UpdateOptionInput < Types::BaseInputObject
                argument :id, ID, required: true
                argument :content, String, required: false
                argument :question_id, ID, required: false
            end
        end
    end
end
    