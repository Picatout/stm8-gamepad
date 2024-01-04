# interface d'application 

Ce programme décrit les fonctions à utiliser pour programmer des applications pour la console STM8-GAMEPAD.

Les applications doivent-être écrites en assembleur car les paramètres des fonctions sont passés dans les registres **A**,**X** et **Y**  et non sur la pile comme le langage **C** le fait.

Il y a toujours moyen d'écrire les applications en **C** mais en utilisant l'assembleur inline pour charger les registres et faire l'appel vers la sous-routine.


## <a id="index">index</a>

* <a href="#son">SON</a>
* <a href="#keypad">KEYPAD</a>
* <a href="#affichage">AFFICHAGE</a>
* <a href="#divers">DIVERS</a>

##  <a id="son">SON</a> 

* **beep** Cette sous-routine n'accepte aucun paramètre. Elle génère un son de 1000 Hertz pour une durée de 8/60ième de seconde (i.e. ~133msec).
<hr>

* **tone** génère une tonalité de fréquence spécifiée dans le registre **X** et de durée en 60ième de seconde spécifiée dans le registre **A**.
    * **A**   durée du son en 60ìème de seconde. 
    * **X**   fréquence en hertz.
<hr>

* **tune**  Joue une séquence de notes le registre **Y** indique l'adresse de la séquence. 
    * **Y**  adresse de la mélodie. Il s'agit d'une liste formé de la fréquence suivit de la durée. La liste doit se terminé par {0,0}. La macro **_note f,d** permet de contruire cette liste simplement. 
    * une fréquence nulle indique une pause.

```
	.macro _note  f,d 
	.word f 
	.byte d 
	.endm 

play_scale: 
    ldw y,#gamme 
    call tune 
    ret 

gamme: 
    _note 523,10  ; do 
    _note 554,10  ; do#
    _note 587,10  ; ré 
    _note 622,10  ; ré#
    _note 659,10  ; mi 
    _note 698,10  ; fa 
    _note 740,10  ; fa# 
    _note 784,10  ; sol
    _note 831,10  ; sol#
    _note 880,10  ; la 
    _note 932,10  ; la# 
    _note 988,10  ; si 
    _note 0,0     ; end  
```
<hr>

* **noise**  Produit un bruit blanc d'une durée indiquée par le paramètre passé dans **A**.
    * **A** Durée en 60ième de seconde.

<a href="#index">index</a>

##  <a id="keypad">KEYPAD</a> 

* **keypad_input**  Retourne l'état des 6 boutons dans le registre **A**. Cette lecture n'est pas filtrée pour les rebonds des commutateurs. Les constantes suivantes sont définies pour identifier les boutons.
    * **BTN_LEFT=1**
    * **BTN_DOWN=2**
    * **BTN_RIGHT=4**
    * **BTN_UP=8** 
    * **BTN_B=16**
    * **BTN_A=32**

<hr>

* **read_keypad** Lecture du keypad avec filtrage antirebond. L'état des boutons est retournée dans le registre **A**. Exemple d'utilisation:
```
;--------------------------
; read keypad 
; LEFT turn left 
; RIGHT turn right 
; UP increase speed 
; DOWN decreas speed 
;--------------------------
    KPAD=1
user_input:
    push #0 
    call read_keypad
    jreq 8$ 
    ld (KPAD,sp),a  
    ld a,#BTN_LEFT 
    and a,(KPAD,sp)
    jreq 2$ 
    call rotate_head
    jra 6$
2$: ld a,#BTN_RIGHT 
    and a,(KPAD,sp)
    jreq 3$ 
    call rotate_head
    jra 6$ 
3$:
    ld a,#BTN_UP 
    and a,(KPAD,sp)
    jreq 4$
    ld a,#MIN_SPEED 
    cp a,speed 
    jreq 6$  
    _decz speed
    call prt_info 
    jra 6$ 
4$: ld a,#BTN_DOWN 
    and a,(KPAD,sp)
    jreq 6$
    ld a,#MAX_SPEED 
    cp a,speed 
    jreq 6$
    _incz speed
    call prt_info  
6$:
    ldw x,#10
    call wait_key_release
8$:
    _drop 1 
    ret 
```
<hr>

* **wait_key** Attend qu'un bouton soit enfoncé et retourne l'état dans le registre **A**. 
<hr>

* **wait _key_release** Attend que tous les boutons soient relâchés.  

<a href="#index">index</a>

##  <a id="affichage">AFFICHAGE</a> 

* **tv_cls**  Efface l'affichage au complet.
<hr>

* **set_pixel** Allume un pixel. Les paramètres sont passés dans le registre **X**.
    * **XL** coordonnée X du pixel {0..HRES-1}.
    * **XH** coordonnée Y du pixel {0..VRES-1}. 
<hr>

* **reset_pixel** Éteint un pixel. Les paramètres sont passés dans le registre **X**.
    * **XL** coordonnée X du pixel {0..HRES-1}.
    * **XH** coordonnée Y du pixel {0..VRES-1}.
<hr>

* **invert_pixel** Inverse l'état du pixel. Les paramètres sont passés dans le registre **X**.
    * **XL** coordonnée X du pixel {0..HRES-1}.
    * **XH** coordonnée Y du pixel {0..VRES-1}.
<hr>

* **scroll_text_up**  Décale l'affichage texte vers le haut d'une ligne et efface la dernière ligne.
<hr>

* **crlf**  Carriage return line feed. Renvoie le curseur texte au début de la ligne suivante.
<hr>

* **cursor_right** Déplace le curseur texte vers la droite d'un caractère.
<hr>

* **tv_putc** Affiche le caractère qui est dans le registre **A** à la position 
courante du curseur texte. Avance le curseur à la position suivante.
    * **A**  caractère à affiché.
<hr>

* **tv_puts** Affiche une chaîne ce caractères ASCII zéro terminée à la position actuelle du curseur.
    * **Y** adresse de la chaîne ASCII. 
<hr>

* **put_uint16**  Affiche à la position du curseur la valeur entière non signée contenue dans le registre **X**.
    * **X** Entier à afficher.
<hr>

* **line**  Trace une ligne droite entre les coordonnées **{x0,y0}** et **{x1,y1}** excluant ce dernier point.
    * **XL** coordonnée **x0**
    * **XH** coordonnée **x1**
    * **YL** coordonnée **y0** 
    * **YH** coordonnée **y1**
<hr>

* **put_sprite** Affiche un petit graphique d'au maximum 8 pixels en largeur et un maximum de **VRES** pixels en hauteur. Chaque rangé du sprite est représenté par un seul octet et le sprite comprend autant d'octets que sa hauteur. La fonction logique **XOR** est utilisée pour afficher les sprites. Cette méthode permet de détecter automatiquement les collisions. La fonction retourne une valeur dand **A** et ajuste le drapeau **Z** en fonction de cette valeur.

Entrées:
* **A** hauteur du sprite 
* **XL** coordonnée x à gauche du sprite.
* **XH** coordonnnée y haut du sprite.
* **Y**  adresse du sprite 

Sorties:
* **A**  différent de zéro s'il y a eu collision 
* **Z**  **0** s'il y a eu collision.
<hr>

* **scroll_up**  Glisse les rangées de l'intervalle [de...jusqu'à[ vers le haut d'une rangée et efface les pixels de la dernière rangée.
    * **XL** *de* 
    * **XH** *jusqu'à* (exclue) 
<hr>

* **scroll_down** Glisse les rangées de l'intervalle [de...jusqu'à[ vers le bas d'une rangée et efface les pixels de la première rangée.
    * **XL** *de* 
    * **XH** *jusqu'à* (exclue)
<hr>

* **scroll_left** Glisse vers la gauche de 4 pixels l'intervalle de rangées [de...jusqu'à[ et efface les pixels à droite de l'écran.
    * **XL** *de* 
    * **XH** *jusqu'à* (exclue)
<hr>

* **scroll_right** Glisse vers la droite de 4 pixels l'intervalle de rangées [de...jusqu'à[ et efface les pixels à gauche de l'écran.
    * **XL** *de* 
    * **XH** *jusqu'à* (exclue)
<hr>

<a href="#index">index</a>

## <a id="divers">DIVERS</a>

* **pause**   Suspend l'exécution pour une durée déterminée par la valeur passée dand **A**.
    * **A** durée de la pause en 60ième de seconde.

<a href="#index">index</a>

