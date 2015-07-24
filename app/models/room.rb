class Room < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	has_many :reviewed_rooms, through: :reviews, source: :room
	belongs_to :user

	def complete_name
		"#{title}, #{location}"
	end

	def self.most_recent
		all.order(:created_at).limit(3)
	end
end
