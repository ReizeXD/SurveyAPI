require 'rails_helper'

RSpec.describe 'GraphQL Mutaions', type: :request do
    let!(:user) { create(:user)}
    it "login user" do


        mutation= <<~GQL
        mutation loginUser{
        loginUser(input: { 
        email: "a@gmail.com", 
        password: "123456" }) 
        {
        token
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
    puts json

    expect(json['data']['loginUser']['user']['email']).to eq('a@gmail.com')
    expect(json['data']['loginUser']['user']['name']).not_to be_nil

    # Verificar se o token foi retornado
    expect(json['data']['loginUser']['token']).not_to be_nil
    end
end