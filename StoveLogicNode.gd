extends Node2D
var Stove1Cooking = false
var Stove2Cooking = false
var Stove3Cooking = false
var Stove4Cooking = false
@onready var Stove1Pos = $Stove1
@onready var Stove2Pos = $Stove2
@onready var Stove3Pos = $Stove3
@onready var Stove4Pos = $Stove4
var CookingRange1 = preload("res://cooking_range.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	RangeSpawnCheck()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func RangeSpawnCheck():
	if MainScript.StovesOwned["Stove1"] == true:
		var Stove1Spawn = CookingRange1.instantiate()
		Stove1Spawn.position == Stove1Pos.position
		Stove1Spawn.add_to_group("StoveSmall")
		Stove1Pos.add_child(Stove1Spawn)
	pass
