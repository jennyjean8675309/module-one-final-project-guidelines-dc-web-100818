require 'rest_client'
require 'JSON'
require 'pry'

def get_trivia_hash
  general_knowledge_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=9&type=multiple')
  general_knowledge_parsed = JSON.parse(general_knowledge_q)

  enter_film_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=11&type=multiple')
  enter_film_parsed = JSON.parse(enter_film_q)

  art_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=25&type=multiple')
  art_q_parsed = JSON.parse(art_q)

  sc_and_na_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=17&type=multiple')
  sc_and_na_q_parsed = JSON.parse(sc_and_na_q)

  geography_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=22&type=multiple')
  geography_q_parsed = JSON.parse(geography_q)

  enter_books_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=10&type=multiple')
  enter_books_q_parsed = JSON.parse(enter_books_q)

  history_q = RestClient.get('https://opentdb.com/api.php?amount=25&category=23&type=multiple')
  history_q_parsed = JSON.parse(history_q)

  all_APIs = [general_knowledge_parsed, enter_film_parsed, art_q_parsed, sc_and_na_q_parsed, geography_q_parsed, enter_books_q_parsed, history_q_parsed]
  all_APIs.collect do |question_hash|
    question_hash["results"]
  end.flatten
end

get_trivia_hash

  binding.pry
0
