import "dome" for Window
import "random" for Random
import "input" for Keyboard, Mouse
import "graphics" for Canvas, Color, Font

var VERSION = "4" // changes with each commit

class Triangle {
  random {_rand}
  x {_x}
  y {_y}
  speed {_speed}
  construct new() {
    _rand = Random.new()
    _y = random.int(544)
    _x = 0
    _speed = random.float(0.1, 1.5)
  }
  update() {}
  draw() {
    Canvas.trianglefill(x+speed, y, x+speed, y-10, x+speed, y+10, Color.darkgrey)
  }
}

class main {
  construct new() {}
  init() {
    _shapes = []
    _rand = Random.new()
    _wait = _rand.float(0.25, 1.25)
    _tick = 0
    Mouse.hidden = true
    Canvas.resize(960, 544)
    Window.title = "insane CURSEr c"+VERSION
    Window.resize(Canvas.width, Canvas.height)
  }
  update() {
    _tick = _tick+1
    if (_tick >= 60 * _wait) {
      _shapes.add(Triangle.new())
      _tick = 0
      _wait = _rand.float(0.5, 1.5)
    }
    _shapes.each { |shape| 
      shape.update()
    }
  draw() {
    Canvas.cls()
    Canvas.circlefill(Mouse.x, Mouse.y, 5, Color.white)
    _shapes.each { |shape| 
      shape.draw()
      }
    }
  }
}
var Game = main.new()
