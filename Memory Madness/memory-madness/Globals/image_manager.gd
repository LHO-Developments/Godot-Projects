extends Node

const TILE_IMAGES:TileImageHolder = preload("uid://75dw3m6oh252");

func get_random_item_image() -> Texture2D:
	return TILE_IMAGES.tile_images.pick_random();
