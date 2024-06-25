extends Camera2D

@export var zoom_speed: float = 0.1
@export var pan_speed: float = 1.0
@export var rotation_speed: float = 1.0
@export var can_pan: bool
@export var can_zoom: bool
@export var can_rotate: bool

var start_zoom: Vector2
var start_dist: float
var touch_points: Dictionary = {}
var start_angle: float
var current_angle: float

var zoom_speed_scroll = 0.1
var min_zoom = 0.5
var max_zoom = 2.0

func _ready():
	# Called when the node is added to the scene for the first time.
	pass

func _input(event):
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag:
		_handle_drag(event)
		

func _handle_touch(event: InputEventScreenTouch):
	if event.pressed:
		touch_points[event.index] = event.position
	else:
		touch_points.erase(event.index)

	if touch_points.size() == 2:
		var touch_point_positions = touch_points.values()
		start_dist = touch_point_positions[0].distance_to(touch_point_positions[1])
		start_zoom = zoom
		start_dist = 0

func _handle_drag(event: InputEventScreenDrag):
	touch_points[event.index] = event.position
	# Handle 1 touch point
	if touch_points.size() == 1 and can_pan:
		position -= event.relative.rotated(rotation) * pan_speed
	# Handle 2 touch points
	elif touch_points.size() == 2 and can_zoom:
		var touch_point_positions = touch_points.values()
		var current_dist = touch_point_positions[0].distance_to(touch_point_positions[1])

		var zoom_factor = start_dist / current_dist
		zoom = start_zoom / zoom_factor

		




