extends Node2D
var DishesToCook = []
var Ticket = null
var Counter1full = false
var Counter2full = false
var Counter3full = false
@onready var counter_1 = $Counter1
@onready var counter_2 = $Counter2
@onready var counter_3 = $Counter3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func AddTicketToDishesToCook(options:String):
	DishesToCook.append(options)
	Ticket = null
	print(DishesToCook)
