#include "sudoku_functions.h"

struct sudoku_exercice* copy_sudoku_exercice(struct sudoku_exercice* from_data)
{
    /**
    * @todo 0001 en 2 lignes, allouer dynamiquement un pointeur du type de retour de la fonction
    * et recopier le sudoku exercice en paramètre dans cette nouvelle structure au bon emplacement à l'aide d'un memmove
    */
    struct sudoku_exercice* macopie = malloc(sizeof(struct sudoku_exercice));

    //*macopie = *from_data; //possible aussi (et plus propre) avec : memmove(exer,from_data,sizeof(struct sudoku_exercice))
    /**
     * correction
     */
    memmove(macopie,from_data,sizeof(struct sudoku_exercice));


    return macopie;
}

struct matrice_possibility* init_matrice()
{

    //struct matrice_possibility* mat = NULL;
    /**
     * @todo 0002 en 2 lignes, allouer dynamiquement un pointeur du type de retour de la fonction
     * et remplir de 0 la nouvelle structure à l'aide d'un memset
     */
    struct matrice_possibility* mat = malloc(sizeof(struct matrice_possibility)); //malloc pour allouer le pointeur
    memset(mat,0,sizeof(struct matrice_possibility)); //memset pour remplir mat
    return mat;
}


int compute_matrice(struct matrice_possibility* matrice, struct sudoku_exercice *exerc)
{
    for(int iter_line = 0 ; iter_line < 9 ; iter_line ++)
    {
        for(int iter_column = 0 ; iter_column < 9 ; iter_column ++)
        {
            matrice->possibilities[iter_line][iter_column] = malloc(sizeof(struct mpl));
            matrice->possibilities[iter_line][iter_column]->load = NULL;
            matrice->possibilities[iter_line][iter_column]->nb_elem = 0;
            matrice->possibilities[iter_line][iter_column]->current_element = NULL;
            //2 case :
            char current_char = exerc->matrice[iter_line][iter_column];

            switch(current_char)
            {

            case '.' :
            {
                //the list is empty
                int is_present = 0;
                for(char iter_char = '1' ; iter_char < ':' ; iter_char++)
                {
                    for(int iter_col_line = 0 ; iter_col_line < 9 ; iter_col_line ++)
                    {
                        if((exerc->matrice[iter_line][iter_col_line] == iter_char) || (exerc->matrice[iter_col_line][iter_column] == iter_char))
                        {
                            is_present = 1 ;

                            break;
                        }
                    }
                    if(is_present != 1)
                    {
                        struct mpe* new_elem = malloc(sizeof(struct mpe));
                        new_elem->element = iter_char;
                        new_elem->next = matrice->possibilities[iter_line][iter_column]->load;
                        matrice->possibilities[iter_line][iter_column]->load = new_elem;
                        matrice->possibilities[iter_line][iter_column]->nb_elem += 1;
                    }
                    is_present = 0;
                }
                break;
            }

            default :
            {
                struct mpe* new_elem = malloc(sizeof(struct mpe));
                new_elem->element = current_char;
                new_elem->next = matrice->possibilities[iter_line][iter_column]->load;
                matrice->possibilities[iter_line][iter_column]->load = new_elem;
                matrice->possibilities[iter_line][iter_column]->nb_elem += 1;
            }

            }
            if(matrice->possibilities[iter_line][iter_column]->nb_elem == 1)
            {
                matrice->possibilities[iter_line][iter_column]->current_element = matrice->possibilities[iter_line][iter_column]->load;
            }
        }
    }

    /**
     * @todo 0003 imprimer dans la console la matrice des possibilités
     */
    print_possibility_matrice(matrice); // on utilise une méthode deja créée

    return 1;
}

int compute_possibility(struct matrice_possibility* matrice, int* nb_iter)
{
    //first we init all the list

    int current_line = 0;
    int current_colonne = 0;

    for (int iter_line = 0 ; iter_line < 9 ; iter_line++)
    {
        for (int iter_col = 0 ; iter_col < 9 ; iter_col++)
        {
            if(matrice->possibilities[iter_line][iter_col]->nb_elem > 1 && matrice->possibilities[iter_line][iter_col]->current_element == NULL)
            {
                /**
                 * @todo 004 : il faut en deux lignes renseigner les deux variables current_line et current_colonne avec les valeur de iter_line et iter_colonne
                 */
                current_line = iter_line; // on va ainsi recuperer le numero de ligne et de collone en dehors du for !
                current_colonne = iter_col;
                iter_line = 9;
                iter_col = 9;
            }
        }
    }

    matrice->possibilities[current_line][current_colonne]->current_element = matrice->possibilities[current_line][current_colonne]->load;
    while(1)
    {
        /**
         * @todo 005 : il faut incrementer nb_iter de 1 car on va faire une nouvelle iteration
         */
        *nb_iter += 1; // attention nb_iter est un pointeur ! avec *, on modifie ce qu'il pointe
        if(matrice->possibilities[current_line][current_colonne]->current_element == NULL)
        {
            return -1;
        }

        /**
         * @note tout se fait avec des if dans cette partie
         */

        /**
         * @todo 006 : declarer un entier et le remplir avec la fonction compute_uplet avec les bon parametres.
         * si cet entier vaut -1, alors il faut retourner au debut du while avec un continue apres avoir effectuer l'instruction suivante :
         *     matrice->possibilities[current_line][current_colonne]->current_element = matrice->possibilities[current_line][current_colonne]->current_element->next;
         */
        int entier_uplet = compute_uplet(matrice,current_line, current_colonne);
        if(entier_uplet == -1){ // dans l'element courant, on met le suivant  :
            matrice->possibilities[current_line][current_colonne]->current_element = matrice->possibilities[current_line][current_colonne]->current_element->next;
            continue; // retourne au debut du while
        }

        /**
         * @todo 007 : declarer un entier et le remplir avec la fonction compute_complexity.
         * dans le cas ou cet entier vaut -1 : retourner -1
         * dans le cas ou cet entier vaut 81 : retourner 81
         */
        int entier_complexity = compute_complexity(matrice);
        /*if(entier_complexity == -1) return -1;
        if(entier_complexity == 81) return 81;*/

        /**
         * correction
         */
        if(entier_complexity == -1 || entier_complexity == 81)
        {
            return entier_complexity;
        }

        /**
         * @todo 008 : declarer un entier et le remplir avec la fonction compute_possibility
         * si cet entier vaut 81, alors retourner 81
         */
        int entier_possibility = compute_possibility(matrice, nb_iter);
        if(entier_possibility == 81) return 81;

        matrice->possibilities[current_line][current_colonne]->current_element = matrice->possibilities[current_line][current_colonne]->current_element->next;
    }

}

int compute_uplet(struct matrice_possibility* matrice, int line, int colonne)
{
    char current_char = matrice->possibilities[line][colonne]->current_element->element;
    for (int iter_line_col = 0 ; iter_line_col < 9 ; iter_line_col++)
    {
        if(matrice->possibilities[iter_line_col][colonne]->current_element != NULL && iter_line_col != line)
        {
            if(current_char == matrice->possibilities[iter_line_col][colonne]->current_element->element)
            {
                /**
                 * @todo 009 : mettre le return qui correspond dans le cas ou la ligne contient deja la valeur que l'on test
                 */
                return -1; // cf .h
            }
        }
        if(matrice->possibilities[iter_line_col][colonne]->nb_elem == 1 && iter_line_col != line && current_char == matrice->possibilities[iter_line_col][colonne]->load->element)
        {
            return -1;
        }
        if(matrice->possibilities[line][iter_line_col]->current_element != NULL && iter_line_col != colonne)
        {
            if(current_char == matrice->possibilities[line][iter_line_col]->current_element->element)
            {
                return -1;
            }
        }
        if(matrice->possibilities[line][iter_line_col]->nb_elem == 1 && iter_line_col != colonne && current_char == matrice->possibilities[line][iter_line_col]->load->element)
        {
            return -1;
        }
    }
    return 1;
}



int contain_char_mpe(char c, struct mpl* list)
{
    struct mpe* iter = list->load;
    while(iter != NULL)
    {

        /**
         * @todo 010 : si l'element de l'iter courant vaut c, retourner -1;
         */
        if(iter->element == c) return -1;
        iter = iter->next;
    }
    return list->nb_elem;
}

void delete_mpl(struct mpl* mpl_to_delete)
{
    struct mpe* mpe_elem = mpl_to_delete->load;
    while(mpe_elem != NULL)
    {
        struct mpe* del = mpe_elem;
        mpe_elem = mpe_elem->next;
        /**
         * @todo 011 : a ce stade l'element a été supprimé de la liste. Il faut donc mettre à jour le nombre d'element de la liste
         * et désalouer la mémoire pointée par del
         */
        mpl_to_delete->nb_elem -= 1; // un element a été suprimé, donc nb_elem diminu de 1
        free(del); //désalouer la mémoir de del
    }
}

void delete_matrice(struct matrice_possibility* matrice)
{
    if(matrice != NULL){
        for(int iter_column = 0 ; iter_column < 9 ; iter_column ++)
        {
            for(int iter_line = 0 ; iter_line < 9 ; iter_line ++)
            {
                if(matrice->possibilities[iter_line][iter_column] != NULL && matrice->possibilities[iter_line][iter_column]->nb_elem != 0)
                {
                    /**
                     * @todo 012 : il faut supprimer la liste contenue à l'emplacement iter_line:iter_column de la matrice de possibilités
                     * avec la fonction faite pour. Il faut ensuite mettre le pointeur de la liste en question à NULL. (2 lignes)
                     */
                    delete_mpl(matrice->possibilities[iter_line][iter_column]); // supression grace à méthode delete_mpl
                    matrice->possibilities[iter_line][iter_column] = NULL; // pointeur = null
                }
            }
        }
        free(matrice);
    }
    matrice = NULL;
}

struct sudoku_exercice_solve* solve_exercice(struct sudoku_exercice* exerc)
{

    struct sudoku_exercice_solve* solve = malloc(sizeof(struct sudoku_exercice_solve));
    solve->exerc = exerc;
    /**
     * @todo 013 : initialiser la matrice avec la fonction qui correspond
     */
    solve->matrice = init_matrice();
    /**
     * @todo 014 : remplir la matrice avec les valeurs possibles à l'aide de la fonction compute_matrice
     */
    compute_matrice(solve->matrice, exerc);
    /**
     * @todo : utiliser la fonction compute_possibility
     */
    int compute_pos = compute_possibility(solve->matrice,&(solve->nb_iteration)); // retire _correct
    if(compute_pos == 81)
    {
        /**
         * @todo : utiliser la fonction fill_sudoku_exerc_with_matrice
         */
        fill_sudoku_exerc_with_matrice(solve->exerc,solve->matrice); // retire _correct
        struct sudoku_element elem;
        elem.sudoku = solve->exerc;
        printf("\nsudoku resolu avec %d iterations\n",solve->nb_iteration);
        print_sudoku_element(&elem);
        printf("\n");
    }
    /**
     * @todo 015 : faire le return qui correspond
     */
    return solve; // la signature de la methode indique de return un pointeur de struct sudoku_exercice_solve
}

int compute_complexity(struct matrice_possibility* possibility)
{
    int complexity = 0;
    for(int iter_line = 0 ; iter_line < 9 ; iter_line++)
    {
        for(int iter_col = 0 ; iter_col < 9 ; iter_col++)
        {
            if(possibility->possibilities[iter_line][iter_col]->current_element != NULL)
            {
                /**
                 * @todo 016 : dans le cas ou il y a un element de fixé pour la case de la matrice de possibilité, ajouter la bonne valeur à complexity
                 */
                complexity += 1; // complexité augmentée de 1

            } else {
                int nb_elem = possibility->possibilities[iter_line][iter_col]->nb_elem;
                if(nb_elem == 0)
                {
                    return -1;
                }
                /**
                 * @todo 017 : dans le cas ou aucun element n'est fixé pour la case de la matrice de possibilité, il faut ajouter le nombre d'élément possible
                 * à complexity
                 */

                //complexity += 81; // 81 element au max (9*9)
                /**
                 * correction
                 */
                complexity += nb_elem;
            }
        }
    }
    return complexity;
}

void fill_sudoku_exerc_with_matrice(struct sudoku_exercice* exerc, struct matrice_possibility* possi)
{
    for(int iter_line = 0 ; iter_line < 9 ; iter_line++)
    {
        for(int iter_col = 0 ; iter_col < 9 ; iter_col++)
        {
            if(possi->possibilities[iter_line][iter_col]->current_element != NULL){
                /**
                 * @todo 018 : mettre l'element char de la case courante de la matrice de possibilité dans la bonne case de matrice du sudoku_exercice
                 */
                exerc->matrice[iter_line][iter_col] = possi->possibilities[iter_line][iter_col]->current_element->element; // element est un char
            }
        }
    }
}
