extern void abort(void);
void reach_error(){}







int flag1 = 0, flag2 = 0;
int x;

void *thr1(void *_) {
  flag1 = 1;
  while (flag2 >= 3);
  flag1 = 3;
  if (flag2 == 1) {
    flag1 = 2;
    while (flag2 != 4);
  }
  flag1 = 4;
  while (flag2 >= 2);

  x = 0;
  if (!(x<=0)) ERROR: reach_error();

  while (2 <= flag2 && flag2 <= 3);
  flag1 = 0;
  return 0;
}

void *thr2(void *_) {
  flag2 = 1;
  while (flag1 >= 3);
  flag2 = 3;
  if (flag1 == 1) {
    flag2 = 2;
    while (flag1 != 4);
  }
  flag2 = 4;
  while (flag1 >= 2);

  x = 1;
  if (!(x>=1)) ERROR: reach_error();

  while (2 <= flag1 && flag1 <= 3);
  flag2 = 0;
  return 0;
}

int main() {
  pthread_t t1, t2;
  pthread_create(&t1, 0, thr1, 0);
  pthread_create(&t2, 0, thr2, 0);
  pthread_join(t1, 0);
  pthread_join(t2, 0);
  return 0;
}
