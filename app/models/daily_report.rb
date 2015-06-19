class DailyReport < ActiveRecord::Base
	belongs_to :employee
	before_create :generate_uniq_token
  scope :on_day, -> (day) {where(created_at: day.beginning_of_day..day.end_of_day) }


	def generate_uniq_token	
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(access_token: random_token)
    end
	end

  def completed?
    self.score
  end

  def self.completed
    self.where("score is not null")
  end

end
