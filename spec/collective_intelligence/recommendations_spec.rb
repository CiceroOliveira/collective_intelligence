require 'spec_helper'

module CollectiveIntelligence
  describe Recommendations do
  
    critics=
    {'Lisa Rose' =>
    {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 'Superman Returns' => 3.5, 'You, Me and Dupree' => 2.5,'The Night Listener' => 3.0},
    'Gene Seymour' =>
    {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 3.5, 'Just My Luck' => 1.5, 'Superman Returns' => 5.0, 'The Night Listener' => 3.0, 'You, Me and Dupree' => 3.5},
    'Michael Phillips' =>
    {'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.0, 'Superman Returns' => 3.5, 'The Night Listener' => 4.0}, 
    'Claudia Puig' =>
    {'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 'The Night Listener' => 4.5, 'Superman Returns' => 4.0, 'You, Me and Dupree' => 2.5},
    'Mick LaSalle' =>
    {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 'Just My Luck' => 2.0, 'Superman Returns' => 3.0, 'The Night Listener' => 3.0, 'You, Me and Dupree' => 2.0},
    'Jack Matthews' =>
    {'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0, 'The Night Listener' => 3.0, 'Superman Returns' => 5.0, 'You, Me and Dupree' => 3.5},
    'Toby' =>
    {'Snakes on a Plane' =>4.5,'You, Me and Dupree' =>1.0,'Superman Returns' =>4.0},
    #'Cicero' =>
    #{'Lady in the Water' => 2.5, 'Snakes on a Plane' => 3.5, 'Just My Luck' => 3.0, 'Superman Returns' => 3.5, 'You, Me and Dupree' => 2.5,'The Night Listener' => 3.0}
    }
    
    it 'should return pearson similarity' do
      Recommendations::similarity_pearson(critics, 'Lisa Rose', 'Gene Seymour').should == 0.39605901719066977
    end
    
    it 'should return distance similarity' do
      Recommendations::similarity_distance(critics, 'Lisa Rose', 'Gene Seymour').should == 0.14814814814814814
    end
    
    #puts similarity_distance(critics, 'Lisa Rose', 'Cicero')
    #puts Recommendations::similarity_pearson(critics, 'Lisa Rose', 'Toby')
    it 'should return top matches' do
      n_matches = 3
      top_matches = Recommendations::top_matches(critics,'Toby',3)
      top_matches.length.should == n_matches
      top_matches[0].include?('Lisa Rose').should be(true)
    end
    
    it 'should return recommendations' do
      recommendations = Recommendations::get_recommendations(critics,'Toby')
      recommendations.should == [[3.3477895267131017, "The Night Listener"], [2.8325499182641614, "Lady in the Water"], [2.530980703765565, "Just My Luck"]]
    end
  end
end