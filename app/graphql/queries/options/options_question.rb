module Queries
    module Options
        class OptionsQuestion < Queries::BaseQuery
            type [Types::OptionType], null: false
        
            argument :id, ID, required: true, description: "ID da Question"
            def resolve(id:)
                if what_role=="coordinator"
                    begin
                        question=Question.find(id)
                        survey=question.survey
                        if survey.user_id==context[:current_user].id
                            question.options
                        else
                            raise GraphQL::ExecutionError, I18n.t('errors.survey.access_denied')
                        end
                    rescue ActiveRecord::RecordNotFound
                        raise GraphQL::ExecutionError, I18n.t('errors.question.not_exits')
                    rescue ActiveRecord::RecordInvalid => e
                        raise GraphQL::ExecutionError, e.message
                    end
                else
                    Survey.where(closed: false).where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
                end
            end
        end
    end
end