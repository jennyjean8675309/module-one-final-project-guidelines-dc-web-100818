require 'pry'

class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :difficulty

end
