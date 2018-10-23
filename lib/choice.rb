require 'pry'

class Choice < ActiveRecord::Base
  belongs_to :question
  delegate :category, :to => :question

  def validate_user_input
    
  end
end
