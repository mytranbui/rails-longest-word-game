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
      @result = "<strong>Congratulations!</strong> <%= #{@word.upcase} %> is a valid English word!"
    elsif !@hash_dico['found']
      @result = "Sorry but <strong><%= #{@word.upcase} %></strong> does not seem to be a valid English word..."
    else
      @result = "Sorry but <strong><%= #{@word.upcase} %></strong> can't be built out of <%= #{@letters} %>"
    end
  end

  private

  def word_fit_in_array(string, array)
    string_arr = string.chars.map
    arr = array.map
    string_arr.each do |let|
      if arr.include?(let)
        arr.delete_at(arr.index(let))
      else
        return false
      end
    end
    true
  end
end
