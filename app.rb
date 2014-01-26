#!/usr/bin/env ruby

require_relative 'game'

class BaseballApp
  attr_reader :game

  def initialize
    @game = Game.new(1234)
  end

  def run
    while !solved
      guess = prompt_player
      if self.solved = game.guess(guess)
        congratulate_player
      else
        give_player_hints(guess)
      end
    end
  end

  private

  attr_accessor :solved

  def congratulate_player
    puts("Congrats!  You solved the game in #{game.number_of_guesses} turn(s).")
  end

  def give_player_hints(guess)
    puts(game.hints(guess))
  end

  def prompt_player
    puts('Guess a 4 digit number: ')
    guess = gets
    guess.chomp.to_i
  end
end

app = BaseballApp.new
app.run
