class Cocktail < ApplicationRecord
	validates :name, uniqness: true
end
