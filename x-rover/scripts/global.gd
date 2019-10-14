extends Node

var score = 0
var lives = 3
var key = false

func _process(delta):
	if lives == 0:
		pass

func incrementScore():
	score += 1

func decrementScore():
	score -= 1

func incrementLives():
	lives += 1

func decrementLives():
	lives -= 1
	
func gotKey():
	key = true
