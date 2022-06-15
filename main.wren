import "dome" for Window
import "random" for Random
import "input" for Keyboard, Mouse
import "graphics" for Canvas, Color, Font

var VERSION = "10" // changes with each commit
var MODE = "not-playing" // either playing or not-playing

class Nuke {
  x {_x}
  y {_y}
  speed {_speed}
  random {_rand}
  rot {_r}
  rep {_rep}
  construct new(startx) {
    _rand = Random.new()
    _y = 0
    _x = startx
    _speed = random.float(5.0, 15.0)
    _rot = 0
    _rep = 20
  }
  draw() {
    _rep = rep -1
    if (rep >= 15) {
      _rot = _rot -1
    } else if (rep >= 5) {
      _rot = _rot +1
    } else if (rep >= 0) {
      _rot = _rot -1
    } else {
      _rep = 20
    }
    
    _x = x + _rot
    Canvas.rectfill(x, y, 15, 40, Color.darkgray)
    Canvas.rectfill(x-15/2, y+5, 30, 10, Color.darkgray)
    //Canvas.trianglefill(x+50, y, x, y-20, x, y+20, Color.darkgray)
    _y = y+speed
  }
}

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
      if (_rand.int(2) == 0) {
        _shapes.add(Triangle.new(_rand.int(544)))
      } else {
        _shapes.add(Nuke.new(_rand.int(960)))
      }
      _tick = 0
      _wait = _rand.float(0.25, 0.5)
    }
    if ((MODE == "not-playing") && (Keyboard.isKeyDown("return"))) {
      MODE = "playing"
      _uptime = 0
    }
  }
  draw(alpha) {
    if (MODE == "playing") {
      Canvas.cls()
      Font["OpenSans"].print(_uptime.toString, 10, 10, Color.white)
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
