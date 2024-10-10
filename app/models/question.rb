class Question < ApplicationRecord
  belongs_to :survey

  has_many :responses,dependent: :destroy
  has_many :options,dependent: :destroy

  enum question_type: {choice_questions: 0, checkbox: 1, text: 2}

  validates :title, presence: true
  validates :question_type, presence: true
  
  TYPE_QUESTION = {
    "text" => "Texto",
    "choice_questions" => "Multiplas Escolhas",
    "checkbox" => "Caixa de seleção"
  }.freeze

end
