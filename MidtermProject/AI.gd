extends Node2D


class MyTree:
	var children
	var heuristic
	
	func _init():
		children = []
	
	func set_heuristic(val):
		heuristic = val
	
	func get_heuristic():
		return heuristic
	
	func add_child(tree):
		children.append(tree)
	
	func get_children():
		return children





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func ai_process():
	var game_state = self.get_parent().get_node("GameState")
	game_state.place_chip(best_move(game_state.get_board(), 2))

func best_move(matrix, depth):  # minimax algorithm
	var tree = generate_tree(matrix, depth * 2)
	
	
	
	alpha_beta(-70, 70, tree, true)  # set the heuristics instead of returning values in ab pruning
	
	
	var best = tree.get_heuristic()
	
	
	
	var children = tree.get_children()
	var child
	for i in range(len(children)):
		if children[i].get_heuristic() == best:
			child = i
			break
			
	for i in range(7):
		if matrix[i][5] == 2:
			child -= 1
		if child == -1:
			return i
	
	
	
	


# if depth 0 is never reached?  No heuristics?
# what if someone wins before max depth?
# list append vs 7 distinct children

func generate_tree(matrix, depth):
	var root = MyTree.new()
	
	var root_heuristic = heuristic1(matrix)
	root.set_heuristic(root_heuristic)
	
	if depth == 0 || abs(root_heuristic) == 70:
		return root
	
	
	var col
	var r
	
	for c in range(7):
		
		# try to place chip
		col = matrix[c]
		r = 0
		while r<6:
			if col[r] == 2:
				col[r] = (depth+1)%2
				root.add_child(generate_tree(matrix, depth-1))
				col[r] = 2
				break
			r += 1
	
	return root



#pass down alpha beta
#pass up alpha or beta and alternate
#max change alpha, min change beta
#prune if a>=b

func alpha_beta(alpha, beta, tree, isMaxTurn):
	var children = tree.get_children()
	
	var child_ab
	
	
	# if leaf
	if len(children) == 0:
		return
	
	# if max turn
	if isMaxTurn:
		for i in range(len(children)):
			if alpha >= beta:
				break
			alpha_beta(alpha, beta, children[i], !isMaxTurn)
			child_ab = children[i].get_heuristic()
			if child_ab > alpha:
				alpha = child_ab
		tree.set_heuristic(alpha)
		
	
	# if min turn
	else:
		for i in range(len(children)):
			if alpha >= beta:
				break
			alpha_beta(alpha, beta, children[i], !isMaxTurn)
			child_ab = children[i].get_heuristic()
			if child_ab < beta:
				beta = child_ab
		tree.set_heuristic(beta)






# This heuristic is the first one I coded.  It is based off the reccomendation of Geoffrey De Smet on StackOverflow.
# The value is based off how many of the 69 possible winning positions are still available to each player.
func heuristic1(matrix):
	var heuristic = 0
	var chip_product
	for c in range(0,4,1):
		for r in range(0,3,1):
			#check up
			chip_product = 1
			for n in range(4):
				chip_product *= (matrix[c][r+n]+3)
			if chip_product % 3 == 0:
				if chip_product == 81:
					return -70
				heuristic -= 1
			if chip_product % 2 == 0:
				if chip_product == 256:
					return 70
				heuristic += 1
					
			#check right
			chip_product = 1
			for n in range(4):
				chip_product *= (matrix[c+n][r]+3)
			if chip_product % 3 == 0:
				if chip_product == 81:
					return -70
				heuristic -= 1
			if chip_product % 2 == 0:
				if chip_product == 256:
					return 70
				heuristic += 1
				
			#check up-right
			chip_product = 1
			for n in range(4):
				chip_product *= (matrix[c+n][r+n]+3)
			if chip_product % 3 == 0:
				if chip_product == 81:
					return -70
				heuristic -= 1
			if chip_product % 2 == 0:
				if chip_product == 256:
					return 70
				heuristic += 1
				
				
		for r in range(3,6,1):
			#check down-right
			chip_product = 1
			for n in range(4):
				chip_product *= (matrix[c+n][r-n]+3)
			if chip_product % 3 == 0:
				if chip_product == 81:
					return -70
				heuristic -= 1
			if chip_product % 2 == 0:
				if chip_product == 256:
					return 70
				heuristic += 1
				
			#check right
			chip_product = 1
			for n in range(4):
				chip_product *= (matrix[c+n][r]+3)
			if chip_product % 3 == 0:
				if chip_product == 81:
					return -70
				heuristic -= 1
			if chip_product % 2 == 0:
				if chip_product == 256:
					return 70
				heuristic += 1
				
				
	for c in range(4,7,1):
		for r in range(0,3,1):
			#check up
			chip_product = 1
			for n in range(4):
				chip_product *= (matrix[c][r+n]+3)
			if chip_product % 3 == 0:
				if chip_product == 81:
					return -70
				heuristic -= 1
			if chip_product % 2 == 0:
				if chip_product == 256:
					return 70
				heuristic += 1
				
	return heuristic
