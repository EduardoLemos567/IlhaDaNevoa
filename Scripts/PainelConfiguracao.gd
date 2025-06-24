extends ColorRect
class_name PainelConfiguracao

@export var configuracao_inicial : InformacaoPartida
@export var entrada_vidas : SpinBox
@export var entrada_movimentos : SpinBox
@export var entrada_armadilhas : SpinBox


signal pedido_recomecar(nova_configuracao : InformacaoPartida)


func _ready() -> void:
	hide()


func ler_entradas() -> InformacaoPartida:
	var nova_configuracao = InformacaoPartida.new()
	nova_configuracao.vidas = entrada_vidas.value
	nova_configuracao.movimentos = entrada_movimentos.value
	nova_configuracao.armadilhas = entrada_armadilhas.value
	return nova_configuracao


func escrever_entradas(informacoes : InformacaoPartida) -> void:
	entrada_vidas.value = informacoes.vidas
	entrada_movimentos.value = informacoes.movimentos
	entrada_armadilhas.value = informacoes.armadilhas


func mostrar(informacoes : InformacaoPartida = null) -> void:
	if informacoes == null:
		informacoes = configuracao_inicial
	escrever_entradas(informacoes)
	show()


func quando_recomecar_pressionado() -> void:
	var nova_configuracao = InformacaoPartida.new()
	nova_configuracao.vidas = entrada_vidas.value
	nova_configuracao.movimentos = entrada_movimentos.value
	nova_configuracao.armadilhas = entrada_armadilhas.value

	pedido_recomecar.emit(nova_configuracao)


func quando_vidas_alteradas(value : float) -> void:
	entrada_vidas.suffix = "vida" if value == 1. else "vidas"


func quando_movimentos_alterados(value : float) -> void:
	entrada_movimentos.suffix = "movimento" if value == 1. else "movimentos"


func quando_armadilhas_alteradas(value : float) -> void:
	print('alterou armadilhas')
	entrada_armadilhas.suffix = "armadilha" if value == 1. else "armadilhas"
