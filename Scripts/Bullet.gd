extends Area2D

@export var bullet_speed: float = 600

func _process(delta: float) -> void:
	position += transform.x * bullet_speed * delta
