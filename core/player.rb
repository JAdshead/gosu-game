class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "media/nils.png",false)
    
    @beep1 = Gosu::Sample.new(window, "media/lemon_1.mp3")
    @beep2 = Gosu::Sample.new(window, "media/lemon_2.mp3")
    @beep3 = Gosu::Sample.new(window, "media/lemon_3.mp3")
    @beep4 = Gosu::Sample.new(window, "media/lemon_4.mp3")
    @beep5 = Gosu::Sample.new(window, "media/lemon_5.mp3")

    @beeps = [@beep1, @beep2, @beep3, @beep4, @beep5]

    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @timer = Time.now + 10
    @count_down = 0

    @speed = 0.5
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
    @vel_x += Gosu::offset_x(@angle, @speed)
    @vel_y += Gosu::offset_y(@angle, @speed)
  end

  def decelerate
    @vel_x -= Gosu::offset_x(@angle, @speed-0.2)
    @vel_y -= Gosu::offset_y(@angle, @speed-0.2)
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

  def update
    @count_down = @timer - Time.now
  end

  def time_left
    @count_down.round
  end

  def score
    @score
  end

  def collect_lemons(lemons)
    lemons.reject! do |lemon|
      if Gosu::distance(@x, @y, lemon.x, lemon.y) < 50 then
        @timer += 1
        @score += 1
        @beeps[rand(@beeps.count)].play(0.5)
        true
      else
        false
      end
    end
  end

  def sink_hole(holes)
    holes.reject! do |hole|
      if Gosu::distance(@x, @y, hole.x, hole.y) < 20 then
        @speed -= 0.1
        true
      elsif (Time.now - hole.created_at) > 5
        true
      else
        false
      end
    end
  end

end