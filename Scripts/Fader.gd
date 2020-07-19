extends CanvasLayer

onready var fader = $Fader
var fading = false
var fading_in = false
var speed: float
var ref: FuncRef

func fade_in(s, r):
	speed = s
	ref = r
	fading = true
	fading_in = true

func fade_out(s, r):
	speed = s
	ref = r
	fading = true
	fading_in = false

func _process(delta):
	if fading:
		if fading_in:
			fader.color.a += delta * speed
		else:
			fader.color.a -= delta * speed
		if fader.color.a > 1 and fading_in:
			fader.color.a = 1
			fading = false
			ref.call_func()
		if fader.color.a < 0 and not fading_in:
			fader.color.a = 0
			fading = false
			ref.call_func()
