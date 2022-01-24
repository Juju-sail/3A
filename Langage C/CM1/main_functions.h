#ifndef MAIN_FUNCTIONS_H
#define MAIN_FUNCTIONS_H
#include <stdio.h>
#include <stdlib.h>

/**
 * phase 1
 */

/**
 * @brief fonction afficher_bonjour qui affiche bonjour et saute une ligne
 */
void afficher_bonjour();

/**
 * @brief fonction afficher_bonjour qui affiche bonjour et le numero d'etudiant
 * @param int etunum le numero d'etudiant
 * @note le format de sortie devra etre "bonjour etunidiant_num"
 */
void afficher_bonjour_num(int num_etudiant);

/**
 * @brief fonction afficher_bonjour qui affiche bonjour, le nom et le numero d'etudiant
 * @param int etunum le numero d'etudiant
 * @param nom le nom de l'etudiant
 * @note le format de sortie devra etre "bonjour nom_etudiant etudiant numero num_etudiant"
 */
void afficher_bonjour_nom(int num_etudiant, char* nom_etudiant); //char* <=> str (premier element d'un tab de char

/**
 * @brief enum representant un type d'operation
 * @note les 5 type d'operation seront operation_inconnue, operation_addition, operation_soustraction, operation_multiplication, operation_division
 */
enum type_operation {
    operation_inconnue = 0,
    operation_addition,
    operation_soustraction,
    operation_multiplication,
    operation_division
};

/**
 * @brief structure representant une operation
 * @property type_oper le type de l'operation
 * @property operande_01 le premier operande de type nombre à virgule sur 12 octets
 * @property operande_02 le deuxieme operande de type nombre à virgule sur 12 octets
 * @property resultat de type nombre à virgule sur 12 octets
 * @note l'operation a realiser sera de la forme resultat = operande_01 (operateur type operation) operande_02;
 */
struct operations{
    enum type_operation type_oper;
    double operande_01;
    double operande_02;
    double resultat;
};

/**
 * @brief init_operation fonction permettant d'initialiser une operation
 * @param oper un pointer sur l'operation à initialiser
 * @note l'utilisation de memset serait peut etre un indice. rtfm
 */
void init_operation(struct operations* oper); //struct operation est un type

/**
 * @brief renseigner_operation fonction permettant de remplir une structure operation
 * @param current_oper un pointer sur l'operation sur laquelle l'on veut travailler
 * @param type_oper le type de l'operation
 * @param operande_01 un double pour l'operation
 * @param operande_02 un double pour l'operation
 * @note l'operation devra être intialisée avant de remplir les informations
 */
void renseigner_operation(struct operations* current_oper, enum type_operation type_oper, double operande_01, double operande_02);

/**
 * @brief effectuer_operation permet de calculer l'operation
 * @param oper un pointeur sur la structure operation à calculer
 * @note il faudra mettre un message d'erreur quand l'operation est inconnue et dans le cas de la division /0
 */
void effectuer_operation(struct operations* oper);

/**
 * @brief affichage_operation permet d'afficher une operation selon un formatage fourni
 * @param data_a_afficher un pointer sur l'operation a afficher
 * afficher l'operation sous la forme :
   affichage d'une operation :
        type operation : type de l'operation sous la forme d'un entier
        operande 01 : valeur de operande_01
        operande 02 : valeur de operande_02
        resultat : le resultat
 * @note : mais que peut bien etre le caractère qui permet de decaler une sortie console ?
 */
void affichage_operation(struct operations* data_a_afficher);

/**
 * @brief fonction permettant de tester les operations. Il faudra un test avec
 * un tableau de 5 operations. creation, init, calcul et affichage.
 * @return un pointeur sur le premier element du tableau
 * @note le tabelau sera créé avec la fonction malloc et tout sera fait avec des boucles for.
 * Ne pas oublier de supprimer les pointeurs une fois utilisés
 */
struct operations* tester_operation();

#endif // MAIN_FUNCTIONS_H
