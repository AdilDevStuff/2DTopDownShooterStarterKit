extends CharacterBody2D

@export var follow_speed : float = 400

@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta: float) -> void:
	look_at(player.global_position)
	var direction = position.direction_to(player.global_position).normalized()
	velocity = direction * follow_speed
	move_and_slide()
