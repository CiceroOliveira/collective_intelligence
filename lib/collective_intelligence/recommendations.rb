module CollectiveIntelligence
  module Recommendations
  	include Math
	
  	#Euclidian distance - distance based similarity
  	def self.similarity_distance(preferences, person1, person2)
  		shared_items = {}
		
  		preferences[person1].each do |key, value|
  			if preferences[person2]
  				shared_items[key] = 1 if preferences[person2].has_key? key
  			end
  		end
			
  		return 0 if shared_items.length == 0
		
  		squares_sum = 0
		
  		preferences[person1].each do |key, value|
  			squares_sum += (preferences[person1][key] - preferences[person2][key]) ** 2
  		end
  		return 1/(1+squares_sum)
  	end
	
  	# Pearson correlation coeficient
  	def self.similarity_pearson(preferences, person1, person2)
  		shared_items = {}
		
  		preferences[person1].each do |key, value|
  			shared_items[key] = 1 if preferences[person2].has_key? key
  		end
		
  		n = shared_items.length
		
  		return 0 if n==0
		
  		sum1, sum2 = 0, 0
		
  		shared_items.each do |key, value|
  			sum1 += preferences[person1][key]
  			sum2 += preferences[person2][key]
  		end
		
  		sum1_sq, sum2_sq = 0, 0

  		shared_items.each do |key, value|
  			sum1_sq += (preferences[person1][key] ** 2)
  			sum2_sq += (preferences[person2][key] ** 2)
  		end
		
  		sum_products = 0

  		shared_items.each do |key, value|
  			sum_products += (preferences[person1][key] * preferences[person2][key])
  		end
		
  		# Calculate the Pearson Score
  		num = sum_products - (sum1 * sum2/n)
  		den = Math::sqrt((sum1_sq - sum1 ** 2/n) * (sum2_sq - sum2 ** 2 / n))
		
  		den == 0 ? 0 : num/den
  	end
	
  	def self.top_matches(preferences, person, n=5, similarity=:similarity_pearson)
  		scores = []
  		preferences.each do |other|
  			if other[0] != person
  				scores << [(send similarity, preferences, person, other[0]), other[0]]
  			end
  		end

  		scores.sort!
  		scores.reverse!
  		return scores[0...n]
  	end
  end
end