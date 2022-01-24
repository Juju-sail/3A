#ifndef SUDOKU_FUNCTIONS_H
#define SUDOKU_FUNCTIONS_H

#include "sudoku_functions_correct.h"



/**
 * @brief copy_sudoku_exercice renvoie une copie du sudoku exercice passé en paramètre
 * @param from_data un pointer sur la structure qui sera copiée
 * @return un pointer sur la copie du sudoku exercice. allocation dynamique de memoire
 */
struct sudoku_exercice* copy_sudoku_exercice(struct sudoku_exercice* from_data);

/**
 * @brief init_matrice initialise une matrice en allouant dynamiquement de la mémoire, met toute la structure à 0
 * @return un pointer sur la matrice alouée dynamiquement
 */
struct matrice_possibility* init_matrice();

/**
 * @brief compute_matrice permet de remplir la matrice en fonction des différentes possibilité du sudoku exercice passé en paramètre
 * l'idee est parcourir toute la matrice et de crééer la liste des valeurs possible pour chaque emplacement
 * @param matrice la matrice que l'on va remplir
 * @param exerc le sudoku exercice contenant les informations de base
 * @return un entier qui ne sera pas utilisé
 */
int compute_matrice(struct matrice_possibility* matrice, struct sudoku_exercice *exerc);

/**
 * @brief compute_possibility coeur de resolution des sudokus. Cette fonction prend en paramètre la matrice des possibilités et recherche la première case
 * contenant plus d'un possibilités de valeurs. Une fois qu'elle l'a trouvée, et choisi une valeur qu'elle fixe à l'aide du current element de la structure mpl.
 * Une foix ce current element fixé, et vérifie si la valeur est possible considérant les regles s'appliquant aux ligne et aux colonnes dans un sudoku.
 * Si la valeur est possible, alors elle passe à la prochaine case ou il y a plusieurs valeurs possibles en s'appelant elle même.
 * Si la valeur n'est pas possible, alors elle passe a sa propre valeur possible suivante.
 * Si il n'y a plus de valeur suivante possible pour cette case, alors on remonte d'une case et on recommence avec une autre valeur.
 * @param matrice base sur laquelle l'on efefctue les calculs
 * @param nb_possibility un pointeur sur un entier dans lequel l'on va stocker le nombre d'iteration
 * @return un entier representant l'etat du calcul dans la matrice. les valeurs possibles sont :
 *      > -1 : le calcul n'abouti pas (la valeur fixée ne peut pas etre la bonne)
 *      > 81 : toutes les valeurs on été fixées et uen seule valeur valide a été choisie par case. On a donc résolu le sudoku et on peut passer au suivant.
 */
int compute_possibility(struct matrice_possibility* matrice, int* nb_possibility);

/**
 * @brief compute_uplet permet de savoir si la valeur de la matrice à la case line:colonne est valide dans la ligne line et dans la colonne colonne
 * @param matrice la matrice dans laquelle l'on vérifie les informations
 * @param line la ligne que l'on vérifie
 * @param colonne la colonne que l'on vérifie
 * @return -1 si la valeur n'est pas bonne (elle est deja presente de façon unique dans la ligne et dans la colonne), 1 sinon
 */
int compute_uplet(struct matrice_possibility* matrice, int line, int colonne);

/**
 * @brief contain_char_mpe permet de savoir si une liste de valeurs possibles (une case de la matrice de possibilités ayant plus d'une valeur)
 * contient le caractère que l'on test
 * @param c le caractère à tester
 * @param e la liste de valeur possibles dans laquelle l'on va fare la recherche
 * @return -1 si la valeur est présente dans la liste, le nombre d'element de la liste sinon
 */
int contain_char_mpe(char c, struct mpl* e);

/**
 * @brief delete_mpl supprime l'ensemble des elements alloués dynamiquement de la liste passée en paramètre un par un
 * @param mpl_to_delete la liste que l'on souhaite supprimer
 * @note ne pas oublier de supprimer la structure list en desalouant la mémoire à l'aide d'un free et de mettre le pointer à NULL
 */
void delete_mpl(struct mpl* mpl_to_delete);

/**
 * @brief delete_matrice supprime l'ensemble de la matrice de possibilité, notament toutes les listes de valeurs possibles qui la compose
 * @param matrice la matrice que l'on souhaite supprimer
 * @note ne pas oublier de supprimer la structure matrice en desalouant la mémoire à l'aide d'un free et de mettre le pointer à NULL
 */
void delete_matrice(struct matrice_possibility* matrice);

/**
 * @brief solve_exercice resout completement un exercice sudoku
 * alloue dynamiquement l'exercice solve, initialise la matrice, la rempli avec les valeurs possibles, la résoud, et retourne un pointer sur la structure de resultat
 * @param exerc l'exercice de sudoku qui sert de base de travail
 * @return un pointer sur l'exercice solve alloué dynamiquement et constitué dans la fonction
 */
struct sudoku_exercice_solve* solve_exercice(struct sudoku_exercice* exerc);

/**
 * @brief compute_complexity_correct renvoie la complexité de la matrice, c'est à dire le nombre de valeurs possibles dans cette matrice
 * Pour chaque case de la matrice, cette fonction regarde si un élément à été fixé (possibility->possibilities[iter_line][iter_col]->current_element != NULL)
 * dans ce cas précis, la fonction considère que la complexité de la matrice est égale à 1 (même si il reste des valeurs dans la liste des possibilités qui n'ont pas été testées)
 * si possibility->possibilities[iter_line][iter_col]->current_element == NULL alors la complexité de la case est égale au nombre d'éléments de la liste de possiblité (cette case
 * n'a pas encore de valeur fixée)
 * Si la complexité est de 81, alors l'exercice est résolu (toutes les cases ont une valeur fixée et toutes ces valeurs sont valides selon les règles du sudoku)
 * @param possibility la matrice dont on cherche la complexité
 * @return la complexité de la matrice ou -1 si au moins l'une des listes de possibilités a un nombre d'éléments possible de 0
 * @note a chaque fois qu'une valeur est choisie, la complexité diminiue ou alors est égale à -1 (la valeur fixée n'est pas une valeur possible selon les
 * règles du sudoku)
 */
int compute_complexity(struct matrice_possibility* possibility);

/**
 * @brief fill_sudoku_exerc_with_matrice_correct prend toutes les valeurs de la matrice de possibilités et les met dans la matrice du sudoku
 * @param exerc le sudoku que l'on va remplir
 * @param possi la matrice qui sert d'informations
 * @note a n'appeler qu'une fois que la complexité de la matrice est de 81. Apres cette fonction, si la matrice de possibilité est valide, le sudoku est resolu et peut etre affiché
 */
void fill_sudoku_exerc_with_matrice(struct sudoku_exercice* exerc, struct matrice_possibility* possi);


#endif // SUDOKU_FUNCTIONS_H
