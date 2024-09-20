module Queries
    class AllSurveys < Queries::BaseQuery
    type[Types::SurveyType], null: false, description: "Retorna uma lista com todas as pesquisas"
    
        def resolve      
        end
    
    
    end