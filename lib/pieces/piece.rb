# frozen_string_literal: true

require_relative './pieces'

# Store start positions with their matching color.
StartPosition = Struct.new(:position, :color, keyword_init: true)

module CoreExtensions
  module String
    # Allow strings to print in terminal with color
    # Idea from https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
    module StringColorer
      def colorize(color_code)
        "\e[#{color_code}m#{self}\e[0m"
      end

      def white
        colorize(37)
      end

      def black
        colorize(30)
      end

      def bg_white
        colorize(42)
      end

      def bg_black
        colorize(47)
      end
    end
  end
end

# Pieces for chess that store piece move behavior.
class Piece
  String.include CoreExtensions::String::StringColorer

  def self.start_positions
    []
  end

  attr_reader :color

  def initialize(color = nil)
    @color = color
  end

  def step_directions
    raise "#{self.class} must implement #step_directions."
  end

  def step_limit
    raise "#{self.class} must implement #step_limit."
  end

  def checkable?
    false
  end

  def opponent_color
    case color
    when :black
      :white
    when :white
      :black
    end
  end

  def bg_color
    # Set BG color of to_s per square color.
  end

  def skin
    raise "#{self.class} must implement #skin."
  end

  def to_s
    skin.send(color)
  end
end
