extends CharacterBody2D

#signals
signal water_updated
signal fertilizer_updated
# Player movement speed
@export var speed = 50
	# water and fertilizer stats

var water = 100
var water_level_max = 100
var regen_water = 5
var fertilizer = 100
var fertilizer_level_max = 100
var regen_fertilizer = 1

func _ready():
	water_updated.emit(water, water_level_max)
	
	fertilizer_updated.emit(fertilizer, fertilizer_level_max)
	
func _process(delta):
	var updated_water = min(water + regen_water * delta, water_level_max)
	if updated_water != water:
		water = updated_water
		updated_water.emit(water, water_level_max)
	
	var updated_fertilizer = min(fertilizer + regen_fertilizer * delta, fertilizer_level_max)
	if updated_fertilizer != fertilizer:
		fertilizer = updated_fertilizer
		updated_fertilizer.emit(fertilizer, fertilizer_level_max)
	
func _physics_process(delta):
	# Get player input (left, right, up/down)
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
		
		if Input.is_action_pressed("ui_down"):
			while water >= 25:
				speed = 100
				water = water - 5
				water_updated.emit(water, water_level_max)
	elif Input.is_action_just_pressed("ui_up"):
		while water >= 25:
			speed = 100
			water = water - 5
			water_updated.emit(water, water_level_max)
	elif Input.is_action_just_pressed("ui_right"):
		while water >= 25:
			speed = 100
			water = water - 5
			water_updated.emit(water, water_level_max)
	elif Input.is_action_just_pressed("ui_left"):
		while water >= 25:
			speed = 100
			water = water - 5
			water_updated.emit(water, water_level_max)
			
	# Apply movement
	var movement = speed * direction * delta
	# moves our player around, whilst enforcing collisions so that they come to a stop when colliding into other object.
	move_and_collide(movement)
	


