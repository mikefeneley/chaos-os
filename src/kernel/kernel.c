#include "../drivers/screen.h"

void funt()
{
/*    char *video_memory = (char *) 0xb8000;
    video_memory++;
    video_memory++;
    *video_memory = 'B';
*/


    clear_screen();
    
    char *message = "This is a message";
    print(message);
}


void main()
{
    char * video_memory = (char *) 0xb8000;
    *video_memory = 'X';
    funt();
}
