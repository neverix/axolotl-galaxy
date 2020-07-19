extends AudioStreamPlayer

var tracks = [
	preload("res://Music/la4.ogg"),
	preload("res://Music/ajr.ogg")
]
var levels = [
	# L0
	1, #0
	1, #1
	
	1, #2
	1, #3
	
	1, #4
	1, #5
	
	# L1
	0, #6
	0, #7
	 
	0, #8
	0, #9
	0, #10
	
	0, #11
	0, #12
	
	# L2
	0, #13
	0, #14
	
	# Menu
	0 #15
]
var current_track = -1

func _ready():
	if current_track == -1:
		switch(0)

func switch(track_index):
	if track_index == current_track:
		return
	set_stream(tracks[track_index])
	current_track = track_index
	play()
