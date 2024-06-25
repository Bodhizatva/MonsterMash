extends Node2D

var CoinsOwned = 0
var TablesOwned = {"Table1": true,"Table2": true,"Table3": false,"Table4": false}
var StovesOwned = {"Stove1": true,"Stove2": true,"Stove3": false,"Stove4": false}
var UnlockedDishes = {"Grub":[true], "ChickenWing":[false]}
var UnlockedDishWeight = [
	["Grub",10],
	["ChickenWing",3]
]
#--
#do i need below?
var TableInstantiated = {"Table1": false,"Table2": false,"Table3": false,"Table4": false}
#--
var EndOfDay = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func StartofDayFunction():
	pass

func EndofDayFunction():
	pass
