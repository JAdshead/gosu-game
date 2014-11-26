class Player
  def initialize(window)

    @image_w = 100
    @image_h = 150
    @image = Gosu::Image.load_tiles(window, "media/nils_sprite.png", @image_w, @image_h, true)
    @frame = 0

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
    @moving = false
    @player_width = 0.9
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

  def moving
    @moving = true
  end

  def not_moving
    @moving = false
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
    # @image.draw(@x, @y, 1, @angle)
    f = @frame % @image.size
    img = @image[f]
    img.draw_rot @x, @y, ZOrder::Player, @angle, 0.4, 0.5, @player_width, 0.8
  end

  def update
    @count_down = @timer - Time.now
    @frame += 1
    update_width
  end

  def update_width
    if !@moving && @player_width <= 1.0 || @player_width <= (1.0-@speed + 0.2) then
      @player_width += 0.01 
    end
    if @moving && @player_width >= (1-@speed) &&  @player_width >= 0.5 then
      @player_width -= 0.01 
    end
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
        @speed = 0.35 if @speed <= 0.35 
        @speed += 0.05 if @speed < 1
        @timer += 2
        @score += 1
        @beeps[rand(@beeps.count)].play(rand(0.1) + 0.7)
        true
      else
        false
      end
    end
  end

  def sink_hole(holes)
    holes.reject! do |hole|
      if Gosu::distance(@x, @y, hole.x, hole.y) < (hole.h_width - 7) && (Time.now - hole.created_at) <= 1
        true
      elsif Gosu::distance(@x, @y, hole.x, hole.y) < (hole.h_width - 7)
        @speed -= 0.05
        @speed = 0.4 if @speed >= 0.6
        @speed = 0.05 unless @speed >= 0.5
        @muds[rand(@muds.count)].play(rand(0.1) + 0.8)
        true
      elsif (Time.now - hole.created_at) > 30
        true
      else
        false
      end
    end
  end
end