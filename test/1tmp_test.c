//extern void abort(void);
//void reach_error(){}

#include <stdlib.h>
#include <pthread.h>
//#include <string.h>

//void __VERIFIER_assert(int expression) { if (!expression) { ERROR: {reach_error();abort();}}; return; }

int x,y,z;
void *thread1(void * arg)
{
    x=1,y=2,z=3;
    return 0;
}

void *thread2(void *arg)
{
    return 0;
}
int main()
{
//    int x=1,y=2;
//    if(x-1)
//        y++;
//    else
//        y--;


    pthread_t t1, t2;

    pthread_create(&t1, 0, thread1, 0);
    pthread_create(&t2, 0, thread2, 0);
    pthread_join(t1, 0);
    pthread_join(t2, 0);

    //__VERIFIER_assert(!x || v[0] == 'B');

    return 0;
}

