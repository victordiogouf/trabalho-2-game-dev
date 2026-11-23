extends Control

@onready var fundo = $ColorRect

func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(fundo, "color", Color("#4a0e1e"), 2.0)
	tween.tween_property(fundo, "color", Color("#1e0a36"), 2.0)


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
