extends Node2D
@onready var main = $".."

var TableInstance1 = preload("res://table_base_node_2d.tscn")

#Links to Table Positions
@onready var Table1Pos = $TablePosition1
@onready var Table2Pos = $TablePosition2
@onready var Table3Pos = $TablePosition3
@onready var Table4Pos = $TablePosition4




# Called when the node enters the scene tree for the first time.
func _ready():
	TableCheck()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func TableCheck():
	if MainScript.TablesOwned["Table1"] == true:
		var Table1Spawn = TableInstance1.instantiate()
		Table1Spawn.position == Table1Pos.position
		Table1Spawn.add_to_group("TableSmall")
		Table1Pos.add_child(Table1Spawn)
	else:
		print("notwirking")
