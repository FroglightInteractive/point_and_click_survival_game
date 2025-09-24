extends CharacterBody2D

@onready var food_container: Node2D = $"../FoodContainer"

@export var target: Node2D
@export var speed: float = 150.0
@export var acceleration: float = 25.0

var score: int = 0

var foods: Array
var closest_food: Node2D


func _ready() -> void:
	for food in food_container.get_children():
		if food.is_in_group("food") && !foods.has(food):
			foods.append(food)


func _physics_process(delta: float) -> void:
	target = get_closest_food()

	if target:
		# if target exists, get target position, distance to player, and direction to player
		var target_pos := target.global_position
		var target_dir := global_position.direction_to(target_pos)
		var target_dist := global_position.distance_to(target_pos)

		# move towards target and stop if within a small distance
		velocity = lerp(velocity, target_dir * speed, acceleration * delta)
		if target_dist <= 1:
			velocity = Vector2.ZERO
	else:
		# stop moving if the target doesn't exist
		velocity = lerp(velocity, Vector2.ZERO, acceleration * delta)
		if velocity.is_zero_approx():
			velocity = Vector2.ZERO

	move_and_slide()


func _on_food_col_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		add_score(1)
		foods.erase(area)
		area.queue_free()


func add_score(amount: int) -> void:
	score += amount


func get_closest_food() -> Node2D:
	if foods.size() > 0:
		closest_food = foods[0]
		for food in foods:
			var distance_to_food := global_position.distance_squared_to(food.global_position)
			var distance_to_closest := global_position.distance_squared_to(closest_food.global_position)

			if distance_to_food < distance_to_closest:
				closest_food = food
	return closest_food
