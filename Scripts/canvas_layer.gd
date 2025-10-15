extends CanvasLayer
func _ready():
	get_tree().call_group("sentence_manager", "sentence_updated", _on_sentence_updated)

func _on_sentence_updated(sentence: String):
	$SentenceLabel.text = "Sentence: " + sentence
