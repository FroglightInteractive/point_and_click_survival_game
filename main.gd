extends Node2D

@onready var food_scene: PackedScene = preload("res://Food/food.tscn")

@onready var cursor_pos: Node2D = $CursorPos


func _process(_delta: float) -> void:
    cursor_pos.global_position = get_global_mouse_position()

    if Input.is_action_just_pressed("place_food"):
        var _food = food_scene.instantiate()
        $FoodContainer.add_child(_food)
        _food.global_position = cursor_pos.global_position
        $Character.foods.append(_food)
