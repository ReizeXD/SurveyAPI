require 'rails_helper'

RSpec.describe 'GraphQL Mutations',type: :request do
    let(:user) { create(:user) }
    let(:valid_token) { JsonWebToken.encode(user_id: user.id) }
    it "Creates a new Survey" do
        mutation= <<~GQL
        mutation {
          createSurvey(input: {
            title: "Pesquisa 1",
            closed:false,
            startDate: "2024-10-01",
            endDate: "2024-10-10"
          }) {
            survey {
              id
              title
              startDate
              endDate
            }
          }
        }
      GQL

    headers = { 'Authorization' => "Bearer #{valid_token}" }
    post '/graphql', params: {query: mutation}, headers: headers

    puts response.body
    json =JSON.parse(response.body)
    
    survey= json['data']['createSurvey']['survey']

    expect(survey['title']).to eq('Pesquisa 1')
    expect(survey['startDate']).to eq('2024-10-01')
    expect(survey['endDate']).to eq('2024-10-10')
    end
end