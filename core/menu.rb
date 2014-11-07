class Menu

  def initialize window
    @window, @display = window, true

    @background = Gosu::Image.new(@window, "media/brick.jpg", true)
    @play_button = Gosu::Image.new(@window, "media/play_button.png",true)
    @exit_button = Gosu::Image.new(@window, "media/exit_button.png", true)

    @play_pos = {x: (@window.width/2 - (@play_button.width / 2) ), y: 150}
    @exit_pos = {x: (@window.width/2 - (@exit_button.width / 2)), y: 250}

    @cursor = Gosu::Image.new(@window, "media/cursor.png")
  end


  attr_accessor :display

  def draw
    if @display === true
      @background.draw(0,0,0)
      @play_button.draw(@play_pos[:x],@play_pos[:y],1)
      @exit_button.draw(@exit_pos[:x],@exit_pos[:y],1)
      @cursor.draw(@window.mouse_x, @window.mouse_y, 2)
    end
  end


  def update
    if @play_pos[:x] < @window.mouse_x && @window.mouse_x < (@play_pos[:x] + @play_button.height ) && @play_pos[:y] < @window.mouse_y && @window.mouse_y < (@play_pos[:y] + @play_button.width )  && (@window.button_down? Gosu::MsLeft)
      new_game
    elsif @exit_pos[:x] < @window.mouse_x && @window.mouse_x < (@exit_pos[:x] + @exit_button.height ) && @exit_pos[:y] < @window.mouse_y && @window.mouse_y < (@exit_pos[:y] + @exit_button.width ) && (@window.button_down? Gosu::MsLeft)
      exit
    end
  end

  def new_game
    @display = false
    @window.pause = false
  end


  def exit
    @window.close
  end

end