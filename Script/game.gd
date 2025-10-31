extends Node2D

# 1. Add these variables here, at the top of the script.
const ENEMY_SCENE = preload("res://Scene/enemy.tscn")
const TOO_CLOSE = 10
const MIN_SPAWN_RANGE = 1
const MAX_SPAWN_RANGE = 100
@onready var dwarf_player = $"DwarfPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # We don't need anything here yet.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Or here.

# Get one random vector between min and max range
func getRandomVector():
	return randf_range(MIN_SPAWN_RANGE,MAX_SPAWN_RANGE) * pow(-1, randi() % 2)

# Get a random spot using 2 random vectors
func getRandomSpot():
	var xVector = getRandomVector()
	var yVector = getRandomVector()
	# make sure enemy doesnt spawn on top of player
	if abs(xVector) < TOO_CLOSE:
		while abs(yVector) < TOO_CLOSE:
			yVector = getRandomVector()
	return Vector2(xVector, yVector)

# 2. Replace the 'pass' in this function with the spawning code.
func _on_timer_timeout():
	# Create a new instance of the enemy.
	var new_enemy = ENEMY_SCENE.instantiate()
	
	# Set the enemy's position to that random spot.
	new_enemy.global_position = dwarf_player.position + getRandomSpot()
	
	# Add the new enemy to the game world.
	add_child(new_enemy)
