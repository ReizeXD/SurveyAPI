module Types
    module Inputs
        module Question
            class CreateQuestionInput < Types::BaseInputObject
                argument :title, String, required: true
                argument :question_type, Integer, required: true
                argument :options, [String], required: true
                argument :survey_id, ID, required: true
            end
        end
    end
end
    