#include "sudoku_fonctions.h"

void test_insert_first_delete_last();
void test_insert_last_delete_first();






int main(int argc, char const *argv[])
{
    //test_insert_first_delete_last();
    //test_insert_last_delete_first();
    struct sudoku_list* list = malloc(sizeof(struct sudoku_list));
    list->first = NULL;
    list->load = NULL;
    init_sudoku_list(list);
    //ma liste est maintenant initialisee
    init_tab_exercice(list);
    struct sudoku_element* elem = list->load;
    while(elem)
    {
        print_sudoku_element(elem);
        elem = elem->next;
    }
    copy_sudoku_exercice(list->load->sudoku);
    return 0;
}







void test_insert_first_delete_last(){
    printf("### Insert First, Delete Last ###\n");
    struct sudoku_list* maListe = malloc(sizeof(struct sudoku_list));
    maListe->load = NULL;
    maListe->first = NULL;
    init_sudoku_list(maListe);
    //creation
    for(int i = 0; i<10;i++){
        creat_front(maListe);
    }
    //affichage du nb d'elements dans la liste
    printf("nb element dans liste : %d\n", (*maListe).nb_element);
    //supression
    delete_last_element(maListe);
    //affichage du nb d'elements dans la liste
    printf("nb element dans liste apres suppression : %d\n", (*maListe).nb_element);
}

void test_insert_last_delete_first(){
    printf("\n### Insert Last, Delete First ###\n");
    struct sudoku_list* maListe = malloc(sizeof(struct sudoku_list));
    maListe->load = NULL;
    maListe->first = NULL;
    init_sudoku_list(maListe);
    //creation
    for(int i = 0; i<10;i++){
        create_end(maListe);
    }
    //affichage du nb d'elements dans la liste
    printf("nb element dans liste : %d\n", (*maListe).nb_element);
    //supression
    delete_first_element(maListe);
    //affichage du nb d'elements dans la liste
    printf("nb element dans liste apres suppression : %d\n", (*maListe).nb_element);
}
