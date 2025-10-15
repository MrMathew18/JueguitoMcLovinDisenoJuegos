extends Area2D
#
#@onready var label = $Label
#
#func _on_body_entered(body):
	#print("i word")
#
@export var word_text: String = ""
var is_collected = false

func _ready():
	$Label.text = word_text
	# Connect the signal for when player touches the word
	#body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not is_collected and body.is_in_group("player"):
		is_collected = true
		# Emit signal to notify sentence manager
		get_tree().call_group("sentence_manager", "add_word_to_sentence", word_text)
		queue_free()  # Remove the word after collection
