import "audio" for AudioEngine
import "dome" for Window
import "graphics" for Canvas, Color, Font, ImageData
import "input" for Keyboard, Mouse
import "random" for Random

var HI = "0"
var VERSION = "30" // changes with each commit
var MODE = "not-playing" // either "playing" or "not-playing"

class Wall {
  FINISH {_fin}
  speed {_speed}
  random {_rand}
  construct new() {
    _rand = Random.new()
    _y = -100
    _x = 960
    _speed = random.float(5.0, 15.0)
    _ychanger = 80
  }
  draw() {
    if (_x <= 0) _fin = true
    _ychanger = _ychanger - 1
    if (_ychanger >= 60) {
      _y = _y - 5
    } else if (_ychanger >= 20) {
      _y = _y + 5
    } else if (_ychanger >= 0) {
      _y = _y - 5
    } else {
      _ychanger = 80
    }
    Canvas.rectfill(_x, _y-50, 30, 500, Color.hex("444"))
    Canvas.rectfill(_x, _y+550, 30, 500, Color.hex("444"))
    _x = _x - 10
  }
}

class Nuke {
  FINISH {_fin}
  x {_x}
  y {_y}
  speed {_speed}
  random {_rand}
  rot {_r}
  rep {_rep}
  dor {_dor}
  construct new(startx) {
    _rand = Random.new()
    _dor = random.int(1, 5)
    _y = 0
    _x = startx
    _speed = random.float(5.0, 15.0)
    _rot = 0
    _rep = 20
  }
  draw() {
    if (y > 544) _fin = true
    _rep = rep - 1
    if (rep >= 15) {
      _rot = _rot - dor
    } else if (rep >= 5) {
      _rot = _rot + dor
    } else if (rep >= 0) {
      _rot = _rot - dor
    } else {
      _rep = 20
    }
    
    _x = x + _rot
    Canvas.rectfill(x, y, 15, 40, Color.hex("444"))
    Canvas.rectfill(x-15/2, y+5, 30, 10, Color.hex("444"))
    //Canvas.trianglefill(x+50, y, x, y-20, x, y+20, Color.hex("444"))
    _y = y+speed
  }
}

class Triangle {
  x {_x}
  y {_y}
  FINISH {_fin}
  speed {_speed}
  random {_rand}
  construct new(sy) {
    _rand = Random.new()
    _y = sy
    _x = 0
    _speed = random.float(10.0, 25.0)
  }
  draw() {
    if (x > 960) _fin = true
    Canvas.trianglefill(x+50, y, x, y-20, x, y+20, Color.hex("444"))
    _x = x+speed
  }
}

class main {
  cutfloat(flt) {
    _sflt = flt.toString
    _dotindex = _sflt.indexOf(".")
    _fract = flt.fraction.toString
    if (_fract == "0") return _sflt + ".00"
    if (_fract.count >= 2) return _sflt[0.._dotindex] + _fract[2..2]
  }
  construct new() {}
  init() {
	_audioset = 0
	_channel = ""
    _uptime = 0
    _shapes = []
    _rand = Random.new()
    _wait = _rand.float(0.25, 0.5)
    _tick = 0
	_intro = ImageData.loadFromFile("./intro.png")
	AudioEngine.load("menu", "menumusic.wav")
	AudioEngine.load("game", "gamemusic.wav")
    Font.load("OpenSans", "./OpenSans.ttf", 25)
    Mouse.hidden = true
    Canvas.resize(960, 544)
    Window.title = "insane CURSEr c"+VERSION
    Window.resize(Canvas.width, Canvas.height)
  }
  update() {
	if ((MODE == "not-playing") && (_audioset == 0)) {
	  _channel = AudioEngine.play("menu", 100, true)
	  _audioset = 1
	}
    if (MODE == "playing") {
	  if (_audioset==0) {
		_channel = AudioEngine.play("game", 100, true)
		_audioset = 1
	  }
      _tick = _tick+1
      if (_tick >= 60 * _wait) {
        if (_rand.int(2) == 0) {
          _shapes.add(Triangle.new(_rand.int(544)))
        } else if (_rand.int(2) == 0) {
          _shapes.add(Nuke.new(_rand.int(960)))
        } else if (_rand.int(2) == 0){
          _shapes.add(Wall.new())
        }
        _tick = 0
        _wait = _rand.float(0.25, 0.5)
      }
    }
    _shapes.each { |shape|
        if (shape.FINISH == true) {
          _shapes.removeAt(_shapes_iterator)
        }
        _shapes_iterator = _shapes_iterator + 1
    }
    _shapes_iterator = 0
    if ((MODE == "not-playing") && (Keyboard.isKeyDown("return"))) {
      MODE = "playing"
	  _channel.stop()
	  _audioset = 0
    }
  }
  draw(alpha) {
    if (MODE == "playing") {
      _uptime = _uptime+1/30
      Canvas.cls()
      Font["OpenSans"].print("survived "+cutfloat(_uptime).toString+" secs", 10, 10, Color.white)
      Canvas.circlefill(Mouse.x, Mouse.y, 5, Color.white)
      _shapes.each { |shape| 
        shape.draw()
      }
      if (Canvas.pget(Mouse.x, Mouse.y) == Color.hex("444")) {
        _shapes = []
        if (_uptime > Num.fromString(HI)) HI = cutfloat(_uptime).toString
        _uptime = 0
        MODE = "not-playing"
		_channel.stop()
		_audioset = 0
      }
    } else {
      Canvas.cls()
	  _intro.draw(0,0)
      Canvas.circlefill(Mouse.x, Mouse.y, 5, Color.white)
      Font["OpenSans"].print("Hit <RETURN> to start the chaos\nHIGHSCORE: "+HI, 10, 10, Color.white)
    }
  }
}
var Game = main.new()
