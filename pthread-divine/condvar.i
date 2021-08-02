






void abort(void);
void reach_error(){}

pthread_mutex_t lock;
pthread_cond_t cond;



int x;
_Bool x_set = 0;

void *thread( void *arg ) {
    (void)arg;
    pthread_mutex_lock( &lock );
    while ( !x_set )
        pthread_cond_wait( &cond, &lock );
    (!(x == 42) ? reach_error() : (void)0);
    pthread_mutex_unlock( &lock );
    return NULL;
}

int main() {
    pthread_t t;
    pthread_create( &t, NULL, thread, NULL );
    for ( int i = 0; i <= 42; i++ )
        x = i;
    x_set = 1;
    pthread_cond_broadcast( &cond );
    pthread_join( t, NULL );
}
