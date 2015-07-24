class User < ActiveRecord::Base
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	has_many :reviews, dependent: :destroy
	has_many :rooms, dependent: :destroy

	scope :confirmed, -> { where.not(confirmado_em: nil)}

	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minumum: 30, allow_blank: false
	validates_format_of :email, with: EMAIL_REGEXP

	has_secure_password

	before_create do |user|
		user.codigo_confirmacao = SecureRandom.urlsafe_base64
	end

	def self.authenticate(email, password)
		confirmed.find_by(email: email).try(:authenticate, password)
	end

	def confirm!
		return if confirmed?

		self.confirmado_em = Time.current 
		self.codigo_confirmacao = ''
		save!
	end

	def confirmed?
		confirmado_em.present?
	end
end
