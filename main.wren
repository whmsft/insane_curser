import "dome" for Window
import "random" for Random
import "input" for Keyboard, Mouse
import "graphics" for Canvas, Color, Font

var VERSION = "9" // changes with each commit
var MODE = "not-playing" // either playing or not-playing

class Triangle {
  x {_x}
  y {_y}
  speed {_speed}
  random {_rand}
  construct new(sy) {
    _rand = Random.new()
    _y = sy
    _x = 0
    _speed = random.float(10.0, 25.0)
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
    Font.load("OpenSans", "./OpenSans.ttf", 25)
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
    if ((MODE == "not-playing") && (Keyboard.isKeyDown("return"))) {
      MODE = "playing"
    }
  }
  draw(alpha) {
    if (MODE == "playing") {
      Canvas.cls()
      Canvas.circlefill(Mouse.x, Mouse.y, 5, Color.white)
      _shapes.each { |shape| 
        shape.draw()
      }
      if (Canvas.pget(Mouse.x, Mouse.y) == Color.darkgray) {
        MODE = "not-playing"
      }
    } else {
      Canvas.cls()
      Font["OpenSans"].print("Hit <RETURN> to start the chaos", 10, 300, Color.white)
    }
  }
}
var Game = main.new()
