#include <pthread.h>
#include <assert.h>

// verify 3_threads.c

int x = 0;
int y = 0;
int z = 0;
int error = 0;

void *thread1(void *arg)
{	
	x = 1;
	y = 3;
	z = 2;
	return 0;
}

void *thread2(void *arg)
{
	if (x < 1)	assert(error != 0);
	return 0;
}

int
main(void)
{	pthread_t t[2];

	pthread_create(&t[0], 0, thread1, 0);
	pthread_create(&t[1], 0, thread2, 0);

	pthread_join(t[0], 0);
	pthread_join(t[1], 0);

	return 0;
}
