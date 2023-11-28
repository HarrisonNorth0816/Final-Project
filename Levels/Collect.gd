extends Area2D

func _ready():
	body_entered.connect(_on_BodyEntered)

func _on_BodyEntered(body):
	if body.is_in_group("Collect"):
		hide_tileset()

func hide_tileset():
	if get_tree().has_node("Layer1"):
		var tileset = get_tree().get_node("Layer1")
		tileset.visible = false
