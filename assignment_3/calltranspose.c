#include <stdio.h>

void mmxtranspose(char *src, char *dest);

void endmmx(void);


int main(void) {

    FILE *fp;
    fp = fopen("ip.txt", "r");
    char srcmat[32];
    char destmat[32];
    int i, j;
    for (i = 0; i < 4; i++) {
	for (j = 0; j < 8; j++) {
	    srcmat[i * 8 + j] = fgetc(fp);
	    fgetc(fp);
	}
    }

    printf("\nOriginal 4X8 Matrix\n");
    for (i = 0; i < 4; i++) {
	for (j = 0; j < 8; j++) {
	    printf("%c ", srcmat[i * 8 + j]);
	}
	putchar('\n');
    }

    fclose(fp);

    mmxtranspose((void *)srcmat, (void *)destmat);
    endmmx();

    printf("\nTransposed 8X4 Matrix\n");
    for (i = 0; i < 8; i++) {
	for (j = 0; j < 4; j++) {
	    printf("%c ", destmat[i * 4 + j]);
	}
	putchar('\n');
    }

    return 0;
}



