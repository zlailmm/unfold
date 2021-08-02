 extern void abort(void);
void reach_error(){}
void __VERIFIER_assert(int cond) { if (!(cond)) { ERROR: {reach_error();abort();} } return; }


void exit(int code){
  return ;
}


int myglobal;
pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;

void *thread_function_mutex(void *arg)
{
    int i,j;
    for ( i=0; i<20; i++ )
    {
        pthread_mutex_lock(&mymutex);
        j=myglobal;
        j=j+1;
        printf("\nIn thread_function_mutex..\t");

        myglobal=j;
        pthread_mutex_unlock(&mymutex);
    }
    return NULL;
}

int main(void)
{
    pthread_t mythread;
    int i;

    printf("\n\t\t---------------------------------------------------------------------------");
    printf("\n\t\t Centre for Development of Advanced Computing (C-DAC)");
    printf("\n\t\t Email : hpcfte@cdac.in");
    printf("\n\t\t---------------------------------------------------------------------------");

    myglobal = 0;

    if ( pthread_create( &mythread, NULL, thread_function_mutex, NULL) )
    {
      exit(-1);
    }
    for ( i=0; i<20; i++)
    {
        pthread_mutex_lock(&mymutex);
        myglobal=myglobal+1;
        pthread_mutex_unlock(&mymutex);
    }

    if ( pthread_join ( mythread, NULL ) )
    {
      exit(-1);
    }

    __VERIFIER_assert(myglobal == 40);
    exit(0);
}
