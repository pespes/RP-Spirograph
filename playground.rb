$LOAD_PATH << 'library/'

require 'library/attractor.rb'
require 'library/particle.rb'


class Playground < Processing::App
  
  load_libraries 'opengl', 'toxiclibscore', 'peasycam'
  include_package "toxi.geom"
  import 'peasy'
  
  V3 = Java::toxi.geom
    
  def setup
    size 800, 600, OPENGL
    new_particle
    configure_camera
  end

  def draw
    background 0
    draw_particle
  end
  
  def new_particle
    @ac = V3.Vec3D.new(0.0, 0.0, 0.0)
    @ve = V3.Vec3D.new(0.0, 1.0, 0.0)
    @lo = V3.Vec3D.new(50, 50, 0.0)
    # Create new thing with some initial settings
    @p = Particle.new(@ac, @ve, @lo, 10)
    # Create an attractive body
    @a = Attractor.new(V3.Vec3D.new(width/2, height/2, 0.0), 3, 2)
  end
  
  def draw_particle
    @a.go
    # Calculate a force exerted by "attractor" on "thing"
    f = @a.calcGravForce(@p)
    # Apply that force to the thing
    @p.apply_force(f)
    # Update and render the positions of both objects
    @p.run
  end
  
  def configure_camera
    @cam = PeasyCam.new(self, 800)
    @cam.set_minimum_distance(-1000)
    @cam.set_maximum_distance(5000)
  end
  
  def mouse_pressed
    puts @p.points
    puts "===================================================================================================================================="
  end
end
  

Playground.new :title => "playground"