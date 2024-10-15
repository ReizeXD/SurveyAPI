class OptionServices
    def initialize(user_id,attributes)
        @attributes=attributes.to_hash
        @user_id=user_id
    end
    def call
        if @attributes[:delete].present?
            delete_option
        elsif @attributes[:id].present?
            update_option
        else
            new_option
        end
    end

    private

    def new_option
        begin
            question=Question.find(@attributes[:question_id])
            survey=question.survey
            if survey.user_id==@user_id
                option=nil
                Option.transaction do
                    option=Option.create!(@attributes)
                end
                option
            else
                raise GraphQL::ExecutionError, I18n.t('errors.survey.access_denied')
            end
        rescue ActiveRecord::RecordNotFound
            raise GraphQL::ExecutionError, I18n.t('errors.question.not_exits')
          rescue ActiveRecord::RecordInvalid => e
            raise GraphQL::ExecutionError, e.message
        end
    end
    
    def update_option
        option=Option.find(@attributes[:id])
        survey=option.question.survey
        
        if survey.user_id==@user_id
            if @attributes[:question_id].present?
                to_question=Question.find(@attributes[:question_id])
                unless to_question.survey == survey
                    raise GraphQL::ExecutionError, I18n.t('errors.survey.access_denied')
                  end
            end
            
            Option.transaction do
                if option.update(@attributes)
                    option=Option.find(@attributes[:id])
                    option
                else
                    raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
                end
            end
        else
            raise GraphQL::ExecutionError, I18n.t('errors.survey.access_denied')
        end
    end

    def delete_option
        option=Option.find(@attributes[:id])
        survey=option.question.survey
        
        if survey.user_id==@user_id
            if option.destroy
                "Question deleted successfully" 
            else
                raise GraphQL::ExecutionError, survey.errors.full_messages.join(", ")
            end
        else
            raise GraphQL::ExecutionError, I18n.t('errors.survey.access_denied')
        end
    end
end