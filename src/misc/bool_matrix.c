#include "misc/bool_matrix.h"
#include "misc/matrix.h"
#include <stdbool.h>

INIT_MATRIX(bool)

void disp_bool_matrix(t_bool_matrix *mat){
    for(int y = 0; y < mat->lines; y++){
        for(int x = 0; x < mat->cols; x++){
            printf("| %d ", M_bool_GET(mat, x, y));
        }
        printf("|\n");
    }
}

void save_bool_matrix(char *path, t_bool_matrix *mat) {
    FILE *f = fopen(path, "wb");
    if(!f){
        printf("Couldn't open %s to save the bool matrix\n", path);
        exit(0);
    }
    fwrite(&mat->lines, sizeof(int), 1, f);
    fwrite(&mat->cols, sizeof(int), 1, f);
    fwrite(mat->values, sizeof(bool), mat->lines * mat->cols, f);
    fclose(f);
}

t_bool_matrix *load_bool_matrix(char *path){
    FILE *f = fopen(path, "rb");
    if(!f){
        printf("Couldn't open %s to read the bool matrix\n", path);
        return NULL;
    }
    t_bool_matrix *mat = malloc(sizeof(t_bool_matrix));
    fread(&mat->lines, sizeof(int), 1, f);
    fread(&mat->cols, sizeof(int), 1, f);
    mat->values = malloc(sizeof(bool) * mat->lines * mat->cols);
    fread(mat->values, sizeof(bool), mat->cols * mat->lines, f);
    fclose(f);
    return mat;
}

void pprint_bool_matrix(t_bool_matrix *mat){
    if(!mat)
        return;
    for(int y = 0; y < mat->lines; y++){
        printf("|");
        for(int x = 0; x < mat->cols; x++){
            if(!M_bool_GET(mat, x, y))
                printf("#");
            else
                printf(" ");

        }
        printf("|\n");
    }
}
