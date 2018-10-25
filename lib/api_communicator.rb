require 'rest-client'
require 'JSON'
require 'pry'

def get_trivia_hash
  general_knowledge_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=9&type=multiple')
  general_knowledge_parsed = JSON.parse(general_knowledge_q)

  enter_film_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=11&type=multiple')
  enter_film_parsed = JSON.parse(enter_film_q)

  sc_and_na_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=17&type=multiple')
  sc_and_na_q_parsed = JSON.parse(sc_and_na_q)

  geography_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=22&type=multiple')
  geography_q_parsed = JSON.parse(geography_q)

  enter_books_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=10&type=multiple')
  enter_books_q_parsed = JSON.parse(enter_books_q)

  history_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=23&type=multiple')
  history_q_parsed = JSON.parse(history_q)

  all_APIs = [general_knowledge_parsed, enter_film_parsed, sc_and_na_q_parsed, geography_q_parsed, enter_books_q_parsed, history_q_parsed]
  all_APIs.collect do |question_hash|
    question_hash["results"]
  end.flatten
end

TRIVIA = get_trivia_hash

def create_categories
  TRIVIA.collect do |question_hash|
    question_hash["category"]
  end.uniq.each do |cat|
    Category.create(name: cat)
  end
end

def connect_category_to_instance
  {
    "General Knowledge" => Category.all.find{|cat| cat.name == "General Knowledge"},
    "Entertainment: Film" => Category.all.find{|cat| cat.name == "Entertainment: Film"},
    "Science & Nature" => Category.all.find{|cat| cat.name == "Science & Nature"},
    "Geography" => Category.all.find{|cat| cat.name == "Geography"},
    "Entertainment: Books" => Category.all.find{|cat| cat.name == "Entertainment: Books"},
    "History" => Category.all.find{|cat| cat.name == "History"}}
end

def create_questions
  TRIVIA.each do |question_hash|
    Question.find_or_create_by(question: question_hash["question"], category: connect_category_to_instance[question_hash["category"]], difficulty: question_hash["difficulty"])
  end
end

def find_questions(string)
  Question.all.find_by(question: string)
end

def create_correct_choices
  TRIVIA.each do |question_hash|
    my_quest = find_questions(question_hash["question"])
    Choice.find_or_create_by name: question_hash["correct_answer"], correct: true, question: my_quest
  end
end

def create_incorrect_choices
  TRIVIA.each do |question_hash|
    question_hash["incorrect_answers"].each do |ans|
      Choice.create(name: ans, correct: false, question: (Question.all.find {|quest| quest.question == question_hash["question"]}))
    end
  end
end
