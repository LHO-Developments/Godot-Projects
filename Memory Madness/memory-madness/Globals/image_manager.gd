extends Node

const TILE_IMAGES:TileImageHolder = preload("uid://75dw3m6oh252");

func get_random_item_image() -> Texture2D:
	return TILE_IMAGES.tile_images.pick_random();

func shuffle_images() -> void:
	TILE_IMAGES.tile_images.shuffle();

func get_image_at_index(index: int) -> Texture2D:
	if index > TILE_IMAGES.tile_images.size() or index < 0:
		printerr("get_image_at_index issue: ", index);
	return TILE_IMAGES.tile_images[index];
