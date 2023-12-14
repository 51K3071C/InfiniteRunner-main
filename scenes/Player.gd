extends CharacterBody3D

@onready var death_sensor = $DeathSensor
@onready var material = $MeshInstance3D.material_override

var positions = [-3,0,3]
var curPos = 1

var swipeLength = 100
var startSwipe: Vector2
var curSwipe: Vector2
var swiping = false

var threshold = 20
var swipeDir = 0

const JUMP_VEL = 7
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	swipe()
	if swipeDir == 1:
		if curPos < 2:
			curPos += 1
			swipeDir = 0
	elif swipeDir == -1:
		if curPos > 0:
			curPos -= 1
			swipeDir = 0
			
	
	position.z = lerpf(position.z, positions[curPos],delta*30)
	if death_sensor.is_colliding():
		death()
	
	velocity.y -= gravity*delta
	move_and_slide()
func _onready():
	GlobalMusicManager.play_song()
func color_change():
	material.albedo_color = Color8(randi() % 256, randi() % 256, randi() % 256)
func swipe():
	if Input.is_action_just_pressed("left"):
		swipeDir = -1
		swiping = true
		
	elif Input.is_action_just_pressed("right"):
		swipeDir = 1
		swiping = true
	elif Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VEL
		swiping = true
		color_change()
	else:
		swiping = false
	#if Input.is_action_just_pressed("press"):
	#	if !swiping:
	#		swiping = true
	#		startSwipe = get_viewport().get_mouse_position()
	#		
	#if Input.is_action_pressed("press"):
	#	if swiping:
	#		curSwipe = get_viewport().get_mouse_position()
	#		if startSwipe.distance_to(curSwipe) >= swipeLength:
	#			
	#			if abs(startSwipe.y-curSwipe.y) < threshold:
	#				if startSwipe.x-curSwipe.x < 0:
	#					swipeDir = 1
	#				else:
	#					swipeDir = -1
	#			if abs(startSwipe.x-curSwipe.x) < threshold:
	#				if startSwipe.y-curSwipe.y > 0 and is_on_floor():
	#					velocity.y = JUMP_VEL
	#					
	#			swiping = false
	#else:
	#	swiping = false

func death():
	GlobVars.musicProgress = $Music.get_playback_position()
	get_tree().reload_current_scene()
