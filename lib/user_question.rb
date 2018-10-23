require 'pry'

class UserQuestion < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def validate_user_input(user_input)
    quest_hash = self.question.connect_letter_to_choice
    quest_hash[user_input].correct
  end

  def keep_score(user_input)
    if self.validate_user_input(user_input) == true
      new_score = self.user.score += 1
      user_instance = User.all.find { |user| user == self.user }
      user_instance.score = new_score
      self.user.save
    end
  end

  def tells_user_if_correct(user_input)
    if self.validate_user_input(user_input) == true
      puts "Good job!  You got that one right!"
    else
      puts "Sorry! That's incorrect."
    end
  end
end
