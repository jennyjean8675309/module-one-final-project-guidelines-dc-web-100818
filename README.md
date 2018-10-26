Ultimate Trivia Challenge!
  Description:
  - An interactive Trivia Game CLI that allows users to select questions by category and advance through the game if they answer enough questions correctly. The questions become harder as the game progresses. If a user does not answer the necessary number of questions correctly in the allotted question limit, the game will end.

  Features:
  - The Trivia Game selects a random question from a database of 150 questions, sorted by category and difficulty. Users select the desired category they want to play and enter their answer choice as A, B, C, or D (lowercase letters works as well).

  


  Code:
  - This CLI uses Ruby with the following gems:
      - "sinatra-activerecord"
      - "sqlite3"
      - "pry"
      - "require_all"
      - "rest-client"
      - "rspec"
      - "tty-font"
      - "tty-prompt"
      - "paint"
      - "colorize"

  Contributing:
  - If you'd like to contribute to Ultimate Trivia Challenge!, clone this repo and commit your code to a separate branch. To seed your database for the game, you will need to run the 'db/migrate/seeds.rb' file to create questions.

  Credits:
  - Trivia API Database:
      https://opentdb.com/api_config.php
  - Flatiron School
  - Jennifer Ingram
  - Michael Kim
