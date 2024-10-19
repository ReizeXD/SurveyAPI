# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    #field :test_field, String, null: false,
     # description: "An example field added by the generator"
    #def test_field
    #  "Hello World!"
    #end

    field :all_surveys, resolver: Queries::Surveys::AllSurveys, description: "Retorna uma lista com todas as pesquisas"
    field :survey_by_id, resolver: Queries::Surveys::SurveyById, description: "Retorna uma pesquisa pelo id fornecido"
    field :open_surveys, resolver: Queries::Surveys::OpenSurveys, description: "Retorna uma lista com todas as pesquisas abertas"
    field :closed_surveys, resolver: Queries::Surveys::ClosedSurveys, description: "Retorna uma lista com todas as pesquisas fechadas"
    field :users_surveys, resolver: Queries::Surveys::UserSurveys, description: "Retorna uma lista com todas as pesquisas do coordenador"
      
    field :options_question, resolver: Queries::Options::OptionsQuestion, description: "Retorna uma lista com as opçoes das questoes"


    field :get_survey_results, resolver: Queries::Responses::GetSurveyResults, description: "Retorna uma lista com tabular com os resultados"


      

  end
end
