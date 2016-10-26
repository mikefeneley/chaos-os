#include "../drivers/screen.h"

void funt()
{
    char *video_memory = (char *) 0xb8000;
    video_memory++;
    video_memory++;
    *video_memory = 'B';
    print_char('M', 0, 0, WHITE_ON_BLACK);
    print_char('M', 1, 1, WHITE_ON_BLACK);
}


void main()
{
    char * video_memory = (char *) 0xb8000;
    *video_memory = 'X';
    funt();
}
