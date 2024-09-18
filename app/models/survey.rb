class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :responses, through: :questions


  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :end_date_after_start_date

  #valida se a data de término é posterior à data de início
  def end_date_after_start_date
    if end_date < start_date
      errors.add(:end_date, "deve ser posterior à data de início")
    end
  end

  #  verifica se a pesquisa está aberta
  def open?
    !closed && Date.today.between?(start_date, end_date)
  end
end
end
