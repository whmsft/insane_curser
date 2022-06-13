import "dome" for Window
import "random" for Random
import "input" for Keyboard, Mouse
import "graphics" for Canvas, Color, Font

var VERSION = "3"

class triangle {
  construct new() {}
  update() {}
  draw() {}
}

class game {
  construct new() {}
  init() {
    Mouse.hidden = true
    Canvas.resize(960, 544)
    Window.title = "insane CURSEr c"+VERSION
    Window.resize(Canvas.width, Canvas.height)
  }
  update() {}
  draw(alpha) {
    Canvas.cls()
    Canvas.circlefill(Mouse.x, Mouse.y, 5, Color.white)
  }
}

var Game = game.new()
