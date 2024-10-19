module Types
    module Inputs
        module Response
            class ResponseInput < Types::BaseInputObject
                argument :question_id, ID, required: true
                argument :content, String, required: true
            end
        end
    end
end
    