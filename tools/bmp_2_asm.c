/*-----------------------------------------
 tool to convert monochrome .BMP files 
 to asm file 
-------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

FILE *fi,*fo; 
int foffset;

void usage(){
    puts("convert monochrome BMP file to sdasstm8 assembly file.");
    puts("bmp_2_asm input_file.bmp output_file.asm");
    puts ("input_file.bmp must be windows bmp, 1 bit per pixel.");
    exit(0);
}

void skip_nbytes(int n){
    int i;
    for (i=0;i<n;i++) {fgetc(fi); foffset++;}
}

uint32_t get_uint32(){
    foffset+=4;
    uint32_t u=0; 
    uint8_t c1,c2,c3,c4;
    c1=fgetc(fi);
    c2=fgetc(fi);
    c3=fgetc(fi);
    c4=fgetc(fi);
printf("%02X, %02X, %02X, %02X\n",c1,c2,c3,c4);
    u=(uint32_t)c4;
    u=256*u+(uint32_t)c3;
    u=256*u+(uint32_t)c2;
    u=256*u+(uint32_t)c1;
    return u;
}

void convert(char* fi_name){
    uint8_t c;
    uint32_t width,height,data_offset;
    uint32_t bytes_to_keep, bytes_per_row,data_size,img_data_size;

    if (!(fgetc(fi)=='B' && fgetc(fi)=='M')){
        printf("%s is not a windows bmp file.\n",fi_name);
        exit(0);
    }
    foffset+=2;
    skip_nbytes(8); // skip unused data 
    // bitmap data offset 
    data_offset=get_uint32();
    skip_nbytes(4); //DIB record size 
    // image width in pixels
    width=get_uint32();
    bytes_to_keep=width/8;
    if (width%8){bytes_to_keep++;}
    bytes_per_row=(bytes_to_keep+4)& ~3;
    // image height in pixels
    height=get_uint32();
    data_size=bytes_per_row*height;
    // skip to data 
    skip_nbytes(data_offset-foffset);
    printf("converting bmp, width=%d, height=%d, bytes per row=%d\n",width,height,bytes_to_keep);
    fputs(";----------------------\n",fo);
    fputs(";  splash screen\n",fo);
    fputs(";----------------------\n",fo);
    fprintf(fo,"BYTES_PER_IMG_ROW=%d\n",bytes_to_keep);
    fprintf(fo,"IMG_DATA_SIZE=%d",bytes_to_keep*height);
    fputs("\n\t.area CODE\n\nimg_data:\n",fo);
    for (int i=0;i<data_size;i+=bytes_per_row){
        fputs("\t.byte ",fo);
        for (int j=0;j<bytes_to_keep;j++){
            c=fgetc(fi);
            if (j<(bytes_to_keep-1)){
                fprintf(fo,"0x%02X, ",c);
            }
            else{ 
                fprintf(fo,"0x%02X\n",c);
            }
            foffset++;
        }
        skip_nbytes(bytes_per_row-bytes_to_keep);
    }
}

int main(int argc, char** argv){
    if (argc < 3) usage();
    if ((fi=fopen(argv[1],"rb"))==NULL) {
        printf("%s file not found.\n",argv[1]);
        exit(0);
    };
    if ((fo=fopen(argv[2],"w"))==NULL) {
        printf("%s file could not be created.\n",argv[2]);
        exit(0);
        };
    convert(argv[1]);
    fclose(fi);
    fclose(fo);
    return -1;
}
