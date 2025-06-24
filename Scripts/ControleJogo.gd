class_name ControleJogo extends Control

const TAMANHO_GRID : Vector2i = Vector2i(10, 10)

enum MOTIVO_DERROTA {
	MOVIMENTO,
	VIDA
}
@export var configuracao_inicial : InformacaoPartida
@export var configuracao_atual : InformacaoPartida
@export var celula_prefab : PackedScene
@export var grid : GridContainer
@export var ui_jogo : UiJogo

# Variaveis de controle do jogo
var ultimo_tesouro_escondido : Vector2i
var ultima_celula_pressionada : Celula = null

func _ready() -> void:
	call_deferred("comecar_partida")


static func pega_posicao_aleatoria() -> Vector2i:
	return Vector2i(
		randi_range(0, TAMANHO_GRID.x - 1),
		randi_range(0, TAMANHO_GRID.y - 1))


func cria_conjunto_armadilhas(tesouro : Vector2i) -> Dictionary:
	var armadilhas = Dictionary()	# GDScript nao tem set, usei dictionary ignorando o value
	armadilhas.set(tesouro, null)
	while len(armadilhas) < (configuracao_inicial.armadilhas + 1):
		var posicao = pega_posicao_aleatoria()
		if posicao in armadilhas:
			continue
		armadilhas.set(posicao, null)
	return armadilhas


static func calcula_passos(posicao1 : Vector2i, posicao2 : Vector2i) -> int:
	posicao1 = (posicao1-posicao2).abs()
	return posicao1.x + posicao1.y


static func calcula_angulo(posicao : Vector2, tesouro : Vector2) -> float:
	var delta = tesouro - posicao
	var angulo = atan2(delta.x, delta.y)
	return rad_to_deg(angulo) + 90	# resultado baseado numa seta apontando pra cima


func comecar_partida() -> void:
	randomize()
	var tesouro := pega_posicao_aleatoria()
	ultimo_tesouro_escondido = tesouro
	var armadilhas := cria_conjunto_armadilhas(tesouro)

	for x in range(TAMANHO_GRID.x):
		for y in range(TAMANHO_GRID.y):
			var posicao := Vector2i(x, y)
			var celula := celula_prefab.instantiate() as Celula
			var tipo := Celula.TIPO.PISTA
			var passos := 0
			if posicao == tesouro:
				tipo = Celula.TIPO.TESOURO
			elif posicao in armadilhas:
				tipo = Celula.TIPO.ARMADILHA
			else:
				passos = calcula_passos(posicao, tesouro)
			celula.configurar(posicao, tipo, passos)
			celula.pressionada.connect(celula_pressionada)
			grid.add_child(celula)
	configuracao_atual = configuracao_inicial.duplicate()
	ui_jogo.atualizar_textos(configuracao_atual, configuracao_inicial.bussolas > 0)
	ui_jogo.travar_fundo(false)
	ui_jogo.ativar_bussola(false)


func limpar_grid() -> void:
	for i in range(grid.get_child_count()):
		grid.get_child(i).queue_free()


func celula_pressionada(celula : Celula) -> void:
	match celula.tipo:
		Celula.TIPO.PISTA:
			# nao precisa fazer nada, a Celula resolve
			pass
		Celula.TIPO.ARMADILHA:
			configuracao_atual.vidas -= 1
			configuracao_atual.armadilhas -= 1
			# condicao derrota
			if configuracao_atual.vidas <= 0:
				perdeu(MOTIVO_DERROTA.VIDA)
		Celula.TIPO.TESOURO:
			# condicao vitoria
			ganhou()
			return

	configuracao_atual.movimentos -= 1
	# condicao derrota
	if configuracao_atual.movimentos <= 0:
		perdeu(MOTIVO_DERROTA.MOVIMENTO)
		return

	ui_jogo.atualizar_textos(configuracao_atual, configuracao_inicial.bussolas > 0)
	ultima_celula_pressionada = celula
	if configuracao_atual.bussolas > 0:
		ui_jogo.ativar_bussola()


func mostra_tudo() -> void:
	for i in range(grid.get_child_count()):
		var celula := grid.get_child(i) as Celula
		celula.mostrar_icone()


func ganhou() -> void:
	ui_jogo.travar_fundo()
	mostra_tudo()
	await get_tree().create_timer(2).timeout
	ui_jogo.banner_fim_partida.mostra_vitoria()



func perdeu(motivo : MOTIVO_DERROTA) -> void:
	ui_jogo.travar_fundo()
	mostra_tudo()
	await get_tree().create_timer(2).timeout
	ui_jogo.banner_fim_partida.mostra_derrota(motivo)


func quando_pedido_recomecar(nova_configuracao : InformacaoPartida = null) -> void:
	ui_jogo.banner_fim_partida.hide()
	ui_jogo.painel_configuracao.hide()
	limpar_grid()
	if nova_configuracao != null:
		configuracao_inicial = nova_configuracao
	comecar_partida()


func quando_pedido_bussola() -> void:
	# condições para não ativar a bussola
	if configuracao_atual.bussolas <= 0 \
		|| ultima_celula_pressionada == null \
		|| ultima_celula_pressionada.tipo != Celula.TIPO.PISTA \
		|| ultima_celula_pressionada.esta_bussola_ativa:
		return

	ultima_celula_pressionada.ativar_bussola(calcula_angulo(ultima_celula_pressionada.posicao_grid, ultimo_tesouro_escondido))
	configuracao_atual.bussolas -= 1
	ui_jogo.atualizar_textos(configuracao_atual, configuracao_inicial.bussolas > 0)
	if configuracao_atual.bussolas <= 0:
		ui_jogo.ativar_bussola(false)
