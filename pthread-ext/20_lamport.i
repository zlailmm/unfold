extern void abort(void);
void reach_error(){}




int x;
int y;
int b1, b2;
int X;

void* thr1(void* arg) {
  while (1) {
    b1 = 1;
    x = 1;
    if (y != 0) {
      b1 = 0;
      while (y != 0) {};
      continue;
    }
    y = 1;
    if (x != 1) {
      b1 = 0;
      while (b2 >= 1) {};
      if (y != 1) {
 while (y != 0) {};
 continue;
      }
    }
    break;
  }

  X = 0;
  { if(!(X <= 0)) { ERROR: {reach_error();abort();}(void)0; } };

  y = 0;
  b1 = 0;

  return 0;
}

void* thr2(void* arg) {
  while (1) {
    b2 = 1;
    x = 2;
    if (y != 0) {
      b2 = 0;
      while (y != 0) {};
      continue;
    }
    y = 2;
    if (x != 2) {
      b2 = 0;
      while (b1 >= 1) {};
      if (y != 2) {
 while (y != 0) {};
 continue;
      }
    }
    break;
  }

  X = 1;
  { if(!(X >= 1)) { ERROR: {reach_error();abort();}(void)0; } };

  y = 0;
  b2 = 0;

  return 0;
}

int main()
{
  pthread_t t;

  pthread_create(&t, 0, thr1, 0);
  thr2(0);

  return 0;
}
