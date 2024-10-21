require 'rails_helper'

RSpec.describe 'GraphQL Mutations',type: :request do 

    it "creates a new user" do
        mutation= <<~GQL
        mutation {
        createUser(input: {
          name: "Anderson",
          email: "anderson@gmail.com",
          password: "123456"
        }) {
          user {
            id
            name
            email
          }
        }
      }
    GQL

    post '/graphql', params: {query: mutation}, headers: headers

    puts response.body
    json= JSON.parse(response.body)

    expect(json['data']['createUser']['user']['name']).to eq('Anderson')
    expect(json['data']['createUser']['user']['email']).to eq('anderson@gmail.com')


    end
end