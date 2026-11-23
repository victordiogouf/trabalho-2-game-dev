extends Control

@export var velocidade_rolagem: float = 25.0
@onready var texto_creditos = $TextoCreditos
@onready var mensagem_vitoria = $MensagemVitoria

var rolando: bool = false

func _ready() -> void:
	# 1. Esconde os créditos e mostra apenas a frase de vitória no início
	texto_creditos.visible = false
	mensagem_vitoria.visible = true
	
	# 2. Mantém a frase de vitória na tela por 6 segundos
	await get_tree().create_timer(6.0).timeout
	
	# 3. Troca: esconde a frase, mostra os créditos e libera a rolagem
	mensagem_vitoria.visible = false
	texto_creditos.visible = true
	rolando = true

func _process(delta: float) -> void:
	if not rolando:
		return
		
	texto_creditos.position.y -= velocidade_rolagem * delta
	
	# Quando o texto inteiro passar do topo da tela, volta para o menu
	if texto_creditos.position.y + texto_creditos.size.y < 0:
		voltar_para_menu()

func _on_botao_voltar_pressed() -> void:
	voltar_para_menu()

func voltar_para_menu() -> void:
	get_tree().change_scene_to_file("res://tela_inicial_ui/tela_inicial.tscn")
