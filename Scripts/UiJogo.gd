class_name UiJogo extends Control

@export var texto_vidas : Label
@export var texto_movimentos : Label
@export var texto_armadilhas : Label
@export var texto_bussolas : Label
@export var bussola_container : HBoxContainer
@export var icone_bussola : TextureRect
@export var botao_bussola : Button
@export var banner_fim_partida : BannerFimPartida
@export var painel_configuracao : PainelConfiguracao
@export var trava_tela : Control

signal pedido_recomecar(nova_configuracao : InformacaoPartida)
signal pedido_bussola()


func atualizar_textos(informacoes : InformacaoPartida, mostrar_bussola : bool) -> void:
	texto_vidas.text = str(informacoes.vidas)
	texto_movimentos.text = str(informacoes.movimentos)
	texto_armadilhas.text = str(informacoes.armadilhas)
	if mostrar_bussola:
		texto_bussolas.text = str(informacoes.bussolas)
		bussola_container.visible = true
		icone_bussola.visible = true
		botao_bussola.visible = true
	else:
		bussola_container.visible = false
		icone_bussola.visible = false
		botao_bussola.visible = false


func quando_pedido_recomecar(nova_configuracao : InformacaoPartida):
	pedido_recomecar.emit(nova_configuracao)


func quando_botao_recomecar_pressionado() -> void:
	painel_configuracao.mostrar()


func quando_botao_bussola_pressionado() -> void:
	pedido_bussola.emit()


func travar_fundo(ativa : bool = true) -> void:
	trava_tela.visible = ativa


func mostrar_vitoria() -> void:
	pass


func ativar_bussola(ativa : bool = true) -> void:
	botao_bussola.disabled = not ativa
