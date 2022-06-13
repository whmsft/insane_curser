import "dome" for Window
import "random" for Random
import "input" for Keyboard, Mouse
import "graphics" for Canvas, Color, Font

var VERSION = "4" // changes with each commit

class Triangle {
  x {_x}
  y {_y}
  speed {_speed}
  random {_rand}
  construct new(sy) {
    _rand = Random.new()
    _y = sy
    _x = 0
    _speed = random.float(15.0, 25.0)
  }
  draw() {
    Canvas.trianglefill(x+50, y, x, y-20, x, y+20, Color.darkgray)
    _x = x+speed
  }
}

class main {
  construct new() {}
  init() {
    _shapes = []
    _rand = Random.new()
    _wait = _rand.float(0.25, 0.5)
    _tick = 0
    Mouse.hidden = true
    Canvas.resize(960, 544)
    Window.title = "insane CURSEr c"+VERSION
    Window.resize(Canvas.width, Canvas.height)
  }
  update() {
    _tick = _tick+1
    if (_tick >= 60 * _wait) {
      _shapes.add(Triangle.new(_rand.int(544)))
      //_shapes.add(Triangle.new(_rand.int(544)))
      _tick = 0
      _wait = _rand.float(0.25, 0.5)
    }
  }
  draw(alpha) {
    Canvas.cls()
    Canvas.circlefill(Mouse.x, Mouse.y, 5, Color.white)
    _shapes.each { |shape| 
      shape.draw()
    }
  }
}
var Game = main.new()
