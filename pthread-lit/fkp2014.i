





extern void abort(void);
void reach_error(){}
extern void abort(void);
void assume_abort_if_not(int cond) {
  if(!cond) {abort();}
}
void __VERIFIER_assert(int cond) {
  if (!(cond)) {
    ERROR: {reach_error();abort();}
  }
  return;
}
extern void __VERIFIER_atomic_begin();
extern void __VERIFIER_atomic_end();
int __VERIFIER_nondet_int();

volatile int s;
volatile int t;


void inct() {
    __VERIFIER_atomic_begin();
    t++;
    __VERIFIER_atomic_end();
}
void incs() {
    __VERIFIER_atomic_begin();
    s++;
    __VERIFIER_atomic_end();
}

void* thr(void* arg) {
    inct();
    __VERIFIER_assert(s < t);
    incs();
    return 0;
}

int main() {
    pthread_t t;
    int i, n;
    s = 0;

    n = __VERIFIER_nondet_int();
    assume_abort_if_not(n > 0);
    for (i = 0; i < n; i++) {
 pthread_create(&t, 0, thr, 0);
    }
    return 0;
}
