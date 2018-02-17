class Cocktail < ApplicationRecord
	mount_uploader :image, PhotoUploader
	has_many :doses, dependent: :destroy 
	has_many :ingredients, through: :doses

	validates :name, uniqueness: true
	validates :name, presence: true


	# def next
	# 	Cocktail.where("id > ?", id).limit(1).first
	# end
# problem start when we create a new constance && it tries to run it than

end
