












void abort(void);
void reach_error(){}
typedef struct _ring {
    volatile long reader;
    long q[ 4 ];
    volatile long writer;
} Ring;

void ring_enqueue( Ring *r, long x ) {
    while ( (r->writer + 1) % 4 == r->reader );
    r->q[ r->writer ] = x;
    r->writer = (r->writer + 1) % 4;
}

long ring_dequeue( Ring *r ) {
    long x = r->q[ r->reader ];
    r->reader = (r->reader + 1) % 4;
    return x;
}

_Bool ring_empty( Ring *r ) {
    return r->reader == r->writer;
}

void ring_init( Ring *r ) {
    r->reader = r->writer = 0;
}

void *reader_fn( void *arg ) {
    Ring *r = arg;
    long val = 0, last = 0, i = 0;
    while ( i < 8 ) {
        if ( ring_empty( r ) )
            continue;
        val = ring_dequeue( r );
        (!(val == last + 1) ? reach_error() : (void)0);
        last = val;
        ++i;
    }
    (!(last == 8) ? reach_error() : (void)0);
    (!(ring_empty( r )) ? reach_error() : (void)0);
    return 0;
}

void *writer_fn( void *arg ) {
    static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    Ring *r = arg;
    for ( long i = 0; i < 8; ++i ) {
        pthread_mutex_lock( &mutex );
        ring_enqueue( r, i + 1 );
        pthread_mutex_unlock( &mutex );
    }
    return 0;
}

void *reader_two( void *arg ) {
    Ring *r = arg;
    long val = 0, i = 0;
    int read[ 8 ] = { 0 };
    while ( i < 2 * 8 ) {
        if ( ring_empty( r ) )
            continue;
        val = ring_dequeue( r );
        (!(val > 0) ? reach_error() : (void)0);
        (!(val <= 8) ? reach_error() : (void)0);
        ++read[ val - 1 ];
        for ( int i = 0; i < val; ++i ) {
            (!(read[ i ] <= 2) ? reach_error() : (void)0);
            (!(read[ i ] > 0) ? reach_error() : (void)0);
        }
        ++i;
    }
    return 0;
}

int main() {
    pthread_t reader, writer;
    Ring r;
    ring_init( &r );
    pthread_create( &reader, NULL, &reader_two, &r );
    pthread_create( &writer, NULL, &writer_fn, &r );
    writer_fn( &r );
    long status;
    pthread_join( reader, NULL );
    pthread_join( writer, NULL );
}
