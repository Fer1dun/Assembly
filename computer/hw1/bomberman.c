#include <stdio.h>
#include <stdlib.h>

void bomb(char*input_array,int row,int colum);
void print_screen(char*input_array);

void print_screen(char*input_array){
    printf("enter the row and cloum");
    int row ,colum;
    scanf("%d %d",&row,&colum);
    scanf("%s",input_array);
    char array[row][colum];
    int y=0;
    for(int x=0; x<row*colum;x++){
        printf("%c",input_array[x]);
        y++;
        if(y==row){
        printf("\n");
        y=0;}

    }
    printf("\n");
    bomb(input_array,row,colum);

}
void bomb(char*input_array,int row,int colum){
    char *array = (char *)malloc(sizeof(char) * 100);
    for(int x=0;x<row*colum;x++){
        array[x]='o';
    }
    for(int i=0;i<row*colum;i++){
        if(input_array[i]=='o'){
            if((i)%colum!=0){
            array[i-1]='.';
            }
            array[i]='.';
            if((i+1)%colum!=0){
            array[i+1]='.';
            }
            array[i+colum]='.'; 
            array[i-colum]='.';
        }
    }
    int y=0;
    for(int x=0; x<row*colum;x++){
        printf("%c",array[x]);
        y++;
        if(y==row){
        printf("\n");
        y=0;}

    }

}

int main (){
    char *input_array = (char *)malloc(sizeof(char) *1);
    print_screen(input_array);
    free(input_array);
    return 0;

}