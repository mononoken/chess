# frozen_string_literal: true

# Monkeypatch String to allow for specifying RGB color of string print.
module ColorableString
  RGB_COLOR_MAP = {
    black: '0;0;0',
    white: '255;255;255',
    light: '255;207;159',
    dark: '210,140,69'
  }.freeze

  refine String do
    def fg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[38;2;#{rgb_val}m#{self}\e[0m"
    end

    def bg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[48;2;#{rgb_val}m#{self}\e[0m"
    end
  end
end
