extends Node2D

export var speed = 10
export var min_distance = 100
export var max_distance = 300

func _process(delta):
	var distance = GameManager.player.position.distance_to(position)
	if min_distance < distance and distance < max_distance:
		GameManager.player.health.damage(delta * speed)
