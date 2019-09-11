/* C code to read in a CSV file a publish to a kdb tickerplant */

#include "k.h"
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

I handleOk(I handle) {
 if(handle > 0)
  return 1;
 if(handle == 0)
  fprintf(stderr, "Authentication error %d\n", handle);
 else if(handle == -1)
  fprintf(stderr, "Connection error %d\n", handle);
 else if(handle == -2)
  fprintf(stderr, "Time out error %d\n", handle);
  return 0;
}

I isRemoteErr(K x) {
 if(!x) {
  fprintf(stderr, "Network error: %s\n", strerror(errno));
  return 1;
 } else if(-128 == xt) {
  fprintf(stderr, "Error message returned : %s\n", x->s);
  r0(x);
  return 1;
 }
 return 0;
}

struct trade{
 time_t time;
 char *sym;
 float price;
 int qty;
} trade;

#define MAX_STR_LEN 256
#define MAX_TRADES 256

struct trade trades[MAX_TRADES];

int main(int argc, char **argv) {
 I handle;
 I portnumber= 9010;
 S hostname= "localhost";
 S usernamePassword= "kdb:pass";
 K result, singleRow;
 handle= khpu(hostname, portnumber, usernamePassword);
 if(!handleOk(handle))
  return EXIT_FAILURE;
 FILE *tradeFile;
 char *buf = malloc(MAX_STR_LEN);
 char *tmp;
 if ( ( tradeFile = fopen( "trade.csv", "r" ) ) == NULL )
 {
  printf("File cound not be opened.\n");
 }
 int i = 0;
 while (fgets(buf, 255, tradeFile) != NULL)
 {
  if ((strlen(buf)>0) && (buf[strlen (buf) - 1] == '\n'))
   buf[strlen (buf) - 1] = '\0';
  tmp = strtok(NULL, ",");
  trades[i].time = atoi(tmp);
  tmp = strtok(buf, ",");
  trades[i].sym = tmp;
  tmp = strtok(NULL, ",");
  trades[i].price = atoi(tmp);
  tmp = strtok(NULL, ",");
  trades[i].qty = atoi(tmp);
  singleRow= knk(3, ks((S) trades[i].sym), kf(trades[i].price), kj(trades[i].qty));
  result= k(handle, ".u.upd", ks((S) "Trade"), singleRow, (K) 0);
  if(isRemoteErr(result)) {
   kclose(handle);
   return EXIT_FAILURE;
  }
  i++;
 }
 fclose(tradeFile);
 r0(result);
 kclose(handle);
 return EXIT_SUCCESS;
}
