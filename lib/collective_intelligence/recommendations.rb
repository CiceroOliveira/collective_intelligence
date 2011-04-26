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
	
	  # Return the best matches for person from the prefs dictionary.
	  # Number of results and similarity function are optional
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
  	
  	# Gets recommendations for a person by using a weighted average
  	# of every other user's rankings
  	def self.get_recommendations(preferences, person, similarity=:similarity_pearson)
  	  totals = {}
  	  similarity_sums = {}
  	  
  	  preferences.each do |other|
        
        # Don't compare person with itself
  	    if other[0] != person

  	      sim = (send similarity, preferences, person, other[0])
  	      
  	      # Ignore scores lower than zero
  	      if sim > 0

  	        preferences[other[0]].each do |item, score|
  	          
  	          # Only scores items not already scored
              if preferences[person].has_key?(item) == false  || preferences[person][item] == 0
                
                totals.default = 0
                totals[item] += preferences[other[0]][item] * sim
                
                similarity_sums.default = 0
                similarity_sums[item] += sim
              end
            end
	        end
	        
  	    end
  	     
  	  end
  	  
  	  rankings = []
  	    
  	  totals.each do |item, total|
        rankings << [(total/similarity_sums[item]),item]
      end

      rankings.sort.reverse
  	      
	  end
	  
  end
end