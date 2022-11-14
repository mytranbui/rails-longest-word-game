class GamesController < ApplicationController
  def new
    @letters = 10.times.map do
      ('A'...'Z').to_a.sample
    end
  end
  
  def score
    raise
  end
end
