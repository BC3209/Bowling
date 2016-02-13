# GAME CLASS
class Game
  attr_accessor :frames

  def initialize
    @frames = []
    @frames.push(Frame.new)
  end

  def current_frame
     frames.last
  end

  def roll(pins)
    current_frame.add_roll(pins)
    if current_frame.finished?
      frames.push(Frame.new) unless frames.length == 10
    end
  end

  def score
    score = 0
    frames_copy = Array.new(frames)
    begin
      frame = frames_copy.shift
      score += frame.pin_total
      if frame.spare?
        score += frames_copy.first.rolls.first
      elsif frame.strike?
        next_two_frames = frames_copy.first(2)
        first_frame_rolls = next_two_frames.first.rolls
        second_frame_rolls = next_two_frames.last.rolls
        both_frames_rolls = first_frame_rolls.concat(second_frame_rolls)
        next_two_rolls = both_frames_rolls.first(2)
        score += next_two_rolls.reduce(:+)
      end
    end until frames_copy.empty?
    score
  end
end


class Frame
  attr_accessor :rolls

  def initialize
    @rolls = []
  end

  def add_roll(pins)
    rolls << pins
  end

  def finished?
    rolls.size == 2 || rolls.first == 10
  end

  def strike?
    rolls.size == 1 && rolls.first == 10
  end

  def spare?
    rolls.size == 2 && pin_total == 10
  end

  def pin_total
    rolls.reduce(:+) || 0
  end
end
