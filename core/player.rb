class Player
  def initialize(window)
    @image = Gosu::Image.new(window, "media/nils.png",false)
    
    @beep1 = Gosu::Sample.new(window, "media/lemon_1.mp3")
    @beep2 = Gosu::Sample.new(window, "media/lemon_2.mp3")
    @beep3 = Gosu::Sample.new(window, "media/lemon_3.mp3")
    @beep4 = Gosu::Sample.new(window, "media/lemon_4.mp3")
    @beep5 = Gosu::Sample.new(window, "media/lemon_5.mp3")

    @beeps = [@beep1, @beep2, @beep3, @beep4, @beep5]

    @mud = Gosu::Sample.new(window, "media/mud_1.mp3")
    @mud2 = Gosu::Sample.new(window, "media/mud_2.mp3")
    @muds = [@mud, @mud2]

    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @timer = Time.now + 10
    @count_down = 0

    @speed = 0.35
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
    @vel_x -= Gosu::offset_x(@angle, @speed > 0.2 ?  @speed-0.2 : @speed )
    @vel_y -= Gosu::offset_y(@angle, @speed > 0.2 ?  @speed-0.2 : @speed )
  end

  def move
    @x += @vel_x if @x <= 640 && @x >= 1
    @y += @vel_y if @y <= 480 && @y >= 1

    @x -= 1 if @x >= 640
    @x += 1 if @x <= 1

    @y -= 1 if @y >= 480
    @y += 1 if @y <= 1

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
      if Gosu::distance(@x, @y, lemon.x, lemon.y) < (lemon.l_width-5) then 
        @speed += 0.05 if @speed < 0.65
        @timer += 1
        @score += 1
        @beeps[rand(@beeps.count)].play(rand(0.1) + 0.4)
        true
      else
        false
      end
    end
  end

  def sink_hole(holes)
    holes.reject! do |hole|
      if Gosu::distance(@x, @y, hole.x, hole.y) < (hole.h_width - 5) then
        @speed -= 0.15
        @speed = 0.16 unless @speed >= 0.2
        @muds[rand(@muds.count)].play(rand(0.1) + 0.4)
        true
      elsif (Time.now - hole.created_at) > 5
        true
      else
        false
      end
    end
  end
end