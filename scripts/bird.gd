extends CharacterBody2D

# Connects to the global variable script.
@onready var global = get_node("/root/Global")

# Stores a constant value for jump velocity.
const JUMP_VELOCITY = -400.0

# Stores variables for local use.
var score = 0
var lock = false
var death_anim = false

# Creates blank variables to connect the player to nodes in the main scene.
@export var spawner : Node
@export var ui : Node
@export var colour_tint : Node
@export var hit_flash : Node

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# Runs when the scene is first loaded.
func _ready():
	# Resets the flash to its default value.
	hit_flash.color = Color(255, 255, 255, 0.0)


# Runs continously with 'delta' representing the time between frames.
func _physics_process(delta):
	# Make sure the player can control the character.
	if not lock:
		# Prevent the player from going too far outside the screen
		clamp(global_position.y, -50, 1000)
		# Check if the player has started the game.
		if global.player_ready:
			# Manage the gravity and rotation of the character.
			velocity.y += gravity * delta
			if rotation < deg_to_rad(45):
				rotation += 0.04
		
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			rotation = deg_to_rad(-50.0)
			# Set ready on first jump press.
			if not global.player_ready:
				global.player_ready = true
	# Manage movement during character death.
	elif death_anim:
		velocity.y += gravity * delta
		rotation = velocity.angle()
	
	# Lerp hit flash alpha back towards 0.0 after the character has died.
	if hit_flash.color.a > 0.0:
		hit_flash.color = lerp(hit_flash.color, Color(255, 255, 255, 0.0), 0.04)
	
	# Handles movement logic.
	move_and_slide()


# Increases the player's score when they pass through the area between pipes.
func _score_increase(area):
	if area.is_in_group("score"):
		# Prevents pipes counting twice
		if not area.get_parent().passed:
			area.get_parent(). passed = true
			score += 1
			ui._update_score(score)
			spawner._spawn_pipe()


# Runs when the player collides with a pipe.
func _pipe_collision(body):
	if body.is_in_group("pipe"):
		_death()


# Runs when the player drops out of the bottom of the map.
func _enter_killzone(area):
	if area.is_in_group("killzone"):
		_death()


# Handles operations for the player death visuals.
func _death():
	lock = true
	global.player_ready = false
	if score > global.high_score:
		global.high_score = score
	get_tree().paused = true
	velocity.y = 0
	$collision.set_deferred("disabled", true)
	global._save_score()
	hit_flash.color = Color(255, 255, 255, 1.0)
	await get_tree().create_timer(1.0).timeout
	ui._end_game(score, global.high_score)
	colour_tint.show()
	death_anim = true
	velocity.y = JUMP_VELOCITY
	velocity.x = -100
