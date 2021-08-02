extern void abort(void);
void reach_error(){}
extern int __VERIFIER_nondet_int(void);
















extern int *__errno_location (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));





typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;







typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;



typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;




typedef __loff_t loff_t;



typedef __ino_t ino_t;
typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;





typedef __off_t off_t;
typedef __pid_t pid_t;





typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;










typedef __clock_t clock_t;







typedef __clockid_t clockid_t;






typedef __time_t time_t;






typedef __timer_t timer_t;
typedef long unsigned int size_t;



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;




typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
typedef unsigned int u_int8_t __attribute__ ((__mode__ (__QI__)));
typedef unsigned int u_int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int u_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int u_int64_t __attribute__ ((__mode__ (__DI__)));

typedef int register_t __attribute__ ((__mode__ (__word__)));






static __inline unsigned int
__bswap_32 (unsigned int __bsx)
{
  return __builtin_bswap32 (__bsx);
}
static __inline __uint64_t
__bswap_64 (__uint64_t __bsx)
{
  return __builtin_bswap64 (__bsx);
}
static __inline __uint16_t
__uint16_identity (__uint16_t __x)
{
  return __x;
}

static __inline __uint32_t
__uint32_identity (__uint32_t __x)
{
  return __x;
}

static __inline __uint64_t
__uint64_identity (__uint64_t __x)
{
  return __x;
}











typedef struct
{
  unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
} __sigset_t;


typedef __sigset_t sigset_t;










struct timeval
{
  __time_t tv_sec;
  __suseconds_t tv_usec;
};

struct timespec
{
  __time_t tv_sec;
  __syscall_slong_t tv_nsec;
};



typedef __suseconds_t suseconds_t;





typedef long int __fd_mask;
typedef struct
  {






    __fd_mask __fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];


  } fd_set;






typedef __fd_mask fd_mask;

extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);










extern unsigned int gnu_dev_major (__dev_t __dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern unsigned int gnu_dev_minor (__dev_t __dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern __dev_t gnu_dev_makedev (unsigned int __major, unsigned int __minor) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));







typedef __blksize_t blksize_t;






typedef __blkcnt_t blkcnt_t;



typedef __fsblkcnt_t fsblkcnt_t;



typedef __fsfilcnt_t fsfilcnt_t;
struct __pthread_rwlock_arch_t
{
  unsigned int __readers;
  unsigned int __writers;
  unsigned int __wrphase_futex;
  unsigned int __writers_futex;
  unsigned int __pad3;
  unsigned int __pad4;

  int __cur_writer;
  int __shared;
  signed char __rwelision;




  unsigned char __pad1[7];


  unsigned long int __pad2;


  unsigned int __flags;
};




typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;
struct __pthread_mutex_s
{
  int __lock ;
  unsigned int __count;
  int __owner;

  unsigned int __nusers;
  int __kind;
 




  short __spins; short __elision;
  __pthread_list_t __list;
 
};




struct __pthread_cond_s
{
  __extension__ union
  {
    __extension__ unsigned long long int __wseq;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __wseq32;
  };
  __extension__ union
  {
    __extension__ unsigned long long int __g1_start;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __g1_start32;
  };
  unsigned int __g_refs[2] ;
  unsigned int __g_size[2];
  unsigned int __g1_orig_size;
  unsigned int __wrefs;
  unsigned int __g_signals[2];
};



typedef unsigned long int pthread_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;


union pthread_attr_t
{
  char __size[56];
  long int __align;
};

typedef union pthread_attr_t pthread_attr_t;




typedef union
{
  struct __pthread_mutex_s __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;


typedef union
{
  struct __pthread_cond_s __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;





typedef union
{
  struct __pthread_rwlock_arch_t __data;
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;









typedef struct bounded_buf_tag
{
    int valid;

    pthread_mutex_t mutex;
    pthread_cond_t not_full;
    pthread_cond_t not_empty;

    size_t item_num;
    size_t max_size;
    size_t head, rear;

    size_t p_wait;
    size_t c_wait;

    void ** buf;
}bounded_buf_t;
int bounded_buf_init(bounded_buf_t * bbuf, size_t sz)
{
    int status = 0;

    if (bbuf == NULL) return 
                            22
                                  ;

    bbuf->valid = 0xACDEFA;

    status = pthread_mutex_init(&bbuf->mutex, NULL);
    if (status != 0) return status;

    status = pthread_cond_init(&bbuf->not_full, NULL);
    if (status != 0)
    {
        pthread_mutex_destroy(&bbuf->mutex);
        return status;
    }

    status = pthread_cond_init(&bbuf->not_empty, NULL);
    if (status != 0)
    {
        pthread_cond_destroy(&bbuf->not_full);
        pthread_mutex_destroy(&bbuf->mutex);
        return status;
    }

    bbuf->item_num = 0;
    bbuf->max_size = sz;
    bbuf->head = 0;
    bbuf->rear = 0;
    bbuf->buf = calloc( sz, sizeof(void*) );
    if (bbuf->buf == NULL)
    {
        pthread_mutex_destroy(&bbuf->mutex);
        pthread_cond_destroy(&bbuf->not_full);
        pthread_cond_destroy(&bbuf->not_empty);
        return 
              12
                    ;
    }


    bbuf->head = 0;
    bbuf->rear = 0;
    bbuf->p_wait = 0;
    bbuf->c_wait = 0;
    return 0;
}


int bounded_buf_destroy(bounded_buf_t * bbuf)
{
    int status = 0, status1 = 0, status2 = 0;

    if (bbuf == NULL || bbuf->valid != 0xACDEFA)
        return 
              22
                    ;

    status = pthread_mutex_lock(&bbuf->mutex);
    if (status != 0) return status;

    bbuf->valid = 0;
    status = pthread_mutex_unlock(&bbuf->mutex);
    if (status != 0) return status;

    status = pthread_mutex_destroy(&bbuf->mutex);
    status1= pthread_cond_destroy(&bbuf->not_full);
    status2= pthread_cond_destroy(&bbuf->not_empty);

    int i;
    if (bbuf->rear >= bbuf->head ) {
        for (i = bbuf->head; i < bbuf->rear; i++) free(bbuf->buf[i]);
    }
    else{
        for (i = bbuf->head; i < bbuf->max_size; i++) free(bbuf->buf[i]);
        for (i = 0; i < bbuf->rear; i++) free(bbuf->buf[i]);
    }

    free(bbuf->buf);
    return (status != 0)? status:((status1 != 0)? status1 : status2);
}


void bounded_buf_putcleanup(void * arg)
{
    bounded_buf_t * bbuf = (bounded_buf_t*) arg;
    bbuf->p_wait--;
    pthread_mutex_unlock(&bbuf->mutex);
}


void bounded_buf_getcleanup(void *arg)
{
    bounded_buf_t * bbuf = (bounded_buf_t*) arg;
    bbuf->c_wait--;
    pthread_mutex_unlock(&bbuf->mutex);
}

int bounded_buf_put(bounded_buf_t * bbuf, void *item)
{
    int status = 0, status1 = 0, status2 = 0;

    if (bbuf == NULL || bbuf->valid != 0xACDEFA)
        return 
              22
                    ;

    status = pthread_mutex_lock(&bbuf->mutex);
    ;
    if (status != 0) return status;


    if ( (bbuf->rear + 1)% bbuf->max_size == bbuf->head )
    {
        bbuf->p_wait++;

        while ( (bbuf->rear + 1)% bbuf->max_size == bbuf->head ){
            ;
            status = pthread_cond_wait(&bbuf->not_full, &bbuf->mutex);
            if (status != 0) break;
        }

        bbuf->p_wait--;
    }

    if (status == 0){
        bbuf->buf[bbuf->rear]= item;
        bbuf->rear = (bbuf->rear+1)% (bbuf->max_size);
        if (bbuf->c_wait > 0){
            ;
            status1 = pthread_cond_signal(&bbuf->not_empty);
        }
    }
    ;
    status2 = pthread_mutex_unlock(&bbuf->mutex);
    return (status == 0)? status2 : status;
}


int bounded_buf_get(bounded_buf_t *bbuf, void **item)
{
    int status = 0,status1 = 0, status2 = 0;

    if (bbuf == NULL || item == NULL || bbuf->valid != 0xACDEFA)
        return 
              22
                    ;

    status = pthread_mutex_lock(&bbuf->mutex);
    ;
    if (status != 0) return status;

    if (bbuf->head == bbuf->rear)
    {
        bbuf->c_wait++;


        while (bbuf->head == bbuf->rear)
        {
            ;
            status = pthread_cond_wait(&bbuf->not_empty, &bbuf->mutex);
            if (status != 0) break;
        }


        bbuf->c_wait--;
    }


    ;
    status = pthread_mutex_unlock(&bbuf->mutex);

    status = pthread_mutex_lock(&bbuf->mutex);
    ;

    if (status == 0)
    {
        if(bbuf->head == bbuf->rear)
        {
            ERROR: {reach_error();abort();}
        }
        *item = bbuf->buf[bbuf->head];
        bbuf->head = (bbuf->head+1) % bbuf->max_size;

        if (bbuf->p_wait > 0){
            ;
            status1 = pthread_cond_signal(&bbuf->not_full);
        }
    }


    ;
    status2 = pthread_mutex_unlock(&bbuf->mutex);
    return (status != 0)? status : (status1 != 0)? status1 : status2;
}
int bounded_buf_is_empty(bounded_buf_t* bbuf)
{
    int status = 0, retval;

    if (bbuf == NULL || bbuf->valid != 0xACDEFA)
        return -1;


    status = pthread_mutex_lock(&bbuf->mutex);
    if (status != 0) return status;

    retval = (bbuf->rear == bbuf->head )? 1 : 0;


    status = pthread_mutex_unlock(&bbuf->mutex);

    return (status == 0)? retval : -1;
}


int bounded_buf_is_full(bounded_buf_t* bbuf)
{
    int status = 0, retval;

    if (bbuf == NULL || bbuf->valid != 0xACDEFA) return -1;

    status = pthread_mutex_lock(&bbuf->mutex);
    if (status != 0) return status;

    retval = ( (bbuf->rear + 1) % bbuf->max_size == bbuf->head )? 1 : 0;
    status = pthread_mutex_unlock(&bbuf->mutex);
    return (status == 0)? retval : -1;
}





typedef struct thread_tag
{
    pthread_t pid;
    int id;
    bounded_buf_t * bbuf;
}thread_t;


void * producer_routine(void *arg)
{
    thread_t * thread = (thread_t*) arg;

    int i, temp;
    int ch;
    int status = 0;

    for (i = 0; i < 4; i++)
    {

        ch = __VERIFIER_nondet_int();
        temp = ch;
        status = bounded_buf_put(thread->bbuf, (void*)((int)temp));

        if (status != 0)
           
                                                         ;
        else
            ;

        fflush(stdout);

    }

    return NULL;
}


void * consumer_routine(void * arg)
{

    thread_t * thread = (thread_t*) arg;

    int i;
    int ch;
    int status = 0;

    void* temp;

    for (i = 0; i < 4; i++)
    {
        status = bounded_buf_get(thread->bbuf, &temp);

        if (status != 0)
           
                                             ;
        else
        {
            ch = (char)( (int)temp );
            ;
        }
        fflush(stdout);

    }
    return NULL;
}


int main(void)
{
    thread_t producers[2];
    thread_t consumers[2];
    int i;

    bounded_buf_t buffer;
    bounded_buf_init(&buffer, 3);

    for (i = 0; i < 2; i++)
    {
        producers[i].id = i;
        producers[i].bbuf = &buffer;
        pthread_create(&producers[i].pid, NULL, producer_routine, (void*)&producers[i]);
    }

    for (i = 0; i < 2; i++)
    {
        consumers[i].id = i;
        consumers[i].bbuf = &buffer;
        pthread_create(&consumers[i].pid, NULL, consumer_routine, (void*)&consumers[i]);
    }


    for (i = 0; i < 2; i++)
        pthread_join(producers[i].pid, NULL);

    for (i = 0; i < 2; i++)
        pthread_join(consumers[i].pid, NULL);

    bounded_buf_destroy(&buffer);
    return 0;
}
