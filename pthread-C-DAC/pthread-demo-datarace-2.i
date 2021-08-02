extern void abort(void);
void reach_error(){}
void __VERIFIER_assert(int cond) { if (!(cond)) { ERROR: {reach_error();abort();} } return; }


void exit(int code){
  return ;
}


int myglobal;
pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;


void *thread_function_datarace(void *arg)
{
    int i,j;
    for ( i=0; i<20; i++ )
    {
        j=myglobal;
        j=j+1;
        printf("\nIn thread_function_datarace..\t");

        myglobal=j;
    }
    return NULL;
}

int main(void)
{
    pthread_t mythread;
    int i;

    if ( pthread_create( &mythread, NULL, thread_function_datarace, NULL) )
    {
      exit(-1);
    }

    printf("\n\t\t---------------------------------------------------------------------------");
    printf("\n\t\t Centre for Development of Advanced Computing (C-DAC)");
    printf("\n\t\t Email : hpcfte@cdac.in");
    printf("\n\t\t---------------------------------------------------------------------------");
    printf("\n\t\t Objective : Pthread code to illustrate data race condition and its solution \n ");
    printf("\n\t\t..........................................................................\n");

    for ( i=0; i<20; i++)
    {
        myglobal=myglobal+1;

    }

    if ( pthread_join ( mythread, NULL ) )
    {
      exit(-1);
    }
    __VERIFIER_assert(myglobal != 40);
    printf("\nValue of myglobal in thread_function_datarace is :  %d\n",myglobal);
    printf("\n ----------------------------------------------------------------------------------------------------\n");

    exit(0);
}
