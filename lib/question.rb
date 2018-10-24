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

  def shuffle_choices
    shuffled_choices = self.choices.sort_by { rand }
    self.choices = shuffled_choices
    self.save
  end

  def format_choices
    puts "A. #{self.choices[0].name}"
    puts "B. #{self.choices[1].name}"
    puts "C. #{self.choices[2].name}"
    puts "D. #{self.choices[3].name}"
  end

  def connect_letter_to_choice
    {"A" => self.choices[0], "B" => self.choices[1], "C" => self.choices[2], "D" => self.choices[3] }
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
    q.shuffle_choices
    q
  end
end

0
