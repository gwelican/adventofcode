#!/usr/bin/ruby


class Position 

  @@directions = ["N","E","S","W"]
  attr_accessor :posx, :posy, :firstvisited

  def initialize(facing, posx, posy)
    @facing = facing
    @posx = posx
    @posy = posy
    @visited = []
    @firstvisited = nil
  end

  def step()
    if @facing == "W" then
      @posx -= 1
    elsif @facing == "E" then
      @posx += 1
    elsif @facing == "N" then
      @posy -= 1
    elsif @facing == "S" then
      @posy += 1
    end
    
    coordstr = "#{@posx}:#{@posy}"

    if @visited.index(coordstr) and @firstvisited == nil then
      @firstvisited = @posx.abs+@posy.abs
    end

    @visited << coordstr
  end

  def move(direction, distance)
    newdir = @@directions.index(@facing)
    if direction == "R" then
      newdir = (newdir + 1) % 4;
    else 
      newdir = (newdir + 3) % 4;
    end

    @facing = @@directions[newdir]

    for i in 1..distance.to_i
      step()
    end
    
  end

  def to_s
    "X: #{@posx} Y: #{@posy} Facing: #{@facing}"
  end

    
end

p = Position.new("N", 0, 0)

File.read('day1.input').split(", ").each do |e|
  m = e.strip.match(/([R,L])(.*)/)
  dir = m[1]
  distance = m[2]
  p.move(dir, distance)
end

puts "* result: #{p.posx.abs+p.posy.abs}"
puts "** Result: #{p.firstvisited}"


