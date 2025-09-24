extends CharacterBody2D

@export var target: Node2D
@export var speed: float = 80.0
@export var acceleration: float = 25.0


func _ready() -> void:
    target = $"../Character"


func _physics_process(delta: float) -> void:
    if target:
        velocity = lerp(velocity, global_position.direction_to(target.global_position) * speed, acceleration * delta)
    else:
        velocity = lerp(velocity, Vector2.ZERO, acceleration * delta)

    move_and_slide()
