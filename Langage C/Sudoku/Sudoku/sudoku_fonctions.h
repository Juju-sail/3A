#ifndef SUDOKU_FUNCTIONS_H
#define SUDOKU_FUNCTIONS_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/**
 * @brief initialise le tableau de sudoku
 */


/**
 * @brief supprime la liste d'exercice
 */

/**
 * @brief structure contenant un sudoku
 * @property identifiant chaine de caractère de 10 (attention il y a un piège)
 * @property matrice de caractères contenant les donnees du sudoku (9 par 9 case)
 * @property nb_iteration un entier non signé permettant de voir combien d'iteration on été réalisée
 */
struct sudoku_exercice{
    char identifiant[11];
    char matrice[9][9];
    unsigned int nb_iteration;
};

/**
 * @brief init_sudoku_exercice permet d'initialiser un sodoku exercice
 * @param exerc un pointer sur la structure à initialiser
 * @note memset ? tous les champs ne seront pas intialisés avec la même valeur
 */
void init_sudoku_exercice(struct sudoku_exercice* exerc);

/**
 * @brief structure de liste contenant un element sudoku exercice
 * @property prev un pointer sur l'element precedent
 * @property next un pointer sur l'element suivant
 * @property sodoku un pointeur sur l'exercice
 */
struct sudoku_element{
    struct sudoku_element* prev;
    struct sudoku_element* next;
    struct sudoku_exercice* sudoku;
};

/**
 * @brief structure encapsulant une liste de sudoku element. Permet de realiser toutes les opérations sur la liste
 * @property load un pointer sur la liste d'éléments (en fait sur le premier qui donne acces aux suivants).
 * @property first un pointer sur le premier element mais qui ne sera jamais modifié (permet de toujours conserver l'information, sécurité).
 * @property nb_element un entier non signé contenant le nombre d'élément présentement dans la liste.
 * @note il aurait été tout à fait possible de se passer de cette structure mais elle est pratique
 */
struct sudoku_list{
    struct sudoku_element* load;
    struct sudoku_element* first;
    unsigned int nb_element;
};

/**
 * @brief initialize une liste de sudoku
 * @param list_to_init un pointer sur la liste à initialiser
 * @note lors de l'initialisation, la liste doit être vide et ses variables complètement intialisées.
 * Si la liste n'est pas vide, faire un message d'erreur et ne rien faire de plus
 */
void init_sudoku_list(struct sudoku_list* list_to_init);

/**
 * @brief init_sudoku_element initialise un sudoku element
 * @param elem un pointer sur la structure à initialiser
 */
void init_sudoku_element(struct sudoku_element* elem);

/**
 * @brief creer un element en tête de liste
 * @param base_list un pointer sur la liste ou l'on va insérer le sudoku
 * @return un pointer sur le sudoku_element créé.
 * @note ne pas oublier d'initialiser correctement le sudoku element
 */
struct sudoku_element* creat_front(struct sudoku_list* base_list);

/**
 * @brief creer un element en fin de liste
 * @param base_list un pointer sur la liste ou l'on va insérer le sudoku
 * @return un pointer sur le sudoku_element créé.
 * @note ne pas oublier d'initialiser correctement le sudoku element
 */
struct sudoku_element* create_end(struct sudoku_list* base_list);

/**
 * @brief get_front_element
 * @param list un pointeur sur la liste dans laquelle l'on recherche l'element
 * @return un pointer sur le premier element
 */
struct sudoku_element* get_front_element(struct sudoku_list* list);

/**
 * @brief get_last_element
 * @param list un pointeur sur la liste dans laquelle l'on recherche l'element
 * @return un pointer sur le dernier element
 */
struct sudoku_element* get_last_element(struct sudoku_list* list);

/**
 * @brief delete_last_element supprime le dernier sudoku element d'une liste
 * @param list un pointer sur la la liste ou supprimer
 */
void delete_last_element(struct sudoku_list* list);

/**
 * @brief delete_first_element
 * @param list un pointer sur la la liste ou supprimer
 */
void delete_first_element(struct sudoku_list* list);

/**
 * @brief initialise le tableau de sudoku
 * @param list un pointer sur la liste ou l'on va stocker les resultats de la génération
 */
void init_tab_exercice(struct sudoku_list* list);

/**
 * @brief generate_id genere l'id d'un sudoku a partir du numero passe en parametre
 * @param num_sudoku le numero du sudoku.
 * @param dest le tableau de char ou l'id sera enregistre
 * @note l'id aura pour forme "sudokuXXXX" ou XXXX est un nombre fill 0
 */
void generate_id(int num_sudoku, char* dest);

/**
 * @brief delete_tab_exercice supprime la liste de sudoku
 * @param list un pointer sur la liste ou supprimer les element
 */
void delete_tab_exercice(struct sudoku_list* list);

/**
 * @brief copy_sudoku_element
 * @param from_data un pointer sur la structure qui sera copiée
 * @return un pointer sur la copie du sudoku exercice. allocation dynamique de memoire
 */
struct sudoku_exercice* copy_sudoku_exercice(struct sudoku_exercice* from_data);

/**
 * @brief print_sudoku_element affiche un sudoku element dans la console
 * @param elem un pointer sur l'element a afficher
 */
void print_sudoku_element(struct sudoku_element* elem);

//matrice possibilite element
struct mpe {
    char element;
    struct mpe* next;
};

struct mpl {
    struct mpe* load;
    int nb_elem;
};

struct matrice_possibility {
    struct mpl* possibilities[9][9];
};

struct matrice_possibility* init_matrice();

void compute_matrice(struct matrice_possibility* matrice, struct sudoku_exercice* exerc);

void compute_carre(struct matrice_possibility* matrice);

void delete_char_mpe(char c, struct mpl* e);

void delete_mpl(struct mpl* mpl_to_delete);

void delete_matrice(struct matrice_possibility* matrice);

enum add_element_status
{
    element_status_add = 0,
    element_status_not_possible,
    element_status_already_in_list
};

int add_element_matrice(int column, int line, struct matrice_possibility* matrice, char value_to_add, struct sudoku_exercice* exerc);

struct sudoku_exercice_solve {
    struct sudoku_exercice* exerc;
    struct matrice_possibility* matrice;
    int nb_iteration;
};

void delete_exercice_solve(struct sudoku_exercice_solve* del);

struct sudoku_exercice_solve* solve_exercice(struct sudoku_exercice* exerc);

void print_possibility_matrice(struct matrice_possibility* possibility);

#endif //SUDOKU_FUNCTIONS_H
