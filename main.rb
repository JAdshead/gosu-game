require 'gosu'

module ZOrder
  Background, Lemon, Player, UI = *0..3
end

class GameWindow < Gosu::Window

  def initialize
    @window_width = 640
    @window_height = 480
    super @window_width, @window_height, false

    self.caption = "Nils the Ultimate"

    @background_image = Gosu::Image.new(self, "media/floor.jpg", true)

    @player = Player.new(self)
    @player.warp(320,160)

    @lemon_anim = Gosu::Image::load_tiles(self, "media/lemon.png", 60,60,false)
    @lemons = Array.new

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def button_down id 
    close if id == Gosu::KbEscape
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move
    @player.collect_lemons(@lemons)

    if rand(100) < 4 and @lemons.size < 10 then
      @lemons.push(Lemon.new(@lemon_anim))
    end

  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background);
    @player.draw
    @lemons.each {|lemon| lemon.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

end


class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "media/nils.png",false)
    @beep = Gosu::Sample.new(window, "media/beep_1.mp3")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x,y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.9
    @vel_y *= 0.9
  end

  def draw 
    @image.draw_rot(@x, @y, 1, @angle)
  end


  def score
    @score
  end

  def collect_lemons(lemons)
    lemons.reject! do |lemon|
      if Gosu::distance(@x, @y, lemon.x, lemon.y) < 50 then
        @score += 1
        @beep.play(0.5)
        true
      else
        false
      end
    end
  end

end


class Lemon 
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @x = rand * 640
    @y = rand * 480
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, ZOrder::Lemon, 1, 1, @color, :add)
  end

end

GameWindow.new.show



