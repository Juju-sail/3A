/PROG  AAAJ_L123
/ATTR
OWNER		= MNEDITOR; 
COMMENT		= "";
PROG_SIZE	= 664;
CREATE		= DATE 20-12-01  TIME 21:10:40;
MODIFIED	= DATE 20-12-01  TIME 21:15:10;
FILE_NAME	= AAAJ_L12;
VERSION		= 0;
LINE_COUNT	= 27;
MEMORY_SIZE	= 1076;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/APPL
/MN
	/ On defini l'espace de travail
   1:  UFRAME_NUM=2 ; / Utilisation de l'userframe numero 2
   2:  UTOOL_NUM=2 ; / Utilisation de l'usertool numero 2 -> definition de notre environnement de travail
   / Definition des variables globales
   3:  PR[112]=PR[117]    ; / Nous definissons une variable de travail (112). On lui assigne la valeur de la variable 117 que nous ne devons surtout pas écraser !
   4:  PR[111]=PR[115]    ; / Idem avec 111 et 115. Le PR[111] defini notre rangée de travail (A->D / E->G / H->I). On commence ici avec la rangée A->D.  
   5:J PR[110] 50% CNT0    ; / Pour travailler nous avons besoin d'un point de depart (ici notre PR[110]) qui est une mesure de sécurité. Nous avons choisi une CTN0 car nous voulons qu'il passe réellement sur le point, mais sans marquer d'arret complet. 
   / Conditions de deplacements
   6:  FOR R[160]=0 TO 8 ; / Notre R[160] est notre index de boucle for. Il s'incrementera de 0 à 8 soit de A à I.
   7:  IF R[160]<>4,JMP LBL[5] ; / Si nous travaillons sur la piece E on reste sur la rangée A->D.
   8:  PR[111]=PR[120]    ; / Sinon, on change la valeur de notre variable de travail pour passer à la rangée superieure (E->G).
   9:  LBL[5] ;
  10:  IF R[160]<>7,JMP LBL[6] ; / Si nous travaillons sur la piece H on reste sur la rangée E->G.
  11:  PR[111]=PR[121]    ; / Sinon, on change la valeur de notre variable de travail pour passer à la rangée superieure (H->I).
  12:  LBL[6] ;
  13:  IF R[160]=0,JMP LBL[7] ; / Si nous travaillons sur la piece A on reste sur la rangée H->I.
  14:  PR[111]=PR[111]+PR[114]    ; / Ici on attribut la position de notre variable de travail pour passer de lettre en lettre sur une même rangée (par exemple de A->B) (nous restons au dessus de ces dernieres par sécurité)
  15:  LBL[7] ;
  / Deplacement et saisi de la piece
  16:J PR[111] 50% CNT0    ; / On se rend sur notre variable de travail (c'est a dire au dessus d'une lettre)
  17:J PR[111] 50% CNT0 Offset,PR[113]    ; / On descend sur la piece
  18:  CALL HAND_CLOSE    ; / On appelle le programme de fermeture de pince pour attraper la pièce
  19:J PR[111] 50% CNT20    ; / On remonte avec la piece "en main". 
  / Empilement les pieces
  20:  IF R[160]=0,JMP LBL[1] ;  / Si nous bougeons la piece A, on commencera la pile au sol
  21:  PR[112]=PR[112]+PR[116]    ; / Sinon on attribut la position de notre variable de travail pour modifier la hauteur de la pile selon la pièce agripée.
  22:  LBL[1] ;
  23:J PR[112] 50% CNT20    ; / On se deplace vers le point M (lieu de formation de la pile) à une hauteur adaptée à la piece en deplacement
  24:J PR[112] 50% CNT0 Offset,PR[113]    ; / On pose la piece délicatement
  25:  CALL HAND_OPEN    ; / On appelle le programme d'ouverture de la pince afin de lacher notre piece
  26:J PR[112] 50% CNT20    ; / On remonte pour ne pas tout faire tomber en repartant chercher la pièce suivante (mesure de sécurité)
  27:  ENDFOR ;
/POS
/END


