# Particles + Forces
# Daniel Shiffman <http:#www.shiffman.net>

# A simple Particle class
# Incorporates forces code

class Particle 
  
  V3 = Java::toxi.geom
  include Processing::Proxy
  attr_accessor :loc, :vel, :acc, :points
  
  
  # Another constructor (the one we are using here)
  def initialize(ac,ve,lo,r) 
    @acc = V3.Vec3D.new(ac.x, ac.y, ac.z)
    @vel = V3.Vec3D.new(ve.x, ve.y, ve.z)
    @loc = V3.Vec3D.new(lo.x, lo.y, lo.z)
    @r = 10
    @timer = 100.0
    @maxspeed = 2
    @points = []
  end

  def run
    update
    render
  end

  # Method to update @location
  def update
    @vel.addSelf(@acc)
    @vel.limit(@maxspeed)
    @loc.addSelf(@vel)
    @acc.scaleSelf(0.0)
    @timer -= 0.5
    @points.push([@loc.x, @loc.y, @loc.z])
  end
  
  def apply_force(force) 
    mass = 1 # We aren't bothering with mass here
    #force.div(mass)
    @acc.addSelf(force)
  end

  # Method to display
  def render 
    ellipse_mode(CENTER)
    stroke(255)
    fill(100)
    ellipse(@loc.x,@loc.y,@r,@r)
    @points.each do |pt|
      point(pt[0], pt[1], 0)
    end
  end
  
  # Is the particle still useful?
  def dead? 
    if (timer <= 0.0) 
      return true
    else 
      return false
    end
  end
end