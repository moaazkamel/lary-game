extends CharacterBody2D

var speed = 95.0


var jump_velocity = -285.0

func _ready():
	add_to_group("player")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



var coyote_time = 0.15



var coyote_timer = 0.0

var jumps_left = 2
var wall_slide_speed = 70.0



@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	
	
	var direction = Input.get_axis("move_left", "move_right")




	if is_on_floor():
		coyote_timer = coyote_time
		jumps_left = 2
	else:
		
		
		
		
		coyote_timer = max(coyote_timer - delta, 0.0)
		
		
		velocity.y += gravity * delta
		
		



	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if direction != 0:
		velocity.x = direction * speed
		
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)




	var wall_sliding = false
	
	
	

	if not is_on_floor() and is_on_wall() and velocity.y > 0 and direction != 0:
		wall_sliding = true
		
		
		
		velocity.y = min(velocity.y, wall_slide_speed)
		jumps_left = 2

	if Input.is_action_just_pressed("jump"):
		
		
		
		if wall_sliding:
			velocity.y = jump_velocity
			jumps_left = 1
			
			
			animated_sprite.play("jump")
			
			
			
		elif coyote_timer > 0.0:
			velocity.y = jump_velocity
			coyote_timer = 0.0
			
			
			
			jumps_left = 1
			animated_sprite.play("jump")
		elif jumps_left > 0:
			
			
			
			velocity.y = jump_velocity
			
			
			
			jumps_left -= 1
			animated_sprite.play("doublejump")

	move_and_slide()

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idel")
			
			
			
		else:
			animated_sprite.play("run")
	else:
		
		
		if wall_sliding:
			animated_sprite.play("sliding")
		elif not Input.is_action_just_pressed("jump"):
			
			if jumps_left == 1:
				animated_sprite.play("jump")
