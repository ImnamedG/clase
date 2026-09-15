
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var EXTRA_JUMPS = 3;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		EXTRA_JUMPS = 2
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if Input.is_action_pressed("ui_left"): 
		velocity.x = -200
	else:
		if Input.is_action_pressed("ui_right"): 
			velocity.x = 200
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_pressed("ui_up") and is_on_floor(): 
		velocity.y = -300
		
	if is_on_wall():
		EXTRA_JUMPS = 2
		if velocity.y >0:
			velocity.y = velocity.y/1.5
		if Input.is_action_pressed("ui_up"):
			velocity.y =-75
		
			
	
	if EXTRA_JUMPS > 0 and not is_on_floor() and not is_on_wall():
		if Input.is_action_just_pressed("ui_up") and not is_on_floor(): 
			velocity.y = -500
			EXTRA_JUMPS = EXTRA_JUMPS -1
			print(str(EXTRA_JUMPS))
			pass
		
	move_and_slide()
