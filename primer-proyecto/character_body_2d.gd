extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var EXTRA_JUMPS = 3;
var MUERTO = false
var muertey = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor():
		EXTRA_JUMPS = 2
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if not is_on_floor() && not is_on_wall() && velocity.y > 100 * EXTRA_JUMPS+1 and not MUERTO:
		if $ASprite2D.animation != "fall":
			$ASprite2D.play("fall")
		print($ASprite2D.animation)
	
	
	if Input.is_action_pressed("ui_left") and not MUERTO: 
		velocity.x = -200
		$ASprite2D.flip_h = false
		if is_on_floor():
				$ASprite2D.play("walk")
	else:
		if Input.is_action_pressed("ui_right") and not MUERTO: 
			velocity.x = 200
			$ASprite2D.flip_h = true
			if is_on_floor():
				$ASprite2D.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.x == 0 and velocity.y == 0 and not MUERTO:
				$ASprite2D.play("idle")
			
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and not MUERTO: 
		velocity.y = -300
		$ASprite2D.play("jump")

	
	if is_on_wall():
		EXTRA_JUMPS = 2
		if velocity.y >0:
			$ASprite2D.play("wallfall")
			velocity.y = velocity.y/(delta*90) 
		if Input.is_action_pressed("ui_up"):
			velocity.y =-75
			$ASprite2D.play("wall")

		
			
	
	if EXTRA_JUMPS > 0 and not is_on_floor() and not is_on_wall():
		if Input.is_action_just_pressed("ui_up") and not is_on_floor() and not MUERTO: 
			velocity.y = -500
			EXTRA_JUMPS = EXTRA_JUMPS -1
			$ASprite2D.play("jump")
			print(str(EXTRA_JUMPS))
			pass
	if MUERTO:
		velocity.x = 0
		$Camera2D.set_limit(SIDE_TOP, muertey)
		$Camera2D.set_limit(SIDE_BOTTOM, muertey)
		velocity.y = velocity.y + 10
		$CollisionShape2D.disabled = true
	move_and_slide()


func _on_areamuerte_body_entered(body: Node2D) -> void:
	if not MUERTO: 
		muertey = position.y
		velocity.y = -500
	MUERTO = true
	$ASprite2D.play("death")
	print("te moriste :(")
	
	pass # Replace with function body.


func _on_a_sprite_2d_animation_finished() -> void:
	if MUERTO:
		print("bye bye!")
		get_tree().quit()
		$ASprite2D.sprite_frames.set_animation_loop_mode("die", SpriteFrames.LoopMode.LOOP_NONE)
	
	pass # Replace with function body.
