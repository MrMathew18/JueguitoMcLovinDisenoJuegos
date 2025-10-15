extends Node
var oracion: Array = []
@onready var word_poolCorrecto = [ "Hello", "Mindy", "Oh", "I", "love", "that", "stuff", "Been", 
	"drinking", "it", "for", "years", "I", "heard", "they", "recently", 
	"decided", "to", "start", "adding", "more"]

signal sentence_updated(new_sentence)	
func _ready():
	spawn_random_word()

func spawn_random_word():
	var word_scene = preload("res://Scenes/words.tscn")
	var new_word = word_scene.instantiate()
	
	# Set random word from pool
	var random_word = word_poolCorrecto[randi() % word_poolCorrecto.size()]
	new_word.word_text = random_word
	
	# Set random position within screen bounds
	var viewport_size = get_viewport().get_visible_rect().size
	new_word.position = Vector2(
		randf_range(50, viewport_size.x - 50),
		randf_range(50, viewport_size.y - 50)
	)
	
	add_child(new_word)

func add_word_to_sentence(word: String):
	oracion.append(word)
	sentence_updated.emit(" ".join(oracion))
	
	# Spawn a new word to replace the collected one
	spawn_random_word()
	
	# Optional: Check if sentence is complete
	check_sentence_completion()

func check_sentence_completion():
	if oracion.size() >= 20:  # Example: 5 words make a complete sentence
		print("Sentence complete: ", " ".join(oracion))
		oracion.clear()
		sentence_updated.emit("")
