class World

  def initialize window
    @window = window
    @background_image = Gosu::Image.new(@window, "media/floor.jpg")

    @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)

    @player = Player.new(@window)
    @player.warp(320,160)

    @lemon_anim = Gosu::Image::load_tiles(@window, "media/lemon.png", 60,60,false)
    @hole_anim = Gosu::Image::load_tiles(@window, "media/black_hole.png", 80,80,false)

    @holes = Array.new
    @lemons = Array.new
  end

  def in_play?
    true if @player.time_left > 0
  end

  def current_score
    @player.score
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background);
    @player.draw
    @lemons.each {|lemon| lemon.draw }
    @holes.each {|hole| hole.draw }

    @font.draw("Score: #{@player.score}  Time Left: #{@player.time_left}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down id 
    close if id == Gosu::KbEscape
  end

  def update

    if @window.button_down? Gosu::KbLeft or @window.button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if @window.button_down? Gosu::KbRight or @window.button_down? Gosu::GpRight then
      @player.turn_right
    end
    if @window.button_down? Gosu::KbUp or @window.button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    if @window.button_down? Gosu::KbDown or @window.button_down? Gosu::GpButton1 then
      @player.decelerate
    end
    @player.move
    @player.collect_lemons(@lemons)
    @player.sink_hole(@holes)

    @player.update

    if rand(100) < 5 and @lemons.size < 2 then
      @lemons.push(Lemon.new(@lemon_anim))
    end

    if rand(200) < current_score and @holes.size < 2  then
      @holes.push(Hole.new(@hole_anim))
    end

  end


end

