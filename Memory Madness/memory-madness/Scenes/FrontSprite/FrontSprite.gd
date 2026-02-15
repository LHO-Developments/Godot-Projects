extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = ImageManager.get_random_item_image();
