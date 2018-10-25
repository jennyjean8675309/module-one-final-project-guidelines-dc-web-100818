require_relative './api_communicator.rb'
require 'pry'

class Question < ActiveRecord::Base
  belongs_to :category
  has_many :choices
  has_many :user_questions
  has_many :users, through: :user_questions

  def self.ask_question
    self.all.sample
  end

  def randomized_choices
    @rand
  end

  def format_choices
    puts "A. #{@rand["A"].name}"
    puts "B. #{@rand["B"].name}"
    puts "C. #{@rand["C"].name}"
    puts "D. #{@rand["D"].name}"
  end

  def connect_letter_to_choice
    num = [0, 1, 2, 3]
    rand1 = num.sample
    num.delete(rand1)
    rand2 = num.sample
    num.delete(rand2)
    rand3 = num.sample
    num.delete(rand3)
    rand4 = num[0]
    @rand = {"A" => self.choices[rand1], "B" => self.choices[rand2], "C" => self.choices[rand3], "D" => self.choices[rand4] }
  end

  def correct_answer
    self.choices.find { |choice| choice.correct == true }
  end

  def self.questions_by_category(input)
    self.all.select { |q| q.category.name == input }
  end

  def self.questions_by_difficulty(input, difficulty)
    self.questions_by_category(input).select { |ques| ques.difficulty == difficulty}
  end

  def self.give_user_question(input, difficulty)
    q = self.questions_by_difficulty(input,difficulty).sample
  end
end

0
