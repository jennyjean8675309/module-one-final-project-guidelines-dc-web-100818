require 'pry'
require 'colorize'

class UserQuestion < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def validate_user_input(user_input)
    user_answer = self.question.randomized_choices[user_input]
    user_answer == self.question.correct_answer
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
      puts "\u{1f60e} Good job!  You got that one right! \u{1f60e}"
      puts "*"*50
    else
      puts "\u{1f61e} Sorry! That's incorrect. \u{1f61e}".colorize(:red)
      puts "The correct answer is #{(self.question.choices.find {|choice| choice.correct == true}).name}".colorize(:red)
      puts "*"*50
    end
  end
end
