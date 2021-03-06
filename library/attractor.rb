# Attraction
# Daniel Shiffman <http:#www.shiffman.net>

# A class for a @draggable attractive body in our world



class Attractor 
  
  V3 = Java::toxi.geom
  include Processing::Proxy
  attr_accessor :loc
  
  def initialize(l, m, g) 
    @loc = V3.Vec3D.new(l.x, l.y, l.z)
    @mass = m
    @G = g
    #@drag = V3.Vec3D.new(0.0,0.0)
  end

  def go 
    render
    #drag
  end

  def calcGravForce(p) 
    dir = @loc.sub(p.loc)      # Calculate direction of force
    d = dir.magnitude                        # Distance between objects
    d = constrain(d,5.0,25.0)                 # Limiting the distance to eliminate "extreme" results for very close or very far objects
    dir.normalize()                           # Normalize vector (distance doesn't matter here, we just want this vector for direction)
    force = (@G * @mass * 1 / (d * d))        # Calculate gravitional force magnitude
    dir.scaleSelf(force)                           # @Get force vector --> magnitude * direction
    return dir
  end

  # Method to display
  def render() 
    ellipseMode(CENTER)
    stroke(0)
    fill(175,200)
    ellipse(@loc.x,@loc.y,@mass*2,@mass*2)
  end

end