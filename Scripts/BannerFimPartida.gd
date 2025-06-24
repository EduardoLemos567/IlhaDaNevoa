extends Control
class_name BannerFimPartida

@export var texto_vitoria : Label
@export var caixa_derrota : VBoxContainer
@export var texto_sem_vidas : Label
@export var texto_sem_movimentos : Label

func _ready() -> void:
	hide()


func mostra_vitoria() -> void:
	caixa_derrota.hide()
	texto_vitoria.show()
	show()


func mostra_derrota(motivo : ControleJogo.MOTIVO_DERROTA) -> void:
	match motivo:
		ControleJogo.MOTIVO_DERROTA.MOVIMENTO:
			texto_sem_vidas.hide()
			texto_sem_movimentos.show()
		ControleJogo.MOTIVO_DERROTA.VIDA:
			texto_sem_movimentos.hide()
			texto_sem_vidas.show()
	texto_vitoria.hide()
	caixa_derrota.show()
	show()
