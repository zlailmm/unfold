
extern void __VERIFIER_atomic_begin();
extern void __VERIFIER_atomic_end();

extern void abort(void);
void reach_error(){}

int i = 3, j = 6;




void *t1(void *arg) {
  for (int k = 0; k < 10; k++) {
    __VERIFIER_atomic_begin();
    i = j + 1;
    __VERIFIER_atomic_end();
  }
  pthread_exit(NULL);
}

void *t2(void *arg) {
  for (int k = 0; k < 10; k++) {
    __VERIFIER_atomic_begin();
    j = i + 1;
    __VERIFIER_atomic_end();
  }
  pthread_exit(NULL);
}

int main(int argc, char **argv) {
  pthread_t id1, id2;
  int condI,condJ;

  pthread_create(&id1, NULL, t1, NULL);
  pthread_create(&id2, NULL, t2, NULL);

  __VERIFIER_atomic_begin();
  condI = i > (2*10 +6);
  __VERIFIER_atomic_end();

  __VERIFIER_atomic_begin();
  condJ = j > (2*10 +6);
  __VERIFIER_atomic_end();

  if (condI || condJ) {
    ERROR: {reach_error();abort();}
  }

  return 0;
}
