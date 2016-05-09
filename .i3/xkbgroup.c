// compile with: gcc -lX11 xkbgroup.c -o xkbgroup
#include <X11/XKBlib.h>
int main() {
    XkbStateRec xkbState;
    XkbGetState(XkbOpenDisplay("", NULL, NULL, NULL, NULL, NULL), XkbUseCoreKbd, &xkbState);
    return xkbState.group;
}
