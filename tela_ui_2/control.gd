extends Control

@export var velocidade_rolagem: float = 25.0
@onready var texto_creditos = $TextoCreditos
@onready var mensagem_vitoria = $MensagemVitoria

var rolando: bool = false

func _ready() -> void:
	texto_creditos.visible = false
	mensagem_vitoria.visible = true
	
	
	await get_tree().create_timer(6.0).timeout
	
	
	mensagem_vitoria.visible = false
	texto_creditos.visible = true
	rolando = true

func _process(delta: float) -> void:
	if not rolando:
		return
		
	texto_creditos.position.y -= velocidade_rolagem * delta
	
	
	if texto_creditos.position.y + texto_creditos.size.y < 0:
		get_tree().change_scene_to_file("res://tela_ui_2/tela_inicial.tscn")
func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://tela_ui_2/tela_inicial.tscn")
