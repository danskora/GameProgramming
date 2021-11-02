extends Node2D

export var _chip: PackedScene

var turn
var winner
var board
var turns_played


# Called when the node enters the scene tree for the first time.
func _ready():
	turn = 0
	winner = 2
	turns_played = 0
	board = [[],[],[],[],[],[],[]]
	for c in range(7):
		for _x in range(6):
			board[c].append(2)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if winner == 2:
		if turn == 0:
			self.get_parent().get_node("Player").player_process()
		else:
			self.get_parent().get_node("AI").ai_process()

func place_chip(c):
	var col = board[c]
	for r in range(6):
		if col[r] == 2:
			col[r] = turn
			turns_played += 1
			disp_chip(c, r)
			if check_winner():
				if winner == 0:
					$OutcomeMessage.set_bbcode("[center]Player Wins![/center]")
				elif winner == 1:
					$OutcomeMessage.set_bbcode("[center]AI Wins![/center]")
				else:
					$OutcomeMessage.set_bbcode("[center]Tie Game![/center]")
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


func get_board():
	var clone = []
	var original_col
	var clone_col
	for c in range(7):
		original_col = board[c]
		clone_col = []
		for r in range(6):
			clone_col.append(original_col[r])
		clone.append(clone_col)
	return clone

func check_winner():  # could be faster if I only checked the just-placed chip
	var n
	var failed
	for c in range(0,4,1):
		for r in range(0,3,1):
			if board[c][r] == turn:
				
				#check up
				n = 1
				failed = false
				while n<4 && !failed:
					if board[c][r+n] != turn:
						failed = true
					n+=1
				if !failed:
					winner = turn
					return true
				
				#check right
				n = 1
				failed = false
				while n<4 && !failed:
					if board[c+n][r] != turn:
						failed = true
					n+=1
				if !failed:
					winner = turn
					return true
						
				#check up-right
				n = 1
				failed = false
				while n<4 && !failed:
					if board[c+n][r+n] != turn:
						failed = true
					n+=1
				if !failed:
					winner = turn
					return true
		for r in range(3,6,1):
			if board[c][r] == turn:
				
				#check down-right
				n = 1
				failed = false
				while n<4 && !failed:
					if board[c+n][r-n] != turn:
						failed = true
					n+=1
				if !failed:
					winner = turn
					return true
				
				#check right
				n = 1
				failed = false
				while n<4 && !failed:
					if board[c+n][r] != turn:
						failed = true
					n+=1
				if !failed:
					winner = turn
					return true
	for c in range(4,7,1):
		for r in range(0,3,1):
			if board[c][r] == turn:
				
				#check up
				n = 1
				failed = false
				while n<4 && !failed:
					if board[c][r+n] != turn:
						failed = true
					n+=1
				if !failed:
					winner = turn
					return true
				
	if turns_played == 42:
		winner = 3
		return true
	return false
