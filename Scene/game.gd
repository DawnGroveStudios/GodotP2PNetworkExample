extends Node2D

var playerObj = preload("res://Scripts/Player/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p = playerObj.instantiate()
	add_child(p)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
