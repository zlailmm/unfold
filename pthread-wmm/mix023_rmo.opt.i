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


int y;


int y = 0;


_Bool y$flush_delayed;


int y$mem_tmp;


_Bool y$r_buff0_thd0;


_Bool y$r_buff0_thd1;


_Bool y$r_buff0_thd2;


_Bool y$r_buff0_thd3;


_Bool y$r_buff0_thd4;


_Bool y$r_buff1_thd0;


_Bool y$r_buff1_thd1;


_Bool y$r_buff1_thd2;


_Bool y$r_buff1_thd3;


_Bool y$r_buff1_thd4;


_Bool y$read_delayed;


int *y$read_delayed_var;


int y$w_buff0;


_Bool y$w_buff0_used;


int y$w_buff1;


_Bool y$w_buff1_used;


int z;


int z = 0;


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
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P1(void *arg)
{
  __VERIFIER_atomic_begin();
  x = 2;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p1_EAX = x;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  weak$$choice0 = __VERIFIER_nondet_bool();
  weak$$choice2 = __VERIFIER_nondet_bool();
  y$flush_delayed = weak$$choice2;
  y$mem_tmp = y;
  y = !y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y : (y$w_buff0_used && y$r_buff0_thd2 ? y$w_buff0 : y$w_buff1);
  y$w_buff0 = weak$$choice2 ? y$w_buff0 : (!y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y$w_buff0 : (y$w_buff0_used && y$r_buff0_thd2 ? y$w_buff0 : y$w_buff0));
  y$w_buff1 = weak$$choice2 ? y$w_buff1 : (!y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y$w_buff1 : (y$w_buff0_used && y$r_buff0_thd2 ? y$w_buff1 : y$w_buff1));
  y$w_buff0_used = weak$$choice2 ? y$w_buff0_used : (!y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y$w_buff0_used : (y$w_buff0_used && y$r_buff0_thd2 ? (_Bool)0 : y$w_buff0_used));
  y$w_buff1_used = weak$$choice2 ? y$w_buff1_used : (!y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y$w_buff1_used : (y$w_buff0_used && y$r_buff0_thd2 ? (_Bool)0 : (_Bool)0));
  y$r_buff0_thd2 = weak$$choice2 ? y$r_buff0_thd2 : (!y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y$r_buff0_thd2 : (y$w_buff0_used && y$r_buff0_thd2 ? (_Bool)0 : y$r_buff0_thd2));
  y$r_buff1_thd2 = weak$$choice2 ? y$r_buff1_thd2 : (!y$w_buff0_used || !y$r_buff0_thd2 && !y$w_buff1_used || !y$r_buff0_thd2 && !y$r_buff1_thd2 ? y$r_buff1_thd2 : (y$w_buff0_used && y$r_buff0_thd2 ? (_Bool)0 : (_Bool)0));
  __unbuffered_p1_EBX = y;
  y = y$flush_delayed ? y$mem_tmp : y;
  y$flush_delayed = (_Bool)0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P2(void *arg)
{
  __VERIFIER_atomic_begin();
  y$w_buff1 = y$w_buff0;
  y$w_buff0 = 1;
  y$w_buff1_used = y$w_buff0_used;
  y$w_buff0_used = (_Bool)1;
  __VERIFIER_assert(!(y$w_buff1_used && y$w_buff0_used));
  y$r_buff1_thd0 = y$r_buff0_thd0;
  y$r_buff1_thd1 = y$r_buff0_thd1;
  y$r_buff1_thd2 = y$r_buff0_thd2;
  y$r_buff1_thd3 = y$r_buff0_thd3;
  y$r_buff1_thd4 = y$r_buff0_thd4;
  y$r_buff0_thd3 = (_Bool)1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  z = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  y = y$w_buff0_used && y$r_buff0_thd3 ? y$w_buff0 : (y$w_buff1_used && y$r_buff1_thd3 ? y$w_buff1 : y);
  y$w_buff0_used = y$w_buff0_used && y$r_buff0_thd3 ? (_Bool)0 : y$w_buff0_used;
  y$w_buff1_used = y$w_buff0_used && y$r_buff0_thd3 || y$w_buff1_used && y$r_buff1_thd3 ? (_Bool)0 : y$w_buff1_used;
  y$r_buff0_thd3 = y$w_buff0_used && y$r_buff0_thd3 ? (_Bool)0 : y$r_buff0_thd3;
  y$r_buff1_thd3 = y$w_buff0_used && y$r_buff0_thd3 || y$w_buff1_used && y$r_buff1_thd3 ? (_Bool)0 : y$r_buff1_thd3;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P3(void *arg)
{
  __VERIFIER_atomic_begin();
  z = 2;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p3_EAX = z;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p3_EBX = a;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  y = y$w_buff0_used && y$r_buff0_thd4 ? y$w_buff0 : (y$w_buff1_used && y$r_buff1_thd4 ? y$w_buff1 : y);
  y$w_buff0_used = y$w_buff0_used && y$r_buff0_thd4 ? (_Bool)0 : y$w_buff0_used;
  y$w_buff1_used = y$w_buff0_used && y$r_buff0_thd4 || y$w_buff1_used && y$r_buff1_thd4 ? (_Bool)0 : y$w_buff1_used;
  y$r_buff0_thd4 = y$w_buff0_used && y$r_buff0_thd4 ? (_Bool)0 : y$r_buff0_thd4;
  y$r_buff1_thd4 = y$w_buff0_used && y$r_buff0_thd4 || y$w_buff1_used && y$r_buff1_thd4 ? (_Bool)0 : y$r_buff1_thd4;
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
  pthread_t t621;
  pthread_create(&t621, ((void*)0), P0, ((void*)0));
  pthread_t t622;
  pthread_create(&t622, ((void*)0), P1, ((void*)0));
  pthread_t t623;
  pthread_create(&t623, ((void*)0), P2, ((void*)0));
  pthread_t t624;
  pthread_create(&t624, ((void*)0), P3, ((void*)0));
  __VERIFIER_atomic_begin();
  main$tmp_guard0 = __unbuffered_cnt == 4;
  __VERIFIER_atomic_end();
  assume_abort_if_not(main$tmp_guard0);
  __VERIFIER_atomic_begin();
  y = y$w_buff0_used && y$r_buff0_thd0 ? y$w_buff0 : (y$w_buff1_used && y$r_buff1_thd0 ? y$w_buff1 : y);
  y$w_buff0_used = y$w_buff0_used && y$r_buff0_thd0 ? (_Bool)0 : y$w_buff0_used;
  y$w_buff1_used = y$w_buff0_used && y$r_buff0_thd0 || y$w_buff1_used && y$r_buff1_thd0 ? (_Bool)0 : y$w_buff1_used;
  y$r_buff0_thd0 = y$w_buff0_used && y$r_buff0_thd0 ? (_Bool)0 : y$r_buff0_thd0;
  y$r_buff1_thd0 = y$w_buff0_used && y$r_buff0_thd0 || y$w_buff1_used && y$r_buff1_thd0 ? (_Bool)0 : y$r_buff1_thd0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();

  main$tmp_guard1 = !(x == 2 && z == 2 && __unbuffered_p1_EAX == 2 && __unbuffered_p1_EBX == 0 && __unbuffered_p3_EAX == 2 && __unbuffered_p3_EBX == 0);
  __VERIFIER_atomic_end();

  __VERIFIER_assert(main$tmp_guard1);
  return 0;
}
