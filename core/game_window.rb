class GameWindow < Gosu::Window

  def initialize
    @window_width = 640
    @window_height = 480
    super @window_width, @window_height, false

    self.caption = "Nils the Ultimate"
   
    @menu = Menu.new self
    @world = World.new self
    @pause = true
    
  end

  attr_accessor :pause

  def button_down(key)
    case key
    when Gosu::KbEscape
      close
    when Gosu::KbP
      @pause = !@pause if @menu.display === false
      @menu.display = true if @menu.display === false
    when Gosu::KbBackspace
      @sound = !@sound if @menu.display === false
    end
  end

  def draw
    @menu.draw
    @world.draw if @menu.display === false
  end

  def update
    @menu.update if pause
    @world.update if not pause
  end


end