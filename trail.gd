extends Line2D

@export var color : Color = Color(1,1,1) # Color of the trail
@export var resolution : float = 5 # How many points per second
@export var max_points : int = 5

func _ready() -> void:
	
	$Timer.wait_time = 1.0/resolution


func _on_timeout() -> void:
	add_point(global_position)
	if get_point_count() > max_points:
		remove_point(0)
