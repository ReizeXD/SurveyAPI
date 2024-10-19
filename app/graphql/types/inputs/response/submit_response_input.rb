module Types
    module Inputs
        module Response
            class SubmitResponseInput < Types::BaseInputObject
                argument :survey_id, ID, required: true
                argument :responses, [ResponseInput], required: true
            end
        end
    end
end
    