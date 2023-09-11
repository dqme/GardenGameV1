extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.water_updated.connect($UI/Water.water_updated)
	$Player.fertilizer_updated.connect($UI/Fertilizer.fertilizer_updated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
