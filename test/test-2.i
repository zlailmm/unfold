void reach_error(){}
void assume_abort_if_not(int cond) {
  if(!cond) {abort();}
}

int x = 0;
int y = 0;
int z = 0;

void error(void)
{
  ERROR: {reach_error();abort();} return;
}

void *t1(void *arg)
{
  x = 1;
  y = 3;
  z = 2;
  return 0;
}

void *t2(void *arg)
{
  if (x > 0) error();
  return 0;
}


int main(void)
{
  pthread_t id1, id2;

  pthread_mutex_init(&m, 0);

  pthread_create(&id1, NULL, t1, NULL);
  pthread_create(&id2, NULL, t2, NULL);

  pthread_join(id1, NULL);
  pthread_join(id2, NULL);

  return 0;
}
