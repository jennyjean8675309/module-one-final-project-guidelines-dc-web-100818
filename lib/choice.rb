require 'pry'

class Choice < ActiveRecord::Base
  belongs_to :question
  delegate :category, :to => :question
end
