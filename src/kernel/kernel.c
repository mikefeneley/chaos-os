void funt()
{
    char *video_memory = (char *) 0xb8000;
    video_memory++;
    video_memory++;
    *video_memory = 'B';

}


void main()
{
    char * video_memory = (char *) 0xb8000;
    *video_memory = 'X';
    funt();
}
