# require_relative 'spec_helper'
require_relative '../lib/question.rb'
require_relative '../lib/category.rb'
require_relative '../lib/choice.rb'
require_relative '../lib/user.rb'
require_relative '../lib/user_question.rb'


#Question class tests
describe Question do

  cat1 = Category.new(name: "Movies")
  cat2 = Category.new(name: "Science")

  it "belongs to a category" do
    q1 = Question.new(question: "How many Jaws movies are there?", category: cat1, difficulty: "easy")
    expect(Question.find_by(question: "How many Jaws movies are there?").category.to eq(cat1))
  end

  it "has a difficulty level" do
    q2 = Question.create(question: "What is the name of Annie's dog in Annie?", category: cat1, difficulty: "hard")
    expect(Question.find_by(question: "What is the name of Annie's dog in Annie?").difficulty.to eq("hard"))
  end

end


#Category class tests
describe Category do

  cat3 = Category.new(name: "Books")
  q1 = Question.new(question: "Who is the author of To Kill a Mockingbird?", category: cat3, difficulty: "medium")
  q2 = Question.new(question: "How many books are in the Harry Potter series?", category: cat3, difficulty: "easy")

  it "has many questions" do
    expect(cat3.questions.count).to eq(2)
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
    expect(choice1.correct).to eq("false")
  end

end

#Instantiating users and questions for UserQuestion class
cat1 = Category.new(name: "Movies")
cat2 = Category.new(name: "Science")

q1 = Question.new(question: "What is the lightest element?", category: cat2, difficulty: "easy")
q2 = Question.new(name: "What is the name of Jack Nicholson's character in The Shining?", category: cat2, difficulty: "easy")

mike = User.new(name: "Mike")
jenny = User.new(name: "Jenny")


#UserQuestion class tests
describe UserQuestion do

 it "belongs to a question" do
  uq1 = UserQuestion.new(question: q1, user: mike)
  expect(uq1.question).to eq(q1)
 end

 it "belongs to a user" do
   uq2 = UserQuestion.new(question: q2, user: jenny)
   expect(uq2.user).to eq(jenny)
 end

end
