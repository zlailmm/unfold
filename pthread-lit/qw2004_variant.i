






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




volatile int stoppingFlag;
volatile int pendingIo;
volatile int stoppingEvent;
volatile int stopped;

int BCSP_IoIncrement() {
    __VERIFIER_atomic_begin();
    if (stoppingFlag) {
        __VERIFIER_atomic_end();
 return -1;
    } else {
 pendingIo = pendingIo + 1;
    }
    __VERIFIER_atomic_end();
    return 0;
}

void BCSP_IoDecrement() {
    __VERIFIER_atomic_begin();
    pendingIo--;
    if (pendingIo == 0) {
 stoppingEvent = 1;
    }
    __VERIFIER_atomic_end();
}

void* BCSP_PnpAdd(void* arg) {
    int status;
    status = BCSP_IoIncrement();
    if (status == 0) {
 __VERIFIER_assert(!stopped);
 BCSP_IoDecrement();
    }
    return 0;
}

void* BCSP_PnpStop(void* arg) {
    stoppingFlag = 1;
    BCSP_IoDecrement();
    assume_abort_if_not(stoppingEvent);
    stopped = 1;
    return 0;
}

int main() {
    pthread_t t;
    int i;
    pendingIo = 1;
    stoppingFlag = 0;
    stoppingEvent = 0;
    stopped = 0;
    pthread_create(&t, 0, BCSP_PnpStop, 0);
    for(i = 0; i < 10; i++) {
 pthread_create(&t, 0, BCSP_PnpAdd, 0);
    }
    return 0;
}
