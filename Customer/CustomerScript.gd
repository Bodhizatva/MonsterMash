extends CharacterBody2D

var FoundTable = false
var FoundSeat = false
var Walking = false
var Eating = false
var WalkSpeed = 2
var IdleState  = false
var TableToGoTo = null
var DishSelected = null
var IsWaitingForServer = false
var BeingHelpedByServer = false
var OrderPutIn = false
var FoundAndGoingToTable = false
var SittingInSeat = false

@onready var SpawnedTables = get_tree().get_nodes_in_group("TableSmall")


#----- new move model with navmesh
var speed = 1
var acceleration = 3
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var sprite_2d = $Sprite2D

#===========================

#===========================




func _physics_process(delta):
	var direction = Vector2.ZERO
	direction = direction.normalized()
	direction = navigation_agent_2d.get_next_path_position() - global_position
	velocity = velocity.lerp(direction * speed, acceleration * delta)
	sprite_2d.flip_h = false if velocity.x > 0 else true # flips sprite depending of directiong going
	ThoughtProcess()
	pass
	
	
func FindTable():
	SpawnedTables = get_tree().get_nodes_in_group("TableSmall")
	if SpawnedTables.size() > 0 and not FoundTable:
		var shortest_distance : float = INF
		for table in SpawnedTables:
			if table.visible and table.get("TableEmpty"):
				var curr_dist : float = global_position.distance_to(table.global_position)
				if curr_dist < shortest_distance:
					TableToGoTo = table
					shortest_distance = curr_dist
					table.TableEmpty = false
					#Changes specific table to taken and specifies it as Its Table to go to
					FoundTable = true
					navigation_agent_2d.target_position = table.get_node("SeatSelectionArea").global_position
					FoundAndGoingToTable = true
					
					
		
		
func GotoTable():
	#await get_tree().create_timer(1.0).timeout
	if FoundAndGoingToTable:
		move_and_slide()
		if navigation_agent_2d.is_navigation_finished():
			GotoSeat()
			print("gotoseat started")
			


func ThoughtProcess():
	if not IsWaitingForServer:
		FindTable()
		GotoTable()
	if IsWaitingForServer:
		WaitingForServer()
		
	

func IdleStateLoop():
	pass

func GotoSeat():
	var Seat1Open =  TableToGoTo.get("Seat1Empty")
	var Seat2Open = TableToGoTo.get("Seat2Empty")
	if Seat1Open:
		var SeatToGoTo = TableToGoTo.get_node("Seat")
		navigation_agent_2d.target_position = SeatToGoTo.global_position
		if navigation_agent_2d.is_navigation_finished():
			print("Customer In Their Seat")
			SittingInSeat = true
			FoodOrderProcess()
	if not Seat1Open and Seat2Open:
		var SeatToGoTo = TableToGoTo.get_node("Seat2")
		navigation_agent_2d.target_position = SeatToGoTo.global_position
		if navigation_agent_2d.is_navigation_finished():
			print("Customer In Their Seat2")
			SittingInSeat = true
			FoodOrderProcess()

func FoodOrderProcess():
	var i = get_weighted_probability(MainScript.UnlockedDishWeight)
	print(i)
	DishSelected = i
	WaitingForServer()
	
	#for UnlockedDishes in MainScript.UnlockedDishes:
		#if MainScript.UnlockedDishes[UnlockedDishes][0]:
			
			
	pass
func WaitingForServer():
	if DishSelected != null and not OrderPutIn:
		#print("waiting for server")
		#print("the dish wanted is" + str(DishSelected))
		IsWaitingForServer = true
		await get_tree().create_timer(2.0).timeout
		pass


#-------------------
#Randomizer i got online
func rand_int(begin:int = 0, end:int = 10):
	randomize()
	return randi() % (end+1) + begin

func get_weighted_probability(options:Array):
	#Enter a 2D array with:
	#1st column == options to choose from.
	#2nd column == the probability of that option as an int. (usually out of 100).
	#The probability total may add up to more or less than 100 and still work correctly.
	var arrCopy:Array = options.duplicate(true)
	var totalProbability:int=0
	
	for i in options.size():
		totalProbability+= int(arrCopy[i][1])
		continue
	
	var chosenOptionInt:int= rand_int(0,totalProbability)
	
	var growingProbability:int=0
	for a in arrCopy.size():
		growingProbability+=int(arrCopy[a][1])
		arrCopy[a][1] = growingProbability
		
		if arrCopy[a][1] > chosenOptionInt:
			return arrCopy[a][0]
		elif chosenOptionInt <= arrCopy[arrCopy.size()-1][1]:
			return arrCopy[arrCopy.size()-1][0]
		else:
			continue
#---------------------
