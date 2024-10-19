class ResponseServices
    def initialize(user_id,attributes)
        @user_id=user_id
        @attributes=attributes.to_hash
        @missing_questions=[]
        @invalid_options=[]
    end
    def call
        validate_response
        raise_errors_if_any
        new_response
    end

    private

    def new_response
        survey=Survey.find_by(id: @attributes[:survey_id])
        ActiveRecord::Base.transaction do
            @attributes[:responses].each do |response|
                existing_response = Response.find_by(question_id: response[:question_id], user_id: @user_id, survey_id: @attributes[:survey_id])
                if existing_response
                    existing_response.update!(content:response[:content])
                else
                    Response.create!(content:response[:content],question_id: response[:question_id], user_id: @user_id, survey_id: @attributes[:survey_id])
                end
            end
        end
        "Responses made successfully" 
    end

    
    def validate_response
        survey=Survey.find(@attributes[:survey_id])
        
        puts @user_id
        raise GraphQL::ExecutionError.new(I18n.t('errors.survey.survey_is_closed')) if survey.closed
        survey.questions.each do |question|
            response=response_question(question)
            if !response_exists?(question) #pode ser que faça a mutation com respostas apenas para as perguntas que sabe que ainda nao tem
                puts "To aqui 2"
                if response.nil?
                    @missing_questions << question.title
                else
                    validate_multiple_responses(question,response) if validate_type_question(question)
                end
            else
                validate_multiple_responses(question,response) if validate_type_question(question) && response!=nil
            end
        end
    end

    def response_question(question)
        responses=@attributes[:responses]

        responses.each do |response|
            if response[:question_id].to_i==question.id.to_i
                return response
            end
        end
        nil
    end


    def validate_type_question(question)
        ["choice_questions","checkbox"].include?(question.question_type)
    end

    def validate_multiple_responses(question,response)
        valid_option_contents = question.options.pluck(:content)
        unless valid_option_contents.include?(response[:content])
            @invalid_options << question.title
        end
    end

    def response_exists?(question)
        puts "to aqui"
        Response.exists?(question_id: question.id, user_id: @user_id, survey_id: @attributes[:survey_id],)
    end

    def raise_errors_if_any
        if @missing_questions.any?
          raise GraphQL::ExecutionError, "Some questions are missing responses: #{@missing_questions.join(', ')}"
        end
    
        if @invalid_options.any?
          raise GraphQL::ExecutionError, "Invalid options for the following questions: #{@invalid_options.join(', ')}"
        end
    end
end