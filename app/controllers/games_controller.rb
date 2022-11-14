require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map do
      ('A'...'Z').to_a.sample
    end
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    @hash_dico = JSON.parse(serialized)
    if @hash_dico['found'] && word_fit_in_array(@word, @letters)
      @result = "Congratulations! #{@word.upcase} is a valid English word!"
    elsif @hash_dico['found']
      @result = "Sorry but #{@word.upcase} can't be built out of #{@letters.split.join(', ')}"
    else
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    end
  end

  private

  def word_fit_in_array(string, array)
    string_arr = string.chars
    string_arr.each do |let|
      if array.include?(let)
        array.delete_at(array.index(let))
      else
        return false
      end
    end
    true
  end
end
