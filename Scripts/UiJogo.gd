extends Control
class_name UiJogo

@export var texto_vidas : Label
@export var texto_movimentos : Label
@export var texto_armadilhas : Label
@export var banner_fim_partida : BannerFimPartida
@export var painel_configuracao : PainelConfiguracao
@export var trava_tela : Control

signal pedido_recomecar(nova_configuracao : InformacaoPartida)


func atualizar_textos(informacoes : InformacaoPartida) -> void:
	texto_vidas.text = str(informacoes.vidas)
	texto_movimentos.text = str(informacoes.movimentos)
	texto_armadilhas.text = str(informacoes.armadilhas)


func quando_pedido_recomecar(nova_configuracao : InformacaoPartida):
	pedido_recomecar.emit(nova_configuracao)


func quando_botao_recomecar_pressionado() -> void:
	painel_configuracao.mostrar()


func travar_fundo(ativa : bool = true) -> void:
	trava_tela.visible = ativa
