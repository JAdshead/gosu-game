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