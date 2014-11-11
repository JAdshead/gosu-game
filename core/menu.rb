class Menu

  def initialize window
    @window = window
    @display = true

    @background = Gosu::Image.new(@window, "media/brick.jpg", true)
    @play_button = Gosu::Image.new(@window, "media/play_button.png",true)
    @exit_button = Gosu::Image.new(@window, "media/exit_button.png", true)

    @play_pos = {x: (@window.width/2 - (@play_button.width / 2) ), y: 150}
    @exit_pos = {x: (@window.width/2 - (@exit_button.width / 2)), y: 250}

    @cursor = Gosu::Image.new(@window, "media/cursor.png")
    @font = Gosu::Font.new(@window, Gosu::default_font_name, 20)
  end


  attr_accessor :display

  def draw
    if @display === true
      @background.draw(0,0,0)
      @play_button.draw(@play_pos[:x],@play_pos[:y],1)
      @exit_button.draw(@exit_pos[:x],@exit_pos[:y],1)
      @cursor.draw(@window.mouse_x, @window.mouse_y, 2)
      @font.draw("Last Score: #{@window.find_score}     Top Score: #{@window.top_score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    end
  end


  # why is elsif not working ???
  def update
    if @play_pos[:x] < @window.mouse_x && @window.mouse_x < (@play_pos[:x] + @play_button.height ) && @play_pos[:y] < @window.mouse_y && @window.mouse_y < (@play_pos[:y] + @play_button.width ) && (@window.button_down? Gosu::MsLeft)
      new_game
    end

    if @exit_pos[:x] < @window.mouse_x && @window.mouse_x < (@exit_pos[:x] + @exit_button.height ) && @exit_pos[:y] < @window.mouse_y && @window.mouse_y < (@exit_pos[:y] + @exit_button.width ) && (@window.button_down? Gosu::MsLeft)
      exit
    end
  end

  def new_game
    @display = false
    @window.new_game
    @window.pause = false
  end

  def exit
    @window.close
  end 

end