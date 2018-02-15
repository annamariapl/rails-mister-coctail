class Ingredient < ApplicationRecord
	validates :name, uniqness: true
end
