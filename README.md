Trivia Game CLI
  Description:
  - An interactive Trivia Game CLI that allows users to select questions by category and advance through the game if they answer enough questions correctly. The questions become harder as the game progresses. If a user does not answer the necessary number of questions correctly in the allotted question limit, the game will end.

  Features:
  - The Trivia Game selects a random question from a database of 150 questions, sorted by category and difficulty. Users enter the desired category they want to play by name and their answer choice as A, B, C, or D.

  Code:
  - This CLI uses Ruby with the following gems:
      - "sinatra-activerecord"
      - "sqlite3"
      - "pry"
      - "require_all"
      - "rest-client"
      - "rspec"

  Credits
  - Trivia API Database:
    https://opentdb.com/api_config.php
  - Jennifer Ingram
  - Michael Kim
