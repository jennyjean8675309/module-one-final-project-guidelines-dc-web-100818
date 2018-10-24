require_relative '../config/environment.rb'

User.destroy_all
Category.destroy_all
Question.destroy_all
Choice.destroy_all
UserQuestion.destroy_all

create_categories
create_questions
create_correct_choices
create_incorrect_choices
