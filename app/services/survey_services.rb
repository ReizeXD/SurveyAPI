class SurveyServices
    def initialize(user_id,attributes)
        @attributes=attributes.to_hash
        @user_id=user_id
    end
    def call
        if @attributes[:id].present?
            update_survey
        else
            new_survey
        end
    end

    private

    def new_survey
        survey=Survey.new(@attributes.merge(user_id: @user_id))
        if survey.save
            survey
        else
            raise GraphQL::ExecutionError, survey.errors.full_messages.join(", ")
        end
    end
    
    def update_survey
        survey=Survey.find_by(id: @attributes[:id])
        if survey
            if survey.user_id==@user_id
                if survey.update(@attributes)
                    survey
                else
                    raise GraphQL::ExecutionError, survey.errors.full_messages.join(", ")
                end
            else
                raise GraphQL::ExecutionError, I18n.t('errors.survey.access_denied')
            end
        else
            raise GraphQL::ExecutionError, I18n.t('errors.survey.not_exits')
        end
    end
end