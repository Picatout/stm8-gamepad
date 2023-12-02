# Tutoriel NTSC 

Ceci est un tutoriel qui montre comment générer un signal composite selon le standard NTSC monochrome sur un petit MCU 8 bits. Pour ce tutoriel je vais m'en tenir au signal monochrome. Notez que ces informatitions s'applique aussi au standard PAL monochrome, seul les paramètres sont différents entre ces 2 standards et on peut donc sans modifier le programme passer d'un standard à l'autre simplement en changeant la valeur des constantes de paramètres.

Pour ce tutoriel je vais utilisé un MCU  STM8S103F3M qui se présente dans un boitier SOIC-20. Il suffit donc de le souder sur un adapteur DIP-20 afin de l'utiliser sur une plaquette d'expérimentation sans soudure.

## Caractéristiques

Le **STM8S103F3 dispose de 1024 octets de mémoire RAM.  On réserve la page 0 (0..128) pour les variables système et la fin de la RAM de 896..1023 pour la pile.  Ce qui nous laisse  768 octets à utilisé comme tampon mémoire vidéo. Ça nous permettre d'avoir une résolution de 96x64 pixels. Suffisant pour un jeu simple comme Tétris.

