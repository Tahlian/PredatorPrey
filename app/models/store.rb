class Store < ActiveRecord::Base #The store scaffold model
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :predator, :prey, :time, numericality: { only_integer: true }, allow_blank: true
  validates :alpha, :beta, :gamma, :delta, :timeincrement, numericality: true, allow_blank: true

  def flag

  end
end
