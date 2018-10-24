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

  def self.give_user_question(input)
    q = self.questions_by_category(input).sample
    puts q.question
    puts q.format_choices
    q
  end






  # @@all = []

  #def self.create_questions
    #get_trivia_hash.each do |question_hash|
      #question_hash = Question.new(question: , category: )
      #@@all << question_hash
    #end
    #@@all
  #end
end

0
