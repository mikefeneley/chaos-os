#include "screen.h"

int get_cursor()
{
    port_byte_out(REG_SCREEN_CTRL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL, 15);
    offset += port_byte_in(REG_SCREEN_DATA);
    return offset * 2;
}


void set_cursor(int offset)
{
    offset /= 2;

    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, offset);

}

int get_screen_offset(int col, int row)
{
    return ((row * MAX_COLS) + col) * 2;
}

int handle_scrolling(int cursor_offset)
{

    if(cursor_offset < MAX_ROWS * MAX_COLS *2) {
        return cursor_offset;
    }

    int i;
    for(i = 0; i < MAX_ROWS; i++)
    {
       memory_copy(get_screen_offset (0 , i) + VIDEO_ADDRESS,
            get_screen_offset(0 ,i-1) + VIDEO_ADDRESS,
            MAX_COLS * 2);
    }

    /* Blank the last line by setting all bytes to 0 */
    char *last_line = get_screen_offset(0 , MAX_ROWS -1) + VIDEO_ADDRESS;
    for (i = 0; i < MAX_COLS * 2; i++)
    {
        last_line[i] = 0;
    }
    // Move the offset back one row , such that it is now on the last
    // // row , rather than off the edge of the screen .
    cursor_offset -= 2 * MAX_COLS ;
    // // Return the updated cursor position .
    return cursor_offset ;
}

void print_char( char character , int col , int row , char attribute_byte ) {
    /* Create a byte ( char ) pointer to the start of video memory */
    unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS ;
    /* If attribute byte is zero , assume the default style . */
    if (! attribute_byte) {
        attribute_byte = WHITE_ON_BLACK ;
    }
    /* Get the video memory offset for the screen location */
    int offset ;
    /* If col and row are non - negative , use them for offset . */
    if(col >= 0 && row >= 0) {
        offset = get_screen_offset (col , row);
        /* Otherwise , use the current cursor position . */
    } else {
        offset = get_cursor();
    }
    // If we see a newline character , set offset to the end of
    // // current row , so it will be advanced to the first col
    // // of the next row.
    if(character == '\n') {    
        int rows = offset / (2 * MAX_COLS);
        offset = get_screen_offset(79 ,rows);
        // Otherwise , write the character and its attribute byte to
        // // video memory at our calculated offset .
    } else {
        vidmem[offset] = character;
        vidmem[offset + 1] = attribute_byte;
    }

    offset += 2;
    
    offset = handle_scrolling(offset);
    set_cursor(offset);
}

void print_at(char *message, int col, int row)
{
    if(col >= 0 && row >= 0) {
        set_cursor(get_screen_offset(col, row));
    }
    int i = 0;
    while(message[i] != 0) {
        print_char(message[i++], col, row, WHITE_ON_BLACK);
    }
}

void print(char* message) {
    print_at(message, -1, -1);
}

void clear_screen()
{
    int row = 0;
    int col = 0;

    for(row = 0; row < MAX_ROWS; row++)
    { 
        for(col = 0; col < MAX_COLS; col++)
        {
            print_char(' ', col, row, WHITE_ON_BLACK);
        }
    }
    set_cursor(get_screen_offset(0, 0));
}
