require 'pry'

class User < ActiveRecord::Base
  has_many :user_questions
  has_many :questions, through: :user_questions
end
