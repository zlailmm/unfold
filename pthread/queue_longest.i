extern int __VERIFIER_nondet_int(void);
extern void abort(void);
void reach_error(){}

void assert(int cond){
    if(!cond) {abort();}
}








typedef struct {
    int element[(800)];
    int head;
    int tail;
    int amount;
} QType;

pthread_mutex_t m;
int __VERIFIER_nondet_int();
int stored_elements[(800)];
_Bool enqueue_flag, dequeue_flag;
QType queue;

void init(QType *q)
{
  q->head=0;
  q->tail=0;
  q->amount=0;
}

int empty(QType * q)
{
  if (q->head == q->tail)
  {
    printf("queue is empty\n");
    return (-1);
  }
  else
    return 0;
}

int full(QType * q)
{
  if (q->amount == (800))
  {
 printf("queue is full\n");
 return (-2);
  }
  else
    return 0;
}

int enqueue(QType *q, int x)
{
  q->element[q->tail] = x;
  q->amount++;
  if (q->tail == (800))
  {
    q->tail = 1;
  }
  else
  {
    q->tail++;
  }

  return 0;
}

int dequeue(QType *q)
{
  int x;

  x = q->element[q->head];
  q->amount--;
  if (q->head == (800))
  {
    q->head = 1;
  }
  else
    q->head++;

  return x;
}

void *t1(void *arg)
{
  int value, i;

  pthread_mutex_lock(&m);
  value = __VERIFIER_nondet_int();
  if (enqueue(&queue,value)) {
    goto ERROR;
  }

  stored_elements[0]=value;
  if (empty(&queue)) {
    goto ERROR;
  }

  pthread_mutex_unlock(&m);

  for(i=0; i<((800)-1); i++)
  {
    pthread_mutex_lock(&m);
    if (enqueue_flag)
    {
      value = __VERIFIER_nondet_int();
      enqueue(&queue,value);
      stored_elements[i+1]=value;
      enqueue_flag=(0);
      dequeue_flag=(1);
    }
    pthread_mutex_unlock(&m);
  }

  return NULL;

 ERROR:{reach_error();abort();}
}

void *t2(void *arg)
{
  int i;

  for(i=0; i<(800); i++)
  {
    pthread_mutex_lock(&m);
    if (dequeue_flag)
    {
      if (!dequeue(&queue)==stored_elements[i]) {
        ERROR:{reach_error();abort();}
      }
      dequeue_flag=(0);
      enqueue_flag=(1);
    }
    pthread_mutex_unlock(&m);
  }

  return NULL;
}

int main(void)
{
  pthread_t id1, id2;

  enqueue_flag=(1);
  dequeue_flag=(0);

  init(&queue);

  if (!empty(&queue)==(-1)) {
    ERROR:{reach_error();abort();}
  }


  pthread_mutex_init(&m, 0);

  pthread_create(&id1, NULL, t1, &queue);
  pthread_create(&id2, NULL, t2, &queue);

  pthread_join(id1, NULL);
  pthread_join(id2, NULL);

  return 0;
}
