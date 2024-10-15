class QuestionServices
    def initialize(user_id,attributes)
        @options=attributes.delete(:options)
        @attributes=attributes.to_hash
        @user_id=user_id
    end
    def call
        if @attributes[:delete].present?
            delete_question
        elsif @attributes[:id].present?
            update_question
        else
            new_question
        end
    end

    private

    def new_question
        survey=Survey.find_by(id: @attributes[:survey_id])
        if survey
            if survey.user_id==@user_id
                    Question.transaction do
                        question=Question.create!(@attributes)
                        if @attributes[:question_type]!=2 && @options.present?
                            @options.each do |option_content|
                                Option.create!(content: option_content, question: question)
                            end
                        end
                        question
                    end
            else
                raise GraphQL::ExecutionError, I18n.t('errors.question.access_denied')
            end
        else
            raise GraphQL::ExecutionError, I18n.t('errors.survey.not_exits')
        end
    rescue ActiveRecord::RecordInvalid => e
        raise GraphQL::ExecutionError, e.message
    end
    
    def update_question
        question=Question.find_by(id: @attributes[:id])
        if question
            survey=Survey.find_by(id: question.survey_id)
            if survey.user_id==@user_id

                if  @attributes[:question_type] == 2 && (question.choice_questions? || question.checkbox?)
                    question.options.destroy_all
                end

                ActiveRecord::Base.transaction do
                    if question.update(@attributes) 
                        if @options.present? && @attributes[:question_type] != 2
                            question.options.destroy_all
                            @options.each do |option_content|
                                Option.create!(content: option_content, question: question)
                            end
                        end
                        question=Question.find_by(id: @attributes[:id])
                        question
                    else
                        raise GraphQL::ExecutionError, question.errors.full_messages.join(", ")
                    end
                end
            else
                raise GraphQL::ExecutionError, I18n.t('errors.question.access_denied')
            end
        else
            raise GraphQL::ExecutionError, I18n.t('errors.question.not_exits')
        end
    end

    def delete_question
        question=Question.find_by(id: @attributes[:id])
        if question
            survey=Survey.find_by(id: question.survey_id)
            if survey.user_id==@user_id
                if question.destroy
                    "Question deleted successfully" 
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