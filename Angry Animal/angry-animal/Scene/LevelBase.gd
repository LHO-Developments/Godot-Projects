extends Node2D

@onready var animal_start: Marker2D = $AnimalStart
const ANIMAL = preload("res://Scene/Animal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal();

func spawn_animal() -> void:
	var animalObj: Animal = ANIMAL.instantiate();
	animalObj.position = animal_start.position;
	add_child(animalObj);

func _enter_tree() -> void:
	SignalHub.on_animal_died.connect(spawn_animal);
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://Scene/main.tscn");
