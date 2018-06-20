#!/usr/bin/env ruby

require "datasets"

red = []
Datasets::WineQuality.new(:red).each do |wine|
  red << [
     wine.fixed_acidity,
     wine.volatile_acidity,
     wine.citric_acid,
     wine.residual_sugar,
     wine.chlorides,
     wine.free_sulfur_dioxide,
     wine.total_sulfur_dioxide,
     wine.density,
     wine.ph,
     wine.sulphates,
     wine.alcohol,
     wine.quality
]
end
p red

white = []
Datasets::WineQuality.new(:white).each do |wine|
  white << [
     wine.fixed_acidity,
     wine.volatile_acidity,
     wine.citric_acid,
     wine.residual_sugar,
     wine.chlorides,
     wine.free_sulfur_dioxide,
     wine.total_sulfur_dioxide,
     wine.density,
     wine.ph,
     wine.sulphates,
     wine.alcohol,
     wine.quality
]
end
p white
