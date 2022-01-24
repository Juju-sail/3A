#include "main_functions.h"


main_functions()
{

}

void afficher_bonjour()
{
    printf("1/ Bonjour\n");
}

void afficher_bonjour_num(int num_etudiant)
{
    printf("2/ Bonjour, %d\n", num_etudiant);
}

void afficher_bonjour_nom(int num_etudiant, char* nom_etudiant)
{
    printf("3/ Bonjour %s votre numero etudiant est : %d\n", nom_etudiant, num_etudiant);
}

void init_operation(struct operations* oper)
{
    oper->type_oper = operation_inconnue;
    oper->operande_01 = 0.0;
    oper->operande_02 = 0.0;
    oper->resultat = 0.0;
    // memset(oper,0,sizeof(struct operation)); fait la même chose que les lignes du dessus
}

void renseigner_operation(struct operations* current_oper, enum type_operation type_oper, double operande_01, double operande_02){
    init_operation(current_oper);
    current_oper->type_oper = type_oper;
    current_oper->operande_01 = operande_01;
    current_oper->operande_02 = operande_02;
}

void effectuer_operation(struct operations* oper){
    switch(oper->type_oper){
        case 0 : {
            printf("l'operation est inconnue; Abandon\n");
            return; //Break marche aussi mais fais juste sortir du switch
        }
        case 1 : {
            oper->resultat = oper->operande_01 + oper->operande_02;
            break;
        }
        case 2 : {
            oper->resultat = oper->operande_01 - oper->operande_02;
            break;
        }
        case 3 : {
            oper->resultat = oper->operande_01 * oper->operande_02;
            break;
        }
        case 4 : {
            if(oper->operande_02==0.0){
                printf("Attention, division par zero !\n");
                return;
            }
            oper->resultat = oper->operande_01 / oper->operande_02;
            break;
        }

        default : {
            printf("erreur très étrange");
            return;
        }
    }

    printf("L'operation a bie été effectuée");
}

void affichage_operation(struct operations* data_a_afficher){
    printf("type operation : %f\n operande 1 : %f\n operande 2 : %f\n resultat : %f\n", 
    (int) data_a_afficher->type_oper, 
    data_a_afficher->operande_01, 
    data_a_afficher->operande_02, 
    data_a_afficher->resultat);
}

struct operations* tester_operation(){
    struct operations* ptr_oper = malloc(5*sizeof(struct operations));
    for(int i = 0; i < 5; i++){
        struct operations* mon_operation = &(ptr_oper[i]);
        // init_operation(mon_operation);
        renseigner_operation(mon_operation, ((enum type_operation) i),3.0,11.0);
        effectuer_operation(mon_operation);
        affichage_operation(mon_operation);

    }
    return ptr_oper;
}