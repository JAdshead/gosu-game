require 'gosu'


class GameWindow < Gosu::Window

  def initialize
    super 640, 480, false
    self.caption = "Game on Jonny"
  end


  def button_down id 
    close if id == Gosu::KbEscape
  end


  def update

  end

  def draw
  end

end


GameWindow.new.show