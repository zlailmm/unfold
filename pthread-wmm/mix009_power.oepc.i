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


void fence();


void isync();


void lwfence();




int __unbuffered_cnt;


int __unbuffered_cnt = 0;


int __unbuffered_p0_EAX;


int __unbuffered_p0_EAX = 0;


int __unbuffered_p0_EBX;


int __unbuffered_p0_EBX = 0;


int __unbuffered_p1_EAX;


int __unbuffered_p1_EAX = 0;


int __unbuffered_p1_EBX;


int __unbuffered_p1_EBX = 0;


_Bool main$tmp_guard0;


_Bool main$tmp_guard1;


int x;


int x = 0;


int y;


int y = 0;


int z;


int z = 0;


_Bool z$flush_delayed;


int z$mem_tmp;


_Bool z$r_buff0_thd0;


_Bool z$r_buff0_thd1;


_Bool z$r_buff0_thd2;


_Bool z$r_buff1_thd0;


_Bool z$r_buff1_thd1;


_Bool z$r_buff1_thd2;


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
  z$w_buff1 = z$w_buff0;
  z$w_buff0 = 1;
  z$w_buff1_used = z$w_buff0_used;
  z$w_buff0_used = (_Bool)1;
  __VERIFIER_assert(!(z$w_buff1_used && z$w_buff0_used));
  z$r_buff1_thd0 = z$r_buff0_thd0;
  z$r_buff1_thd1 = z$r_buff0_thd1;
  z$r_buff1_thd2 = z$r_buff0_thd2;
  z$r_buff0_thd1 = (_Bool)1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  x = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p0_EAX = x;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p0_EBX = y;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  z = z$w_buff0_used && z$r_buff0_thd1 ? z$w_buff0 : (z$w_buff1_used && z$r_buff1_thd1 ? z$w_buff1 : z);
  z$w_buff0_used = z$w_buff0_used && z$r_buff0_thd1 ? (_Bool)0 : z$w_buff0_used;
  z$w_buff1_used = z$w_buff0_used && z$r_buff0_thd1 || z$w_buff1_used && z$r_buff1_thd1 ? (_Bool)0 : z$w_buff1_used;
  z$r_buff0_thd1 = z$w_buff0_used && z$r_buff0_thd1 ? (_Bool)0 : z$r_buff0_thd1;
  z$r_buff1_thd1 = z$w_buff0_used && z$r_buff0_thd1 || z$w_buff1_used && z$r_buff1_thd1 ? (_Bool)0 : z$r_buff1_thd1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_cnt = __unbuffered_cnt + 1;
  __VERIFIER_atomic_end();
  return 0;
}



void * P1(void *arg)
{
  __VERIFIER_atomic_begin();
  y = 1;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  __unbuffered_p1_EAX = y;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  weak$$choice0 = __VERIFIER_nondet_bool();
  weak$$choice2 = __VERIFIER_nondet_bool();
  z$flush_delayed = weak$$choice2;
  z$mem_tmp = z;
  z = !z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z : (z$w_buff0_used && z$r_buff0_thd2 ? z$w_buff0 : z$w_buff1);
  z$w_buff0 = weak$$choice2 ? z$w_buff0 : (!z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z$w_buff0 : (z$w_buff0_used && z$r_buff0_thd2 ? z$w_buff0 : z$w_buff0));
  z$w_buff1 = weak$$choice2 ? z$w_buff1 : (!z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z$w_buff1 : (z$w_buff0_used && z$r_buff0_thd2 ? z$w_buff1 : z$w_buff1));
  z$w_buff0_used = weak$$choice2 ? z$w_buff0_used : (!z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z$w_buff0_used : (z$w_buff0_used && z$r_buff0_thd2 ? (_Bool)0 : z$w_buff0_used));
  z$w_buff1_used = weak$$choice2 ? z$w_buff1_used : (!z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z$w_buff1_used : (z$w_buff0_used && z$r_buff0_thd2 ? (_Bool)0 : (_Bool)0));
  z$r_buff0_thd2 = weak$$choice2 ? z$r_buff0_thd2 : (!z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z$r_buff0_thd2 : (z$w_buff0_used && z$r_buff0_thd2 ? (_Bool)0 : z$r_buff0_thd2));
  z$r_buff1_thd2 = weak$$choice2 ? z$r_buff1_thd2 : (!z$w_buff0_used || !z$r_buff0_thd2 && !z$w_buff1_used || !z$r_buff0_thd2 && !z$r_buff1_thd2 ? z$r_buff1_thd2 : (z$w_buff0_used && z$r_buff0_thd2 ? (_Bool)0 : (_Bool)0));
  __unbuffered_p1_EBX = z;
  z = z$flush_delayed ? z$mem_tmp : z;
  z$flush_delayed = (_Bool)0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();
  z = z$w_buff0_used && z$r_buff0_thd2 ? z$w_buff0 : (z$w_buff1_used && z$r_buff1_thd2 ? z$w_buff1 : z);
  z$w_buff0_used = z$w_buff0_used && z$r_buff0_thd2 ? (_Bool)0 : z$w_buff0_used;
  z$w_buff1_used = z$w_buff0_used && z$r_buff0_thd2 || z$w_buff1_used && z$r_buff1_thd2 ? (_Bool)0 : z$w_buff1_used;
  z$r_buff0_thd2 = z$w_buff0_used && z$r_buff0_thd2 ? (_Bool)0 : z$r_buff0_thd2;
  z$r_buff1_thd2 = z$w_buff0_used && z$r_buff0_thd2 || z$w_buff1_used && z$r_buff1_thd2 ? (_Bool)0 : z$r_buff1_thd2;
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
  pthread_t t241;
  pthread_create(&t241, ((void*)0), P0, ((void*)0));
  pthread_t t242;
  pthread_create(&t242, ((void*)0), P1, ((void*)0));
  __VERIFIER_atomic_begin();
  main$tmp_guard0 = __unbuffered_cnt == 2;
  __VERIFIER_atomic_end();
  assume_abort_if_not(main$tmp_guard0);
  __VERIFIER_atomic_begin();
  z = z$w_buff0_used && z$r_buff0_thd0 ? z$w_buff0 : (z$w_buff1_used && z$r_buff1_thd0 ? z$w_buff1 : z);
  z$w_buff0_used = z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : z$w_buff0_used;
  z$w_buff1_used = z$w_buff0_used && z$r_buff0_thd0 || z$w_buff1_used && z$r_buff1_thd0 ? (_Bool)0 : z$w_buff1_used;
  z$r_buff0_thd0 = z$w_buff0_used && z$r_buff0_thd0 ? (_Bool)0 : z$r_buff0_thd0;
  z$r_buff1_thd0 = z$w_buff0_used && z$r_buff0_thd0 || z$w_buff1_used && z$r_buff1_thd0 ? (_Bool)0 : z$r_buff1_thd0;
  __VERIFIER_atomic_end();
  __VERIFIER_atomic_begin();

  main$tmp_guard1 = !(__unbuffered_p0_EAX == 1 && __unbuffered_p0_EBX == 0 && __unbuffered_p1_EAX == 1 && __unbuffered_p1_EBX == 0);
  __VERIFIER_atomic_end();

  __VERIFIER_assert(main$tmp_guard1);
  return 0;
}