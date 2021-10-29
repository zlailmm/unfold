





int
main(void)
{ int i, q[4], *p[5][4];

 for (i = 0; i < 5; i++)
  p[i][3] = &q[i];
}
