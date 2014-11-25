class GameWindow < Gosu::Window

  def initialize
    @window_width = 640
    @window_height = 480
    super @window_width, @window_height, false
    @sound = true
    self.caption = "Nils the Ultimate"
   
    @menu = Menu.new self
    @world = World.new self
    @pause = true
    @top_score = 0

    @win_sound = Gosu::Sample.new(self, "media/win.wav")
    @lose_sound = Gosu::Sample.new(self, "media/fail.wav")

    @music = Gosu::Song.new(self, "media/aerobic_champion.mp3")
    @music.volume = 0.5

  end

  attr_accessor :pause, :top_score

  def new_game
    @world = World.new self
    # @music.play(looping = true)
  end


  def button_down(key)
    case key
    when Gosu::KbEscape
      @pause = !@pause if @menu.display === false
      @menu.display = true if @menu.display === false
    when Gosu::KbP
      @pause = !@pause if @menu.display === false
      @menu.display = true if @menu.display === false
    when Gosu::KbS
      puts "sound #{@sound}"
      @sound = !@sound if @menu.display === false
    end
  end

  def draw
    @menu.draw 
    @world.draw if @menu.display === false
  end

  def update
    if !pause
      end_game unless @world.in_play?

    end
    @menu.update if pause
    @music.play(looping = true) if !pause
    @music.pause if pause

    @world.update if not pause

    if @top_score <= find_score
      @top_score = find_score
    end
  end

  def find_score
    @world.current_score || 0
  end

  def end_game
    # @music.pause
    top_score <= find_score ? @win_sound.play(0.6) : @lose_sound.play(0.5)
    @pause = true
    @menu.display = true
  end

  def exit
    close
  end
end