extends Area2D

export var portal_id = 0
var disabled = false
var pair = null

func _ready():
	var portals = get_tree().get_nodes_in_group("Portal")
	for portal in portals:
		if portal != self and portal.portal_id == portal_id:
			pair = portal

func body_enter(body):
	if body == GameManager.cur_player and not disabled:
		body.position = pair.position
		disabled = true
		pair.disabled = true


func body_exit(body):
	if body == GameManager.cur_player and disabled:
		disabled = false
		pair.disabled = false
