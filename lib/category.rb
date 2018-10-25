require 'pry'

class Category < ActiveRecord::Base
  has_many :questions

  def self.output_categories
    self.all.each do |category|
      puts category.name
    end
  end
end
