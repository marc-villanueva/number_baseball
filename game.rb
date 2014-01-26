class Game
  attr_reader :number_of_guesses

  def initialize(answer = nil)
    @answer = answer
    @number_of_guesses = 0
  end

  def guess(input)
    increment_guess_count
    correct_answer?(input)
  end

  def hints(input)
    GameHints.new(answer, input).to_s
  end

  def answer
    @answer ||= generate_answer
  end

  private

  def correct_answer?(guess)
    answer == guess
  end

  def increment_guess_count
    @number_of_guesses += 1
  end

  def generate_answer
    (0..9).to_a.shuffle.slice(0,4).join
  end
end

class GameHints
  attr_reader :answer, :guess

  def initialize(answer, guess)
    @answer = answer
    @guess = guess
  end

  def to_s
     "#{strikes} strike(s), #{balls} ball(s)"
  end

  def strikes
    answer_and_guess_pairs.count { |a, b| a == b }
  end

  def balls
    answer_and_guess_pairs.count do |a, b|
      a != b && answer_array.include?(b.to_s)
    end
  end

  private

  def answer_and_guess_pairs
    answer_array.zip(guess_array)
  end

  def answer_array
    answer.to_s.split('')
  end

  def guess_array
    guess.to_s.split('')
  end
end
