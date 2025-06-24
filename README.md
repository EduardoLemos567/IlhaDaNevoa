# IlhaDaNevoa

## Visão Geral

IlhaDaNevoa é um jogo de lógica e estratégia desenvolvido em Godot, onde o jogador deve encontrar um tesouro escondido em uma grade (grid), evitando armadilhas e utilizando recursos limitados como vidas, movimentos e bússolas. O projeto foi estruturado para ser modular, facilitando a manutenção e expansão de funcionalidades.

## Estrutura do Projeto

O projeto está organizado em duas principais pastas:

- **Scripts**: Contém toda a lógica do jogo em GDScript.
- **Prefabs**: Contém as cenas (tscn) reutilizáveis, como UI, células do grid, banners e painéis.

### Scripts Principais

- **ControleJogo.gd**  
  Gerencia o fluxo principal do jogo: inicialização, criação do grid, sorteio do tesouro e armadilhas, controle de estados (vitória/derrota), e atualização da interface. Utiliza enums para motivos de derrota e métodos estáticos para cálculos de posição e ângulo da bússola.

- **Celula.gd**  
  Representa cada célula do grid. Pode ser pista, armadilha ou tesouro. Gerencia sua própria exibição e interação, incluindo a ativação da seta da bússola.

- **UiJogo.gd**  
  Controla a interface principal do usuário, exibindo vidas, movimentos, armadilhas e bússolas. Gerencia a visibilidade e interatividade dos botões e banners, além de emitir sinais para reiniciar ou usar a bússola.

- **PainelConfiguracao.gd**  
  Permite ao jogador configurar os parâmetros iniciais da partida (vidas, movimentos, armadilhas, bússolas) antes de começar ou reiniciar o jogo. Utiliza SpinBox para entradas e atualiza os sufixos dinamicamente conforme o valor.

- **BannerFimPartida.gd**  
  Exibe banners de vitória ou derrota ao final da partida, mostrando mensagens específicas para cada motivo de derrota.

- **InformacaoPartida.gd**  
  Estrutura de dados para armazenar as configurações e o estado atual da partida (vidas, movimentos, armadilhas, bússolas).

### Prefabs (Cenas Godot)

- **Celula.tscn**  
  Representa uma célula do grid, com ícones e lógica para pista, armadilha e tesouro.

- **UiJogo.tscn**  
  Interface principal do jogo, com exibição de informações, botões de ação e banners.

- **PainelConfiguracao.tscn**  
  Painel para configuração dos parâmetros da partida.

- **BannerFimPartida.tscn**  
  Banner exibido ao final da partida, indicando vitória ou derrota.

- **BotaoRecomecar.tscn** e **BotaoBussola.tscn**  
  Botões estilizados reutilizados em diferentes partes da interface.

## Motivações de Implementação

- **Modularidade e Reutilização**  
  Cada elemento visual ou funcional foi isolado em um prefab ou script dedicado, facilitando a manutenção e a expansão do projeto.

- **Sinais e Exportação de Variáveis**  
  O uso de sinais (`signal`) permite comunicação desacoplada entre UI e lógica de jogo. Variáveis exportadas (`@export`) facilitam a ligação entre scripts e nós das cenas no editor Godot.

- **Separação de Lógica e Interface**  
  Scripts como `ControleJogo.gd` cuidam apenas da lógica, enquanto scripts de UI apenas exibem informações e capturam interações, promovendo clareza e testabilidade.

- **Feedback Visual Imediato**  
  O uso de banners, painéis e ícones coloridos proporciona feedback claro ao jogador sobre seu progresso e estado da partida.

- **Flexibilidade de Configuração**  
  O painel de configuração permite ajustar facilmente os parâmetros do jogo, tornando-o acessível para diferentes níveis de desafio.

## Como Jogar

1. Configure os parâmetros iniciais (vidas, movimentos, armadilhas, bússolas) no painel de configuração.
2. Clique nas células do grid para tentar encontrar o tesouro.
3. Evite armadilhas e administre seus movimentos e vidas.
4. Use a bússola para receber dicas de direção, se disponível.
5. O jogo termina em vitória ao encontrar o tesouro, ou derrota ao acabar vidas ou movimentos.

---

Este projeto foi estruturado para ser didático, modular e facilmente expansível, aproveitando os recursos do Godot Engine e boas práticas de programação

