# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


    user1=User.create!(name: "Anderson", email: "a@gmail.com",password: "123456", password_confirmation: "123456")
    user2=User.create!(name: "Ander", email: "ander@gmail.com",password: "123456",password_confirmation: "123456",role: :coordinator )

    survey=Survey.create!(title: "Pesquisa 1", start_date: "2024-09-18", end_date: "2024-09-30", closed: false,user_id: 2)
    question=Question.create!(title: "Questão 1", question_type: 0, survey_id: 1)
    option1=Option.create!(content:"Letra A", question_id: 1)
    option2=Option.create!(content:"Letra B",question_id: 1)

    response=Response.create!(content: "Resposta da pesquisa", survey_id: 1, question_id: 1, user_id:1)