class Hole 
  attr_reader :x, :y, :created_at

  def initialize(animation)
    @animation = animation
    @x = rand * 640
    @y = rand * 480
    @size = 1
    @created_at = Time.now
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, ZOrder::Hole, @size, @size)
  end

end