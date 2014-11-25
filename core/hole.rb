class Hole 
  attr_reader :x, :y, :created_at, :h_width

  def initialize(animation)
    @animation = animation
    @x = rand * 640
    @y = rand * 480
    @size = rand(0.6..1.0).round(2)
    @created_at = Time.now
    @h_width = 50
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    @h_width = img.width * @size
    img.draw(@x - (img.width * @size) / 2.0, @y - (img.height*@size) / 2.0, ZOrder::Hole, @size, @size)
  end

end