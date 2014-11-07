require 'gosu'

module ZOrder
  Background, Lemon, Player, UI = *0..3
end

require_relative "core/game_window"
require_relative "core/player"
require_relative "core/lemon"
require_relative "core/world"
require_relative "core/menu"

GameWindow.new.show



