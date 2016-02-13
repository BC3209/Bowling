require 'byebug'
require_relative './spec_helper'
require_relative '../lib/bowling'

describe Game do
  before do
    @game = Game.new
  end

  it 'should score all gutter balls as zero' do
    20.times { @game.roll(0) }
    expect(@game.score).to eq(0)
  end

  it 'should score all ones as 20' do
    20.times { @game.roll(1) }
    expect(@game.score).to eq(20)
  end

  it 'should be able to score a spare' do
    @game.roll(7)
    @game.roll(3) # => 10
    @game.roll(2) # => 14
    expect(@game.score).to eq(14)
  end

  it 'scores one gutter ball as zero' do
    @game.roll(0)
    expect(@game.score).to eq(0)
  end

  it 'scores the sum of two rolls' do
    @game.roll(3)
    @game.roll(5)
    expect(@game.score).to eq(8)
  end

  it 'should be able to score a strike' do
    @game.roll(10)
    @game.roll(2)
    @game.roll(4)
    expect(@game.score).to eq(22)
  end
end

describe Frame do
  before do
    @frame = Frame.new
  end

  context 'is finished when' do
    it 'has two rolls' do
      @frame.add_roll(3)
      @frame.add_roll(3)
      expect(@frame).to be_finished
    end
    it 'has a score of 10' do
      @frame.add_roll(10)
      expect(@frame).to be_finished
    end
  end
  context 'is not finished when' do
    it 'has one roll of less than 10' do
      @frame.add_roll(5)
      expect(@frame).to_not be_finished
    end
  end
  context 'has one roll of 10' do
    it 'is a strike' do
      @frame.add_roll(10)
      expect(@frame).to be_strike
    end
  end
  context 'has two rolls that equals 10' do
    it 'is a spare' do
      @frame.add_roll(3)
      @frame.add_roll(7)
      expect(@frame).to be_spare
    end
  end
end
































# describe Game do
#   it 'should be able to play a new game' do
#     game = Game.new
#   end
#   it 'should be able to roll' do
#     game = Game.new
#     game.roll(0)
#   end
#   it 'should score all gutter balls as zero' do
#     game = Game.new
#     20.times { game.roll(0) }
#     expect(game.score).to eq(0)
#   end
#   it 'should score all ones as 20' do
#     game = Game.new
#     20.times { game.roll(1) }
#     expect(game.score).to eq(20)
#   end
#   it 'should be able to roll a spare' do
#     game = Game.new
#     game.roll(7)
#     game.roll(3) # 10
#     game.roll(2) # 14
#     expect(game.score).to eq(14)
#   end
# end
