class World

  def initialize window
    @window = window
    @background_image = Gosu::Image.new(@window, "media/floor.jpg")

    @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)

    @player = Player.new(@window)
    @player.warp(320,160)

    @lemon_anim = Gosu::Image::load_tiles(@window, "media/lemon.png", 60,60,false)
    @lemons = Array.new

  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background);
    @player.draw
    @lemons.each {|lemon| lemon.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
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
    @player.move
    @player.collect_lemons(@lemons)

    if rand(100) < 4 and @lemons.size < 10 then
      @lemons.push(Lemon.new(@lemon_anim))
    end
  end


end

