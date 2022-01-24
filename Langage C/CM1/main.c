#include "main_functions.h"
#include "main_functions.c"

int main(int argc, char* argv[]){
    afficher_bonjour();
    afficher_bonjour_num(333);
    afficher_bonjour_nom(458525, "Juju\0"); // \0 = carractere de terminaison
    printf("##########################\n");
    printf("Partie sur les operations/ \n");
    printf("##########################\n");
    struct operation* ptr_tab = tester_operation();
    free(ptr_tab);
    return 0;
}
