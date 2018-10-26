require 'pry'

require_relative '../lib/question.rb'
require_relative '../lib/category.rb'
require_relative '../lib/choice.rb'
require_relative '../lib/user.rb'
require_relative '../lib/user_question.rb'


#Question class tests
describe Question do

  cat1 = Category.new(name: "Movies")
  cat2 = Category.new(name: "Science")

  q1 = Question.new(question: "How many Jaws movies are there?", category: cat1, difficulty: "easy")
  q2 = Question.new(question: "What is the name of Annie's dog in Annie?", category: cat1, difficulty: "hard")
  q3 = Question.all[0]

  choice1 = Choice.new(name: "a gazillion", question: q1, correct: true)
  choice2 = Choice.new(name: "not that many", question: q1, correct: false)
  q1.choices << choice1
  q1.choices << choice2

  it "belongs to a category" do
    expect(q1.category).to eq(cat1)
  end

  it "has a difficulty level" do
    expect(q2.difficulty).to eq("hard")
  end

  it "can find its correct answer" do
    expect(q1.correct_answer).to eq(choice1)
  end

end


#Choice class tests
describe Choice do

  cat4 = Category.new(name: "Geography")
  q1 = Question.new(question: "What is the capital of Venezuela?", category: cat4, difficulty: "medium")
  choice1 = Choice.new(name: "London", question: q1, correct: "false")
  choice2 = Choice.new(name: "Caracas", question: q1, correct: "true")

  it "belongs to a question" do
    expect(choice1.question).to eq(q1)
  end

  it "returns a boolean for whether or not it is the correct choice" do
    expect(choice1.correct).to eq(false)
  end

end

#Instantiating users and questions for UserQuestion class
cat1 = Category.new(name: "Movies")
cat2 = Category.new(name: "Science")

q1 = Question.new(question: "What is the lightest element?", category: cat2, difficulty: "easy")
q2 = Question.new(question: "What is the name of Jack Nicholson's character in The Shining?", category: cat2, difficulty: "easy")


mike = User.new(name: "Mike")
jenny = User.new(name: "Jenny")

#User class tests
describe User do

  it "instantiates a user with a score of 0" do
    expect(mike.score).to eq(0)
  end

end


#UserQuestion class tests
describe UserQuestion do

 uq3 = UserQuestion.all[0]

 it "belongs to a question" do
  uq1 = UserQuestion.new(question: q1, user: mike)
  expect(uq1.question).to eq(q1)
 end

 it "belongs to a user" do
   uq2 = UserQuestion.new(question: q2, user: jenny)
   expect(uq2.user).to eq(jenny)
 end

 it "validates the user input (answer) for a particular question and returns true if the answer is correct and false if the answer is incorrect" do
   correct = Choice.all.find { |choice| choice.name == "George Washington" }
   choices = uq3.question.connect_letter_to_choice
   random = uq3.question.randomized_choices
   user_input = random.select { |letter, answer| answer.name == "George Washington"}
   user_input_final = user_input.keys[0]
   expect(uq3.validate_user_input(user_input_final)).to eq(true)
 end

end
