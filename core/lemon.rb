class Lemon 
  attr_reader :x, :y, :l_width

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(256 - 100) + 100
    @color.green = rand(256 - 200) + 200
    @color.blue = rand(256 - 200) + 200
    @x = rand * 640
    @y = rand * 480
    @size = rand(0.6..0.7).round(2)
    @l_width = 100
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    @l_width = img.width * @size
    img.draw(@x - (img.width * @size) / 2.0, @y - (img.height*@size) / 2.0, ZOrder::Lemon, @size, @size, @color)
  end

end