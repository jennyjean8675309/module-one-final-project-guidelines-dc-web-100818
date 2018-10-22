require 'pry'

class Category < ActiveRecord::Base
  has_many :questions
  has_many :difficulties, through: :questions
end
