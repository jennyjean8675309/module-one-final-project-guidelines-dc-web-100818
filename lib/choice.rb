require 'pry'

class Choice < ActiveRecord::Base
  belongs_to :question
  delegate :category, :to => :question

  def self.fix_question_format
    self.all.each do |c|
      c.name.gsub!('&quot;', '"')
      c.name.gsub!("&aacute;", "á")
      c.name.gsub!("&ntilde;", "ñ")
      c.name.gsub!("&#039;", "'")
      c.name.gsub!("&uuml;", "ü")
      c.name.gsub!("&oacute;", "ó")
      c.name.gsub!("&ouml;", "ö")
      c.name.gsub!("&Ouml;", "Ö")
      c.name.gsub!("&eacute;", "é")
      c.name.gsub!("&shy;", "")
      c.name.gsub!("&amp;", "&")
      c.name.gsub!("&deg;", "°")
      c.save
    end
  end


end
