extends TextureButton
class_name MemoryTile;

@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage

func _ready() -> void:
	reveal(false);

func setup(image: Texture2D, frame: Texture2D) -> void:
	frame_image.texture = frame;
	item_image.texture = image;

func matches_other_tile(other: MemoryTile) -> bool:
	return other != self and other.item_image.texture == item_image.texture;

func kill_on_pair() -> void:
	disabled = true;
	modulate = Color.TRANSPARENT;

func reveal(r: bool) -> void:
	frame_image.visible = r;
	item_image.visible = r;


func _on_pressed() -> void:
	if !Scorer.SelectionEnabled: return
	reveal(true);
	SignalHub.emit_on_tile_selected(self)
	
