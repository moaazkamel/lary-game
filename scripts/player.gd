extends CharacterBody2D


var speed = 95.0

var jump_velocity = -285.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



var coyote_time = 0.15 

var coyote_timer = 0.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		coyote_timer -= delta
	else:
		coyote_timer = coyote_time
	if Input.is_action_just_pressed(' jump') and coyote_timer > 0:
		velocity.y = jump_velocity
		coyote_timer = 0


	var direction = Input.get_axis("move_left", "move_right")
	
	if direction	 > 0:
		animated_sprite.flip_h = false 
	elif direction < 0:
		animated_sprite.flip_h = true 
	
	
	if is_on_floor():
		
	
		if direction == 0:
			animated_sprite.play("idel")
		else:
		
			animated_sprite.play("run")
	
	else: 
		animated_sprite.play("jump")
	
	if direction:
		
		
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	
