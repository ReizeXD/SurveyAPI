module Types
    module Inputs
        module Question
            class UpdateQuestionInput < Types::BaseInputObject
                argument :id, ID, required: true
                argument :title, String, required: false
                argument :question_type, Integer, required: false
                argument :options, [String], required: false
                argument :survey_id, ID, required: false
            end
        end
    end
end
    