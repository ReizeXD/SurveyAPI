class Option < ApplicationRecord
  belongs_to :question

  validates :content, presence: true

  def response_count
    Response.where(content: self.content, question_id: self.question_id).count
  end
  
end
