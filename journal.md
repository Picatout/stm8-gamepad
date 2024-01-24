### 2024-01-24

* Ajout de l'option **RANDOM FILL** au menu de [conway.asm](conway.asm).

* Travail sur [fall.asm](fall.asm) pour ajusté la vitesse: 
    * **fall_dly = INIT_DLY-fall_score/1000**

* Corrigé jeux pour la nouvelle interface de *line* 

* Modifié l'interface de la routine *line*.
* **line**  Trace une ligne droite entre les coordonnées **{x0,y0}** et **{x1,y1}** excluant ce dernier point.
    * **XL** coordonnée **x0** [0..HRES[
    * **XH** coordonnée **y0** [0..VRES[
    * **YL** coordonnée **x1**  [0..HRES[
    * **YH** coordonnée **y1** [0..VRES[

### 2024-01-23

* Modifié l'interface de la routine *rectangle*.
* **rectangle** Dessine un rectangle dont les coordonnées des coins supérieur gauche et inférieur droit sont données.
    * **X**  coordonnées coin supérieur gauche,
        * **XH**  ycoord y0 [0..VRES[   
        * **XL**  xcoord x0 [0..HRES[
    * **Y** coordonnées coin inférieur droit,    
        * **YH**  ycoord y1 [0..VRES[ 
        * **YL**  xcoord x1 [0..HRES[
        
* fall presque complété, reste à ajouté un niveau de difficulté par augmentation de la vitesse en fonction du pointage.

* Modifié routine *tune* dans [sound.asm](sound.asm) pour que la mélodie puisse être interrompue sans délais.

* Modification de la routine kpad_input. Maintenant gérée par une interruption externe. L'état des boutons est enregistré dans la variable *keyin*.
    * Ajout de la variable *keyin*. 

* Ajout d'indicateurs booléens dans la variable *flags* 
    * **F_ST_ABORT**  mis à 1 par la routine *tune* interrompt la mélodie si un bouton du keypad est enfoncé.
    * **F_GT_ABORT**  mis à 1 par une routine interrompt *pause* si un bouton du keypad est enfoncé.

### 2024-01-21

* Trvail sur [fall.asm](fall.asm).

* Corrigé bogue dans routine *again* du fichier [app.asm](app.asm).

### 2024-01-20

* Trvail sur [fall.asm](fall.asm).

* Ajout de la routine *strlen* dans [display.asm](display.asm).

### 2024-01-19 

* Trvail sur [fall.asm](fall.asm) [display.asm](display.asm)
    * **rectangle**   Dessine un rectangle. 
        * **XL**  coordonnée gauche 
        * **XH**  coordonnée haut 
        * **YL**  largeur 
        * **YH**  hauteur 

* Modification de *rectangle* dans 

### 2024-01-18

* Correction mineure à la routine *again* dans le fichier [app.asm](app.asm). Version V1.2R1

### 2024-01-17

* version **V1.2R0**. 

* Jeu Cadena Débogué.

* Ajout de 2 routines dans [display.asm](display.asm)
    * **clr_text_line**  efface une ligne de texte.
        * **A**  contient no. de ligne  à effacé. 

    * **rectangle**   Dessine un rectangle. 
        * **XL**  coordonnée X0 
        * **XH**  coordonnée X1 
        * **YL**  coordonnée Y0 
        * **YH**  coordonnée Y1

* Travail sur jeu [cadena.asm](cadena.asm).

* Modifié routines de lecture du  keypad. 

### 2024-01-16

* Travail sur jeu [cadena.asm](cadena.asm).

### 2024-01-15

* Travail sur jeu [cadena.asm](cadena.asm).

### 2024-01-14 

**A FAIRE**  **eval_try** aglorithme complexe.

* Travail sur jeu [cadena.asm](cadena.asm).

### 2024-01-13

* Travail sur jeu [cadena.asm](cadena.asm).
* Ajout de la routine *again*  dans [app.asm](app.asm).

### 2024-01-12

* Travail sur un nouveau jeu appellé *CADENA*. Il s'agit d'une variante du jeu mastermind. Un nombre aléatoire de 4 chiffres est généré et le joueur doit deviner la combinaison en un nombre minimum de d'essais. 
    * Si 1 ou plusieurs chiffres qu'il a choisi font parti de la combinaison un __*__ apparaît à droite de la rangée.
    * Si 1 ou plusieurs chiffres apparaît en bonne position un **+** apparaît à droite de la rangée.
    * Si aucun chiffre ne fait parti de la combinaison aune indication n'est donnée. 
Le joueur dispose d'un maximum de 12 essais.


### 2024-01-11

* Travail sur [fall.asm](fall.asm).
* Ajouter routines *roll_up* et *scroll_text* dans [display.asm](display.asm).
* Nettoyage de [conway.asm](conway.asm).

### 2024-01-10

* Ajouter d'un menu avec des configurations prédéfinies dans [conway.asm](conway.asm). 
* 11:49  Complété [conway.asm](conway.asm).

### 2024-01-06

* Recommencé à travailler sur [conway.asm](conway.asm).

* Complété travail sur splash screen.

### 2024-01-05


* Travail sur [splash.asm](splash.asm).

* Écrire de l'outils de conversion de bitmaps en fichier asm pour le projet. [bmp_2_asm.c](tools/bmp_2_asm.c).

* Travail sur jeu [conway.asm]

* Déplacer le tampon vidéo *tv_buffer* vers la fin de la mémoire RAM sous la pile pour donné plus de mémoire aux applications. 
* Les variables système sont déplacé à la fin de la page 0.

### 2023-12-29

* Ajout de la sous-routine **tune** dans hardware_init.asm 

* Travail sur snake.asm
    * Ajout chronomètre TIME OUT avec bargraph.
    * Ajuster dimension de l'arène pur que largeur et hauteur soit un multiple de SNAKE__SPRITE_WIDTH et SNAKE_SPRITE_HEIGHT.

### 2023-12-28

* Travail sur snake.asm 
    * Ajout du contrôle de vitesse du serpent avec les touvhe HAUT|BAS.
    * Modification affichage score.
    * Ajout BEEP lorsque le serpent avale la souris.
    * Ajout NOISE quand le serpent meure.

### 2023-12-27

* Éliminer TIMER4 pour les délais utilise à la place l'interruption de TIMER1. La granularité tombe à 1/60 de seconde mais la sortie vidéo est plus propre.

* Augmenté delais pour TIMER4 à 2msec. Supprimé modulo 10 pour game_timer et sound_timer.

### 2023-12-26

* Modification prototype 1 pour que les boutons du keypad sur le même port que pour le prototype 2.

### 2023-12-25

* Fabrication d'un nouveau prototype du gamepad utilisant une carte NUCLEO-8S207K8
* Ajout de tas de merde au jeu snake.asm 
* Ajout feuille dans projet KiCAD pour version NUCLEO-8S207K8.

### 2023-12-24

* Travail sur display.asm 
    * Ajout de scroll_up 
    * Ajout de scroll_down 
    * Ajout de scroll_left 
    * Ajout de scroll_right 
    * Renommé move_up en move_text_up 
    * Ajout des sous-routines move_up et fill dans app.asm 
    
### 2023-12-23

* Travail sur jeu snake.asm 

### 2023-12-22

* Modification du circuit video output.
* Commutation audio_out et BTN_A. Bouton maintenant sur PD3 et audio_out sur PD0 TIM3_CH2.
* Débogué tone. 
* Corrigé draw_wall dans snake.asm

### 2023-12-21

* Assemblage du nouveau circuit et test préliminiaires.

### 2023-12-20

* Création d'un nouveau circuit pour le mcu **STM8S207K8T**. Résolution vidéo augmenté à 200x192 pixels.

### 2023-12-17

* Début travail sur fall.asm 

### 2023-12-15

* Complété mécanique des collisions.
* Ajout message de fin de partie avec pointage et pointage maximum et prompt pour nouvelle partie ou quitter.
* Ajout du menu jeux.

### 2023-12-13

* Travail sur snake.asm.
    * AJout de la nourriture
    * Travail sur les collisions

### 2023-12-12

* Travail sur snake.asm. 
    * Mécanique de déplacement du serpent déboguée.
    * Lecture du keypad déboguée.

### 2023-12-11

* Travail sur snake.asm

### 2023-12-10

* Test keypad complété.
* Modification à tvout.asm
* Retravaillé certains caractères de la police font_6x8.asm

### 2023-12-09

* Modification aux routines *pixel_addr* et *bit_mask* pour élimiter 2 instructions dans *pixel_addr*.
* Réécriture de la routine *tv_putc* pour améliorer la rapidité. Gain de 6x.
* Ajout de la routine *read_keypad*.

### 2023-12-04

* Enlevé monitor.asm du projet
* Ajout de des sous-routines *crlf*,*cursor_right*,*scrollup* et  *put_uint16*.
* Ajout de la routine *put_sprite*

### 2023-12-03

* Complété le circuit en ajoutant le cristal 16Mhz 
* Déboguer tvout.asm 
* Ajout de fonctions dans display.asm
* Ajout xor_prng.asm 
* corrigé bogue dans pixel_addr
* Ajout de font_small_hex.asm

### 2023-12-02

* Démarrage du projet 

* Conception du circuit électronique comprenant:
    * Sortie vidéo NTSC monochrome 96x64 pixels 
    * Un petit haut-parleur pour générer des tonalités
    * Un keypad de 6 touches 
    * Alimentation par 3 piles AAA 
    