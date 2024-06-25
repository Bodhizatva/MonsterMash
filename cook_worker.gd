extends CharacterBody2D
var speed = 1
var acceleration = 3

var CookingOrderAlready = false
var OrderToCook = null





@onready var StoveLogic = $StoveLogicNode
@onready var CounterLogic = $"../CounterLogicNode"
@onready var counter_logic_node = $"../CounterLogicNode"
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var sprite_2d = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.ZERO
	direction = direction.normalized()
	direction = navigation_agent_2d.get_next_path_position() - global_position
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	sprite_2d.flip_h = false if velocity.x > 0 else true # flips sprite depending of directiong going
	ThoughtProcess()
	pass

func ThoughtProcess():
	GetOrderFromCounter()
	WhichStoveIsEmpty()
	pass
	
func GetOrderFromCounter():
	if CounterLogic.DishesToCook.size() > 0 and not CookingOrderAlready:
		navigation_agent_2d.target_position = CounterLogic.global_position
		move_and_slide()
		print("going")
		if navigation_agent_2d.is_navigation_finished():
			CookingOrderAlready = true
			OrderToCook = CounterLogic.DishesToCook[0]
			CounterLogic.DishesToCook.remove(0)
			print("The cook takes the ticket and it says to cook" + str(OrderToCook))
			

func WhichStoveIsEmpty():
	if CookingOrderAlready and not StoveLogic.Stove1Cooking: #and not StoveLogic.Stove2Cooking and not StoveLogic.Stove3Cookingand and not StoveLogic.Stove4Cooking:
		navigation_agent_2d.target_position = StoveLogic.Stove1.global_position
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			print("Cook has reached Stove1")
			StoveLogic.Stove1Cooking == true
	if CookingOrderAlready and not StoveLogic.Stove2Cooking:#and not StoveLogic.Stove1Cooking and not StoveLogic.Stove3Cookingand and not StoveLogic.Stove4Cooking:
		navigation_agent_2d.target_position = StoveLogic.Stove2.global_position
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			print("Cook has reached Stove2")
			StoveLogic.Stove2Cooking == true
	if CookingOrderAlready and not StoveLogic.Stove3Cooking:# and not StoveLogic.Stove1Cooking and not StoveLogic.Stove2Cookingand and not StoveLogic.Stove4Cooking:
		navigation_agent_2d.target_position = StoveLogic.Stove3.global_position
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			print("Cook has reached Stove3")
			StoveLogic.Stove3Cooking == true
	if CookingOrderAlready and not StoveLogic.Stove4Cooking:# and not StoveLogic.Stove1Cooking and not StoveLogic.Stove2Cookingand and not StoveLogic.Stove3Cooking:
		navigation_agent_2d.target_position = StoveLogic.Stove4.global_position
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			print("Cook has reached Stove4")
			StoveLogic.Stove4Cooking == true
	else:
		print("ALL STOVES ARE FULL")
		
func FigureOutWhatToCook():
	if OrderToCook != null:
		pass



