require 'pry'

class Category < ActiveRecord::Base
  has_many :questions

  # prompt = TTY::Prompt.new

  # def self.output_categories
  #   prompt = TTY::Prompt.new
  #   cats = Category.all.collect do |cat| cat.name end
  #   prompt.select("Please choose a category by name:", cats)

    # self.all.each_with_index do |category, i|
    # puts "#{i+1}. #{category.name}"
  # end


end
