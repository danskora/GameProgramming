extends Node2D

export var _chip: PackedScene

var turn
var winner
var board


# Called when the node enters the scene tree for the first time.
func _ready():
	turn = 0
	winner = 2
	board = [[],[],[],[],[],[],[]]
	for c in range(7):
		for x in range(6):
			board[c].append(2)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func place_chip(c):
	var col = board[c]
	for r in range(6):
		if col[r] == 2:
			col[r] = turn
			disp_chip(c, r)
			turn = (turn+1)%2
			return

func disp_chip(col, row):
	var offset = Vector2(90 * col, -80 * row)
	var new_chip = _chip.instance()
	new_chip.position += offset
	if turn == 0:
		new_chip.modulate = Color(100,100,1)
	else:
		new_chip.modulate = Color(100,1,1)
	add_child(new_chip)
