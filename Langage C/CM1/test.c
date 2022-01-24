#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[])
{
    // Pour un commentaire

    /* héhé
     * Pour un comm sur plusieurs lignes
     * blaa
    */
    int valeur_en_hexadecimal = 0x11;
    int variable_entiere = 1;
    double tableau_de_reels[3] = {0.2, 3.1, 8.5};
    tableau_de_reels[2] = variable_entiere;
    printf("le tableau de reels %f\n", tableau_de_reels[1]);



    //Les pointeurs :
    int b = 3;
    modif(b);
    modif_avec_pointeur(&b);
    return 0;

}

void modif(int a){ //Ne va rien faire dans le programme
    a = 5;
}
void modif_avec_pointeur(int* a){ //Va modifier notre variable dont l'adresse est en argument lors de notre appel
    *a = 7;
}