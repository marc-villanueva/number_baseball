require 'minitest/autorun'
require_relative 'game'

class GameTest < MiniTest::Unit::TestCase

  def test_guess_count_at_start_of_game
    game = Game.new
    assert_equal 0, game.number_of_guesses
  end

  def test_guess_count_one_guess
    game = Game.new
    game.guess(1234)
    assert_equal 1, game.number_of_guesses
  end

  def test_guess_count_multiple_guesses
    game = Game.new
    game.guess(1234)
    game.guess(1234)
    game.guess(1234)
    assert_equal 3, game.number_of_guesses
  end

  def test_guess_returns_false_for_incorrect_answer
    game = Game.new(1234)
    assert_equal false, game.guess(2341)
  end

  def test_guess_returns_true_for_correct_answer
    game = Game.new(1234)
    assert_equal true, game.guess(1234)
  end

  def test_hints_all_balls
    game = Game.new(1234)
    assert_equal '0 strike(s), 4 ball(s)', game.hints(4321)
  end

  def test_hints_all_strikes
    game = Game.new(1234)
    assert_equal '4 strike(s), 0 ball(s)', game.hints(1234)
  end

  def test_hints_combo
    game = Game.new(1234)
    assert_equal '1 strike(s), 1 ball(s)', game.hints(1367)
  end
end

class GameHintsTest < MiniTest::Unit::TestCase

  def test_zero_strikes
    hints = GameHints.new(1234, 4321)
    assert_equal 0, hints.strikes
  end

  def test_one_strike
    hints = GameHints.new(1234, 1326)
    assert_equal 1, hints.strikes
  end

  def test_all_strikes
    hints = GameHints.new(9012, 9012)
    assert_equal 4, hints.strikes
  end

  def test_zero_balls
    hints = GameHints.new(1234, 5678)
    assert_equal 0, hints.balls
  end

  def test_one_ball
    hints = GameHints.new(1234, 4567)
    assert_equal 1, hints.balls
  end

  def test_all_balls
    hints = GameHints.new(1234, 4321)
    assert_equal 4, hints.balls
  end

  def test_to_s_all_balls
    hints = GameHints.new(1234, 4321)
    assert_equal '0 strike(s), 4 ball(s)', hints.to_s
  end

  def test_to_s_all_strikes
    hints = GameHints.new(1234, 12345)
    assert_equal '4 strike(s), 0 ball(s)', hints.to_s
  end

  def test_to_s_combo
    hints = GameHints.new(1234, 1367)
    assert_equal '1 strike(s), 1 ball(s)', hints.to_s
  end
end
