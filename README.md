Português 🇧🇷
O código implementa um sistema de sorteio de recompensas para jogadores em um servidor de jogo. A lógica é a seguinte:

A função emP.checkPayment() verifica se o jogador possui uma ficha necessária para participar do sorteio.
Um número aleatório entre 1 e 100 é gerado para determinar o prêmio do jogador.
Com base no número sorteado, o jogador pode ganhar dinheiro, itens, veículos ou armas.
Uma thread é criada para fornecer ao jogador uma ficha a cada hora de jogo.
O jogador é notificado sobre o prêmio recebido.
Em suma, o código cria um sistema interativo que incentiva a participação dos jogadores, oferecendo-lhes a oportunidade de ganhar prêmios variados em um sorteio realizado periodicamente.

English 🇺🇸
The code implements a reward drawing system for players on a game server. The logic is as follows:

The emP.checkPayment() function verifies if the player has a necessary token to participate in the drawing.
A random number between 1 and 100 is generated to determine the player's prize.
Based on the drawn number, the player can win money, items, vehicles, or weapons.
A thread is created to provide the player with a token every hour of gameplay.
The player is notified about the received prize.
In summary, the code creates an interactive system that encourages player participation by offering them the chance to win various prizes in a periodically conducted drawing.
