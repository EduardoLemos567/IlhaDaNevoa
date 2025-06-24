class_name Celula extends Control

enum TIPO {
	PISTA,
	TESOURO,
	ARMADILHA,
}

@export var posicao_grid : Vector2i
@export var tipo : TIPO
@export var botao : TextureButton
@export var icone_armadilha : TextureRect
@export var icone_tesouro : TextureRect
@export var icone_pista : TextureRect
@export var texto_pista : Label
@export var seta_bussola : TextureRect

var esta_bussola_ativa: bool:
	get:
		return seta_bussola.visible

signal pressionada(celula : Celula)


func configurar(nova_posicao_grid : Vector2i, novo_tipo : TIPO, numero_passos : int = 0) -> void:
	posicao_grid = nova_posicao_grid
	tipo = novo_tipo
	icone_armadilha.hide()
	icone_tesouro.hide()
	icone_pista.hide()
	match(tipo):
		TIPO.TESOURO:
			icone_tesouro.show()
		TIPO.ARMADILHA:
			icone_armadilha.show()
		TIPO.PISTA:
			seta_bussola.hide()
			icone_pista.show()
			texto_pista.text = str(numero_passos)
	botao.show()
	name = "{0} : {1}".format([posicao_grid, tipo])


func ativar_bussola(angulo : float) -> void:
	# a textura da seta aponta pra esquerda, deveria apontar pra cima
	# consertamos com uma rotacao +90 graus.
	seta_bussola.rotation_degrees = angulo + 90
	seta_bussola.show()


func quando_botao_pressionado() -> void:
	mostrar_icone()
	pressionada.emit(self)


func mostrar_icone() -> void:
	botao.hide()
