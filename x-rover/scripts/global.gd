extends Node

var score = 0
var lives = 3
var key = false

func _process(delta):
	if lives == 0:
		pass

func increment_score():
	score += 1

func decrement_score():
	score -= 1

func increment_lives():
	lives += 1

func decrement_lives():
	lives -= 1
	
func got_key():
	key = true
