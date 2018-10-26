require 'pry'

class Category < ActiveRecord::Base
  has_many :questions

  def self.output_categories
    self.all.each_with_index do |category, i|
      puts "#{i+1}. #{category.name}"
    end
  end
end
