extern void abort(void);
void assume_abort_if_not(int cond) {
  if(!cond) {abort();}
}
extern _Bool __VERIFIER_nondet_bool(void);
extern void abort(void);
void reach_error(){}
void __VERIFIER_assert(int expression) { if (!expression) { ERROR: {reach_error();abort();} }; return; }
extern void __VERIFIER_atomic_begin();
extern void __VERIFIER_atomic_end();

void * P0(void *arg);


void * P1(void *arg);


void * P2(void *arg);


void * P3(void *arg);


void fence();


void isync();


void lwfence();




int __unbuffered_cnt;


int __unbuffered_cnt = 0;


int __unbuffered_p1_EAX;


int __unbuffered_p1_EAX = 0;


int __unbuffered_p1_EBX;


int __unbuffered_p1_EBX = 0;


int __unbuffered_p3_EAX;


int __unbuffered_p3_EAX = 0;


int __unbuffered_p3_EBX;


int __unbuffered_p3_EBX = 0;


int a;


int a = 0;


_Bool main$tmp_guard0;


_Bool main$tmp_guard1;


int x;


int x = 0;


_Bool x$flush_delayed;


int x$mem_tmp;


_Bool x$r_buff0_thd0;


_Bool x$r_buff0_thd1;


_Bool x$r_buff0_thd2;


_Bool x$r_buff0_thd3;


_Bool x$r_buff0_thd4;


_Bool x$r_buff1_thd0;


_Bool x$r_buff1_thd1;


_Bool x$r_buff1_thd2;


_Bool x$r_buff1_thd3;


_Bool x$r_buff1_thd4;


_Bool x$read_delayed;


int *x$read_delayed_var;


int x$w_buff0;


_Bool x$w_buff0_used;


int x$w_buff1;


_Bool x$w_buff1_used;


int y;


int y = 0;


int z;


int z = 0;


_Bool z$flush_delayed;


int z$mem_tmp;


_Bool z$r_buff0_thd0;


_Bool z$r_buff0_thd1;


_Bool z$r_buff0_thd2;


_Bool z$r_buff0_thd3;


_Bool z$r_buff0_thd4;


_Bool z$r_buff1_thd0;


_Bool z$r_buff1_thd1;


_Bool z$r_buff1_thd2;


_Bool z$r_buff1_thd3;


_Bool z$r_buff1_thd4;


_Bool z$read_delayed;


int *z$read_delayed_var;


int z$w_buff0;


_Bool z$w_buff0_used;


int z$w_buff1;


_Bool z$w_buff1_used;


_Bool weak$$choice0;


_Bool weak$$choice2;



void * P0(void *arg)
{
  __VERIFIER_atomic_begin();
  a = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  x = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  x = x$w_buff0_used && x$r_buff0_thd1 ? x$w_buff0 : (x$w_buff1_used && x$r_buff1_thd1 ? x$w_buff1 : x);
  x$w_buff0_used = x$w_buff0_used && x$r_buff0_thd1 ? (_Bool)0 : x$w_buff0_used;
  x$w_buff1_used = x$w_buff0_used && x$r_buff0_thd1 || x$w_buff1_used && x$r_buff1_thd1 ? (_Bool)0 : x$w_buff1_used;
  x$r_buff0_thd1 = x$w_buff0_used && x$r_buff0_thd1 ? (_Bool)0 : x$r_buff0_thd1;
  x$r_buff1_thd1 = x$w_buff0_used && x$r_buff0_thd1 || x$w_buff1_used && x$r_buff1_thd1 ? (_Bool)0 : x$r_buff1_thd1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P1(void *arg)
{
  __VERIFIER_atomic_begin();
  x$w_buff1 = x$w_buff0;
  x$w_buff0 = 2;
  x$w_buff1_used = x$w_buff0_used;
  x$w_buff0_used = (_Bool)1;
  __VERIFIER_assert(!(x$w_buff1_used && x$w_buff0_used));
  x$r_buff1_thd0 = x$r_buff0_thd0;
  x$r_buff1_thd1 = x$r_buff0_thd1;
  x$r_buff1_thd2 = x$r_buff0_thd2;
  x$r_buff1_thd3 = x$r_buff0_thd3;
  x$r_buff1_thd4 = x$r_buff0_thd4;
  x$r_buff0_thd2 = (_Bool)1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  weak$$choice0 = __VERIFIER_nondet_bool();
  weak$$choice2 = __VERIFIER_nondet_bool();
  x$flush_delayed = weak$$choice2;
  x$mem_tmp = x;
  x = !x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x : (x$w_buff0_used && x$r_buff0_thd2 ? x$w_buff0 : x$w_buff1);
  x$w_buff0 = weak$$choice2 ? x$w_buff0 : (!x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x$w_buff0 : (x$w_buff0_used && x$r_buff0_thd2 ? x$w_buff0 : x$w_buff0));
  x$w_buff1 = weak$$choice2 ? x$w_buff1 : (!x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x$w_buff1 : (x$w_buff0_used && x$r_buff0_thd2 ? x$w_buff1 : x$w_buff1));
  x$w_buff0_used = weak$$choice2 ? x$w_buff0_used : (!x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x$w_buff0_used : (x$w_buff0_used && x$r_buff0_thd2 ? (_Bool)0 : x$w_buff0_used));
  x$w_buff1_used = weak$$choice2 ? x$w_buff1_used : (!x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x$w_buff1_used : (x$w_buff0_used && x$r_buff0_thd2 ? (_Bool)0 : (_Bool)0));
  x$r_buff0_thd2 = weak$$choice2 ? x$r_buff0_thd2 : (!x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x$r_buff0_thd2 : (x$w_buff0_used && x$r_buff0_thd2 ? (_Bool)0 : x$r_buff0_thd2));
  x$r_buff1_thd2 = weak$$choice2 ? x$r_buff1_thd2 : (!x$w_buff0_used || !x$r_buff0_thd2 && !x$w_buff1_used || !x$r_buff0_thd2 && !x$r_buff1_thd2 ? x$r_buff1_thd2 : (x$w_buff0_used && x$r_buff0_thd2 ? (_Bool)0 : (_Bool)0));
  __unbuffered_p1_EAX = x;
  x = x$flush_delayed ? x$mem_tmp : x;
  x$flush_delayed = (_Bool)0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p1_EBX = y;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  x = x$w_buff0_used && x$r_buff0_thd2 ? x$w_buff0 : (x$w_buff1_used && x$r_buff1_thd2 ? x$w_buff1 : x);
  x$w_buff0_used = x$w_buff0_used && x$r_buff0_thd2 ? (_Bool)0 : x$w_buff0_used;
  x$w_buff1_used = x$w_buff0_used && x$r_buff0_thd2 || x$w_buff1_used && x$r_buff1_thd2 ? (_Bool)0 : x$w_buff1_used;
  x$r_buff0_thd2 = x$w_buff0_used && x$r_buff0_thd2 ? (_Bool)0 : x$r_buff0_thd2;
  x$r_buff1_thd2 = x$w_buff0_used && x$r_buff0_thd2 || x$w_buff1_used && x$r_buff1_thd2 ? (_Bool)0 : x$r_buff1_thd2;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P2(void *arg)
{
  __VERIFIER_atomic_begin();
  y = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  z = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  x = x$w_buff0_used && x$r_buff0_thd3 ? x$w_buff0 : (x$w_buff1_used && x$r_buff1_thd3 ? x$w_buff1 : x);
  x$w_buff0_used = x$w_buff0_used && x$r_buff0_thd3 ? (_Bool)0 : x$w_buff0_used;
  x$w_buff1_used = x$w_buff0_used && x$r_buff0_thd3 || x$w_buff1_used && x$r_buff1_thd3 ? (_Bool)0 : x$w_buff1_used;
  x$r_buff0_thd3 = x$w_buff0_used && x$r_buff0_thd3 ? (_Bool)0 : x$r_buff0_thd3;
  x$r_buff1_thd3 = x$w_buff0_used && x$r_buff0_thd3 || x$w_buff1_used && x$r_buff1_thd3 ? (_Bool)0 : x$r_buff1_thd3;
  z = z$w_buff0_used && z$r_buff0_thd3 ? z$w_buff0 : (z$w_buff1_used && z$r_buff1_thd3 ? z$w_buff1 : z);
  z$w_buff0_used = z$w_buff0_used && z$r_buff0_thd3 ? (_Bool)0 : z$w_buff0_used;
  z$w_buff1_used = z$w_buff0_used && z$r_buff0_thd3 || z$w_buff1_used && z$r_buff1_thd3 ? (_Bool)0 : z$w_buff1_used;
  z$r_buff0_thd3 = z$w_buff0_used && z$r_buff0_thd3 ? (_Bool)0 : z$r_buff0_thd3;
  z$r_buff1_thd3 = z$w_buff0_used && z$r_buff0_thd3 || z$w_buff1_used && z$r_buff1_thd3 ? (_Bool)0 : z$r_buff1_thd3;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P3(void *arg)
{
  __VERIFIER_atomic_begin();
  z$w_buff1 = z$w_buff0;
  z$w_buff0 = 2;
  z$w_buff1_used = z$w_buff0_used;
  z$w_buff0_used = (_Bool)1;
  __VERIFIER_assert(!(z$w_buff1_used && z$w_buff0_used));
  z$r_buff1_thd0 = z$r_buff0_thd0;
  z$r_buff1_thd1 = z$r_buff0_thd1;
  z$r_buff1_thd2 = z$r_buff0_thd2;
  z$r_buff1_thd3 = z$r_buff0_thd3;
  z$r_buff1_thd4 = z$r_buff0_thd4;
  z$r_buff0_thd4 = (_Bool)1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  weak$$choice0 = __VERIFIER_nondet_bool();
  weak$$choice2 = __VERIFIER_nondet_bool();
  z$flush_delayed = weak$$choice2;
  z$mem_tmp = z;
  z = !z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z : (z$w_buff0_used && z$r_buff0_thd4 ? z$w_buff0 : z$w_buff1);
  z$w_buff0 = weak$$choice2 ? z$w_buff0 : (!z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z$w_buff0 : (z$w_buff0_used && z$r_buff0_thd4 ? z$w_buff0 : z$w_buff0));
  z$w_buff1 = weak$$choice2 ? z$w_buff1 : (!z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z$w_buff1 : (z$w_buff0_used && z$r_buff0_thd4 ? z$w_buff1 : z$w_buff1));
  z$w_buff0_used = weak$$choice2 ? z$w_buff0_used : (!z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z$w_buff0_used : (z$w_buff0_used && z$r_buff0_thd4 ? (_Bool)0 : z$w_buff0_used));
  z$w_buff1_used = weak$$choice2 ? z$w_buff1_used : (!z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z$w_buff1_used : (z$w_buff0_used && z$r_buff0_thd4 ? (_Bool)0 : (_Bool)0));
  z$r_buff0_thd4 = weak$$choice2 ? z$r_buff0_thd4 : (!z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z$r_buff0_thd4 : (z$w_buff0_used && z$r_buff0_thd4 ? (_Bool)0 : z$r_buff0_thd4));
  z$r_buff1_thd4 = weak$$choice2 ? z$r_buff1_thd4 : (!z$w_buff0_used || !z$r_buff0_thd4 && !z$w_buff1_used || !z$r_buff0_thd4 && !z$r_buff1_thd4 ? z$r_buff1_thd4 : (z$w_buff0_used && z$r_buff0_thd4 ? (_Bool)0 : (_Bool)0));
  __unbuffered_p3_EAX = z;
  z = z$flush_delayed ? z$mem_tmp : z;
  z$flush_delayed = (_Bool)0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p3_EBX = a;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  x = x$w_buff0_used && x$r_buff0_thd4 ? x$w_buff0 : (x$w_buff1_used && x$r_buff1_thd4 ? x$w_buff1 : x);
  x$w_buff0_used = x$w_buff0_used && x$r_buff0_thd4 ? (_Bool)0 : x$w_buff0_used;
  x$w_buff1_used = x$w_buff0_used && x$r_buff0_thd4 || x$w_buff1_used && x$r_buff1_thd4 ? (_Bool)0 : x$w_buff1_used;
  x$r_buff0_thd4 = x$w_buff0_used && x$r_buff0_thd4 ? (_Bool)0 : x$r_buff0_thd4;
  x$r_buff1_thd4 = x$w_buff0_used && x$r_buff0_thd4 || x$w_buff1_used && x$r_buff1_thd4 ? (_Bool)0 : x$r_buff1_thd4;
  z = z$w_buff0_used && z$r_buff0_thd4 ? z$w_buff0 : (z$w_buff1_used && z$r_buff1_thd4 ? z$w_buff1 : z);
  z$w_buff0_used = z$w_buff0_used && z$r_buff0_thd4 ? (_Bool)0 : z$w_buff0_used;
  z$w_buff1_used = z$w_buff0_used && z$r_buff0_thd4 || z$w_buff1_used && z$r_buff1_thd4 ? (_Bool)0 : z$w_buff1_used;
  z$r_buff0_thd4 = z$w_buff0_used && z$r_buff0_thd4 ? (_Bool)0 : z$r_buff0_thd4;
  z$r_buff1_thd4 = z$w_buff0_used && z$r_buff0_thd4 || z$w_buff1_used && z$r_buff1_thd4 ? (_Bool)0 : z$r_buff1_thd4;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void fence()
{

}



void isync()
{

}



void lwfence()
{

}



int main()
{
  pthread_t t625;
  pthread_create(&t625, ((void*)0), P0, ((void*)0));
  pthread_t t626;
  pthread_create(&t626, ((void*)0), P1, ((void*)0));
  pthread_t t627;
  pthread_create(&t627, ((void*)0), P2, ((void*)0));
  pthread_t t628;
  pthread_create(&t628, ((void*)0), P3, ((void*)0));
  __VERIFIER_atomic_begin();
  main$tmp_guard0 = __unbuffered_cnt == 4;
  __VERIFIER_atomic_end();
  assume_abort_if_not(main$tmp_guard0);
  __VERIFIER_atomic_begin();
  x = x$w_buff0_used && x$r_buff0_thd0 ? x$w_buff0 : (x$w_buff1_used && x$r_buff1_thd0 ? x$w_buff1 : x);
  x$w_buff0_used = x$w_buff0_used && x$r_buff0_thd0 ? (_Bool)0 : x$w_buff0_used;
  x$w_buff1_used = x$w_buff0_used && x$r_buff0_thd0 || x$w_buff1_used && x$r_buff1_thd0 ? (_Bool)0 : x$w_buff1_used;
  x$r_buff0_thd0 = x$w_buff0_used && x$r_buff0_thd0 ? (_Bool)0 : x$r_buff0_thd0;
  x$r_buff1_thd0 = x$w_buff0_used && x$r_buff0_thd0 || x$w_buff1_used && x$r_buff1_thd0 ? (_Bool)0 : x$r_buff1_thd0;
  z = z$w_buff0_used && z$r_buff0_thd0 ? z$w_buff0 : (z$w_buff1_used && z$r_buff1_thd0 ? z$w_buff1 : z);
  z$w_buff0_used = z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : z$w_buff0_used;
  z$w_buff1_used = z$w_buff0_used && z$r_buff0_thd0 || z$w_buff1_used && z$r_buff1_thd0 ? (_Bool)0 : z$w_buff1_used;
  z$r_buff0_thd0 = z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : z$r_buff0_thd0;
  z$r_buff1_thd0 = z$w_buff0_used && z$r_buff0_thd0 || z$w_buff1_used && z$r_buff1_thd0 ? (_Bool)0 : z$r_buff1_thd0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();

  weak$$choice0 = __VERIFIER_nondet_bool();

  weak$$choice2 = __VERIFIER_nondet_bool();

  z$flush_delayed = weak$$choice2;

  z$mem_tmp = z;

  z = !z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z : (z$w_buff0_used && z$r_buff0_thd0 ? z$w_buff0 : z$w_buff1);

  z$w_buff0 = weak$$choice2 ? z$w_buff0 : (!z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z$w_buff0 : (z$w_buff0_used && z$r_buff0_thd0 ? z$w_buff0 : z$w_buff0));

  z$w_buff1 = weak$$choice2 ? z$w_buff1 : (!z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z$w_buff1 : (z$w_buff0_used && z$r_buff0_thd0 ? z$w_buff1 : z$w_buff1));

  z$w_buff0_used = weak$$choice2 ? z$w_buff0_used : (!z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z$w_buff0_used : (z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : z$w_buff0_used));

  z$w_buff1_used = weak$$choice2 ? z$w_buff1_used : (!z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z$w_buff1_used : (z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : (_Bool)0));

  z$r_buff0_thd0 = weak$$choice2 ? z$r_buff0_thd0 : (!z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z$r_buff0_thd0 : (z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : z$r_buff0_thd0));

  z$r_buff1_thd0 = weak$$choice2 ? z$r_buff1_thd0 : (!z$w_buff0_used || !z$r_buff0_thd0 && !z$w_buff1_used || !z$r_buff0_thd0 && !z$r_buff1_thd0 ? z$r_buff1_thd0 : (z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : (_Bool)0));

  weak$$choice0 = __VERIFIER_nondet_bool();

  weak$$choice2 = __VERIFIER_nondet_bool();

  x$flush_delayed = weak$$choice2;

  x$mem_tmp = x;

  x = !x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x : (x$w_buff0_used && x$r_buff0_thd0 ? x$w_buff0 : x$w_buff1);

  x$w_buff0 = weak$$choice2 ? x$w_buff0 : (!x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x$w_buff0 : (x$w_buff0_used && x$r_buff0_thd0 ? x$w_buff0 : x$w_buff0));

  x$w_buff1 = weak$$choice2 ? x$w_buff1 : (!x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x$w_buff1 : (x$w_buff0_used && x$r_buff0_thd0 ? x$w_buff1 : x$w_buff1));

  x$w_buff0_used = weak$$choice2 ? x$w_buff0_used : (!x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x$w_buff0_used : (x$w_buff0_used && x$r_buff0_thd0 ? (_Bool)0 : x$w_buff0_used));

  x$w_buff1_used = weak$$choice2 ? x$w_buff1_used : (!x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x$w_buff1_used : (x$w_buff0_used && x$r_buff0_thd0 ? (_Bool)0 : (_Bool)0));

  x$r_buff0_thd0 = weak$$choice2 ? x$r_buff0_thd0 : (!x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x$r_buff0_thd0 : (x$w_buff0_used && x$r_buff0_thd0 ? (_Bool)0 : x$r_buff0_thd0));

  x$r_buff1_thd0 = weak$$choice2 ? x$r_buff1_thd0 : (!x$w_buff0_used || !x$r_buff0_thd0 && !x$w_buff1_used || !x$r_buff0_thd0 && !x$r_buff1_thd0 ? x$r_buff1_thd0 : (x$w_buff0_used && x$r_buff0_thd0 ? (_Bool)0 : (_Bool)0));

  main$tmp_guard1 = !(x == 2 && z == 2 && __unbuffered_p1_EAX == 2 && __unbuffered_p1_EBX == 0 && __unbuffered_p3_EAX == 2 && __unbuffered_p3_EBX == 0);

  z = z$flush_delayed ? z$mem_tmp : z;

  z$flush_delayed = (_Bool)0;

  x = x$flush_delayed ? x$mem_tmp : x;

  x$flush_delayed = (_Bool)0;
  __VERIFIER_atomic_end();

  __VERIFIER_assert(main$tmp_guard1);
  return 0;
}
