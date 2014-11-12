require 'gosu'

module ZOrder
  Background, Lemon, Player, Hole, UI = *0..4
end

require_relative "core/game_window"
require_relative "core/player"
require_relative "core/lemon"
require_relative "core/hole"
require_relative "core/world"
require_relative "core/menu"

GameWindow.new.show



