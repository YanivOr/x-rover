extends Node

var score = 0
var lives = 3
	
func incrementScore():
	score += 1

func decrementScore():
	score -= 1

func incrementLives():
	lives += 1

func decrementLives():
	lives -= 1