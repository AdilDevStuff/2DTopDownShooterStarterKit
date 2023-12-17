extends CharacterBody2D

@export var player_speed: float = 400
@export var firerate: float = 0.2

var health = 3
var can_shoot: bool = true
var can_move: bool = true

@export var bullet_spawn_pos : Marker2D
@export var bullet_scene : PackedScene

func _physics_process(_delta: float) -> void:
	player_movement()
	shooting()

func player_movement():
	look_at(get_global_mouse_position())
	if not can_move: return
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	if input_vector:
		velocity = input_vector.normalized() * player_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func shooting():
	if Input.is_action_pressed("Shoot") and can_shoot:
		spawn_bullet()
		can_shoot = false
		await get_tree().create_timer(firerate).timeout
		can_shoot = true

func spawn_bullet():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_transform = bullet_spawn_pos.global_transform
	get_parent().add_child(bullet_instance)

func knockback(body):
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		print(collision.get_normal())
		

func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		health -= 1
		knockback(body)
