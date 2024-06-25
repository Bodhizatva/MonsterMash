extends CharacterBody2D
var CustomerToGoTo = null
var speed = 0.6
var acceleration = 3
var TicketForCook = null
@onready var Customer = get_tree().get_nodes_in_group("Customer")
@onready var TicketTable = $"../CounterLogicNode"
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
	if CustomerToGoTo == null:
		LookForCustReadyOrder()
	if CustomerToGoTo != null and TicketForCook == null:
		GoToOrderReadyCustomer()
	if TicketForCook != null:
		GoToTicketTable()
	

func LookForCustReadyOrder(): #Sets CustomerToGoTo var to which customer/table/location/pos
	var Customer = get_tree().get_nodes_in_group("Customer")
	if Customer.size() >= 0 and CustomerToGoTo == null: #and not Customer.Get("OrderPutIn"):
		for i in Customer:
			if i.get("IsWaitingForServer") and not i.get("BeingHelpedByServer") and not i.get("OrderPutIn"):
				CustomerToGoTo = i
				#print("the server has found the customer and the customer is" + str(CustomerToGoTo))
				#print("the customers dish is " + str(i.get("DishSelected")))
	

func GoToOrderReadyCustomer():
	if CustomerToGoTo != null:
		navigation_agent_2d.target_position = CustomerToGoTo.global_position
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			print("arrived at customer")
			TicketForCook = CustomerToGoTo.get("DishSelected")
			CustomerToGoTo.OrderPutIn = true
			print("the waiter wrote down the customer wants:" + str(TicketForCook))

func GoToTicketTable():
	if TicketForCook != null:
		print("goingtotickettable")
		navigation_agent_2d.target_position = TicketTable.position
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			TicketTable.AddTicketToDishesToCook(TicketForCook)
			TicketForCook = null
			CustomerToGoTo = null
		
		#print("we are here at the Ticket Table")

#func PassTheTicketToCookTable():
	#TicketForCook
	#CustomerToGoTo
