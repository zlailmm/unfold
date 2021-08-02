extern void abort(void);
void assume_abort_if_not(int cond) {
  if(!cond) {abort();}
}
extern int __VERIFIER_nondet_int(void);
extern void abort(void);
void reach_error(){}





volatile unsigned s = 0;
volatile unsigned t = 0;

void __VERIFIER_atomic_fetch_and_inc(unsigned * l)
{
  assume_abort_if_not(t != -1);
  *l = t;
  t = t + 1;
}
unsigned c = 0;
void* thr1(void* arg)
{
  unsigned l;
  { __VERIFIER_atomic_fetch_and_inc(&l); while (l != s) ; };
  c = 1; { if(!(c == 1)) { ERROR: {reach_error();abort();}(void)0; } }; c = 0;
  { s++;};

  return 0;
}

int main()
{
  pthread_t t;

  while(__VERIFIER_nondet_int()) pthread_create(&t, 0, thr1, 0);
  thr1(0);

  return 0;
}
