
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	06a7d863          	bge	a5,a0,86 <main+0x86>
  1a:	00858493          	addi	s1,a1,8
  1e:	3579                	addiw	a0,a0,-2
  20:	02051793          	slli	a5,a0,0x20
  24:	01d7d513          	srli	a0,a5,0x1d
  28:	00a48ab3          	add	s5,s1,a0
  2c:	05c1                	addi	a1,a1,16
  2e:	00a58a33          	add	s4,a1,a0
    write(1, argv[i], strlen(argv[i]));
  32:	4985                	li	s3,1
    if(i + 1 < argc){
      write(1, " ", 1);
  34:	00001b17          	auipc	s6,0x1
  38:	814b0b13          	addi	s6,s6,-2028 # 848 <malloc+0xfe>
  3c:	a819                	j	52 <main+0x52>
  3e:	864e                	mv	a2,s3
  40:	85da                	mv	a1,s6
  42:	854e                	mv	a0,s3
  44:	00000097          	auipc	ra,0x0
  48:	30c080e7          	jalr	780(ra) # 350 <write>
  for(i = 1; i < argc; i++){
  4c:	04a1                	addi	s1,s1,8
  4e:	03448c63          	beq	s1,s4,86 <main+0x86>
    write(1, argv[i], strlen(argv[i]));
  52:	0004b903          	ld	s2,0(s1)
  56:	854a                	mv	a0,s2
  58:	00000097          	auipc	ra,0x0
  5c:	088080e7          	jalr	136(ra) # e0 <strlen>
  60:	862a                	mv	a2,a0
  62:	85ca                	mv	a1,s2
  64:	854e                	mv	a0,s3
  66:	00000097          	auipc	ra,0x0
  6a:	2ea080e7          	jalr	746(ra) # 350 <write>
    if(i + 1 < argc){
  6e:	fd5498e3          	bne	s1,s5,3e <main+0x3e>
    } else {
      write(1, "\n", 1);
  72:	4605                	li	a2,1
  74:	00000597          	auipc	a1,0x0
  78:	7dc58593          	addi	a1,a1,2012 # 850 <malloc+0x106>
  7c:	8532                	mv	a0,a2
  7e:	00000097          	auipc	ra,0x0
  82:	2d2080e7          	jalr	722(ra) # 350 <write>
    }
  }
  exit(0);
  86:	4501                	li	a0,0
  88:	00000097          	auipc	ra,0x0
  8c:	2a8080e7          	jalr	680(ra) # 330 <exit>

0000000000000090 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  90:	1141                	addi	sp,sp,-16
  92:	e406                	sd	ra,8(sp)
  94:	e022                	sd	s0,0(sp)
  96:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  98:	87aa                	mv	a5,a0
  9a:	0585                	addi	a1,a1,1
  9c:	0785                	addi	a5,a5,1
  9e:	fff5c703          	lbu	a4,-1(a1)
  a2:	fee78fa3          	sb	a4,-1(a5)
  a6:	fb75                	bnez	a4,9a <strcpy+0xa>
    ;
  return os;
}
  a8:	60a2                	ld	ra,8(sp)
  aa:	6402                	ld	s0,0(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e406                	sd	ra,8(sp)
  b4:	e022                	sd	s0,0(sp)
  b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b8:	00054783          	lbu	a5,0(a0)
  bc:	cb91                	beqz	a5,d0 <strcmp+0x20>
  be:	0005c703          	lbu	a4,0(a1)
  c2:	00f71763          	bne	a4,a5,d0 <strcmp+0x20>
    p++, q++;
  c6:	0505                	addi	a0,a0,1
  c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ca:	00054783          	lbu	a5,0(a0)
  ce:	fbe5                	bnez	a5,be <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  d0:	0005c503          	lbu	a0,0(a1)
}
  d4:	40a7853b          	subw	a0,a5,a0
  d8:	60a2                	ld	ra,8(sp)
  da:	6402                	ld	s0,0(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret

00000000000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e406                	sd	ra,8(sp)
  e4:	e022                	sd	s0,0(sp)
  e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf99                	beqz	a5,10a <strlen+0x2a>
  ee:	0505                	addi	a0,a0,1
  f0:	87aa                	mv	a5,a0
  f2:	86be                	mv	a3,a5
  f4:	0785                	addi	a5,a5,1
  f6:	fff7c703          	lbu	a4,-1(a5)
  fa:	ff65                	bnez	a4,f2 <strlen+0x12>
  fc:	40a6853b          	subw	a0,a3,a0
 100:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 102:	60a2                	ld	ra,8(sp)
 104:	6402                	ld	s0,0(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret
  for(n = 0; s[n]; n++)
 10a:	4501                	li	a0,0
 10c:	bfdd                	j	102 <strlen+0x22>

000000000000010e <memset>:

void*
memset(void *dst, int c, uint n)
{
 10e:	1141                	addi	sp,sp,-16
 110:	e406                	sd	ra,8(sp)
 112:	e022                	sd	s0,0(sp)
 114:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 116:	ca19                	beqz	a2,12c <memset+0x1e>
 118:	87aa                	mv	a5,a0
 11a:	1602                	slli	a2,a2,0x20
 11c:	9201                	srli	a2,a2,0x20
 11e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 122:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 126:	0785                	addi	a5,a5,1
 128:	fee79de3          	bne	a5,a4,122 <memset+0x14>
  }
  return dst;
}
 12c:	60a2                	ld	ra,8(sp)
 12e:	6402                	ld	s0,0(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <strchr>:

char*
strchr(const char *s, char c)
{
 134:	1141                	addi	sp,sp,-16
 136:	e406                	sd	ra,8(sp)
 138:	e022                	sd	s0,0(sp)
 13a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 13c:	00054783          	lbu	a5,0(a0)
 140:	cf81                	beqz	a5,158 <strchr+0x24>
    if(*s == c)
 142:	00f58763          	beq	a1,a5,150 <strchr+0x1c>
  for(; *s; s++)
 146:	0505                	addi	a0,a0,1
 148:	00054783          	lbu	a5,0(a0)
 14c:	fbfd                	bnez	a5,142 <strchr+0xe>
      return (char*)s;
  return 0;
 14e:	4501                	li	a0,0
}
 150:	60a2                	ld	ra,8(sp)
 152:	6402                	ld	s0,0(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret
  return 0;
 158:	4501                	li	a0,0
 15a:	bfdd                	j	150 <strchr+0x1c>

000000000000015c <gets>:

char*
gets(char *buf, int max)
{
 15c:	7159                	addi	sp,sp,-112
 15e:	f486                	sd	ra,104(sp)
 160:	f0a2                	sd	s0,96(sp)
 162:	eca6                	sd	s1,88(sp)
 164:	e8ca                	sd	s2,80(sp)
 166:	e4ce                	sd	s3,72(sp)
 168:	e0d2                	sd	s4,64(sp)
 16a:	fc56                	sd	s5,56(sp)
 16c:	f85a                	sd	s6,48(sp)
 16e:	f45e                	sd	s7,40(sp)
 170:	f062                	sd	s8,32(sp)
 172:	ec66                	sd	s9,24(sp)
 174:	e86a                	sd	s10,16(sp)
 176:	1880                	addi	s0,sp,112
 178:	8caa                	mv	s9,a0
 17a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17c:	892a                	mv	s2,a0
 17e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 180:	f9f40b13          	addi	s6,s0,-97
 184:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 186:	4ba9                	li	s7,10
 188:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 18a:	8d26                	mv	s10,s1
 18c:	0014899b          	addiw	s3,s1,1
 190:	84ce                	mv	s1,s3
 192:	0349d763          	bge	s3,s4,1c0 <gets+0x64>
    cc = read(0, &c, 1);
 196:	8656                	mv	a2,s5
 198:	85da                	mv	a1,s6
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	1ac080e7          	jalr	428(ra) # 348 <read>
    if(cc < 1)
 1a4:	00a05e63          	blez	a0,1c0 <gets+0x64>
    buf[i++] = c;
 1a8:	f9f44783          	lbu	a5,-97(s0)
 1ac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1b0:	01778763          	beq	a5,s7,1be <gets+0x62>
 1b4:	0905                	addi	s2,s2,1
 1b6:	fd879ae3          	bne	a5,s8,18a <gets+0x2e>
    buf[i++] = c;
 1ba:	8d4e                	mv	s10,s3
 1bc:	a011                	j	1c0 <gets+0x64>
 1be:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1c0:	9d66                	add	s10,s10,s9
 1c2:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1c6:	8566                	mv	a0,s9
 1c8:	70a6                	ld	ra,104(sp)
 1ca:	7406                	ld	s0,96(sp)
 1cc:	64e6                	ld	s1,88(sp)
 1ce:	6946                	ld	s2,80(sp)
 1d0:	69a6                	ld	s3,72(sp)
 1d2:	6a06                	ld	s4,64(sp)
 1d4:	7ae2                	ld	s5,56(sp)
 1d6:	7b42                	ld	s6,48(sp)
 1d8:	7ba2                	ld	s7,40(sp)
 1da:	7c02                	ld	s8,32(sp)
 1dc:	6ce2                	ld	s9,24(sp)
 1de:	6d42                	ld	s10,16(sp)
 1e0:	6165                	addi	sp,sp,112
 1e2:	8082                	ret

00000000000001e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e4:	1101                	addi	sp,sp,-32
 1e6:	ec06                	sd	ra,24(sp)
 1e8:	e822                	sd	s0,16(sp)
 1ea:	e04a                	sd	s2,0(sp)
 1ec:	1000                	addi	s0,sp,32
 1ee:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f0:	4581                	li	a1,0
 1f2:	00000097          	auipc	ra,0x0
 1f6:	17e080e7          	jalr	382(ra) # 370 <open>
  if(fd < 0)
 1fa:	02054663          	bltz	a0,226 <stat+0x42>
 1fe:	e426                	sd	s1,8(sp)
 200:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 202:	85ca                	mv	a1,s2
 204:	00000097          	auipc	ra,0x0
 208:	184080e7          	jalr	388(ra) # 388 <fstat>
 20c:	892a                	mv	s2,a0
  close(fd);
 20e:	8526                	mv	a0,s1
 210:	00000097          	auipc	ra,0x0
 214:	148080e7          	jalr	328(ra) # 358 <close>
  return r;
 218:	64a2                	ld	s1,8(sp)
}
 21a:	854a                	mv	a0,s2
 21c:	60e2                	ld	ra,24(sp)
 21e:	6442                	ld	s0,16(sp)
 220:	6902                	ld	s2,0(sp)
 222:	6105                	addi	sp,sp,32
 224:	8082                	ret
    return -1;
 226:	597d                	li	s2,-1
 228:	bfcd                	j	21a <stat+0x36>

000000000000022a <atoi>:

int
atoi(const char *s)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e406                	sd	ra,8(sp)
 22e:	e022                	sd	s0,0(sp)
 230:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 232:	00054683          	lbu	a3,0(a0)
 236:	fd06879b          	addiw	a5,a3,-48
 23a:	0ff7f793          	zext.b	a5,a5
 23e:	4625                	li	a2,9
 240:	02f66963          	bltu	a2,a5,272 <atoi+0x48>
 244:	872a                	mv	a4,a0
  n = 0;
 246:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 248:	0705                	addi	a4,a4,1
 24a:	0025179b          	slliw	a5,a0,0x2
 24e:	9fa9                	addw	a5,a5,a0
 250:	0017979b          	slliw	a5,a5,0x1
 254:	9fb5                	addw	a5,a5,a3
 256:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25a:	00074683          	lbu	a3,0(a4)
 25e:	fd06879b          	addiw	a5,a3,-48
 262:	0ff7f793          	zext.b	a5,a5
 266:	fef671e3          	bgeu	a2,a5,248 <atoi+0x1e>
  return n;
}
 26a:	60a2                	ld	ra,8(sp)
 26c:	6402                	ld	s0,0(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
  n = 0;
 272:	4501                	li	a0,0
 274:	bfdd                	j	26a <atoi+0x40>

0000000000000276 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 276:	1141                	addi	sp,sp,-16
 278:	e406                	sd	ra,8(sp)
 27a:	e022                	sd	s0,0(sp)
 27c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27e:	02b57563          	bgeu	a0,a1,2a8 <memmove+0x32>
    while(n-- > 0)
 282:	00c05f63          	blez	a2,2a0 <memmove+0x2a>
 286:	1602                	slli	a2,a2,0x20
 288:	9201                	srli	a2,a2,0x20
 28a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28e:	872a                	mv	a4,a0
      *dst++ = *src++;
 290:	0585                	addi	a1,a1,1
 292:	0705                	addi	a4,a4,1
 294:	fff5c683          	lbu	a3,-1(a1)
 298:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29c:	fee79ae3          	bne	a5,a4,290 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a0:	60a2                	ld	ra,8(sp)
 2a2:	6402                	ld	s0,0(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
    dst += n;
 2a8:	00c50733          	add	a4,a0,a2
    src += n;
 2ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ae:	fec059e3          	blez	a2,2a0 <memmove+0x2a>
 2b2:	fff6079b          	addiw	a5,a2,-1
 2b6:	1782                	slli	a5,a5,0x20
 2b8:	9381                	srli	a5,a5,0x20
 2ba:	fff7c793          	not	a5,a5
 2be:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c0:	15fd                	addi	a1,a1,-1
 2c2:	177d                	addi	a4,a4,-1
 2c4:	0005c683          	lbu	a3,0(a1)
 2c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2cc:	fef71ae3          	bne	a4,a5,2c0 <memmove+0x4a>
 2d0:	bfc1                	j	2a0 <memmove+0x2a>

00000000000002d2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2da:	ca0d                	beqz	a2,30c <memcmp+0x3a>
 2dc:	fff6069b          	addiw	a3,a2,-1
 2e0:	1682                	slli	a3,a3,0x20
 2e2:	9281                	srli	a3,a3,0x20
 2e4:	0685                	addi	a3,a3,1
 2e6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e8:	00054783          	lbu	a5,0(a0)
 2ec:	0005c703          	lbu	a4,0(a1)
 2f0:	00e79863          	bne	a5,a4,300 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2f4:	0505                	addi	a0,a0,1
    p2++;
 2f6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f8:	fed518e3          	bne	a0,a3,2e8 <memcmp+0x16>
  }
  return 0;
 2fc:	4501                	li	a0,0
 2fe:	a019                	j	304 <memcmp+0x32>
      return *p1 - *p2;
 300:	40e7853b          	subw	a0,a5,a4
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  return 0;
 30c:	4501                	li	a0,0
 30e:	bfdd                	j	304 <memcmp+0x32>

0000000000000310 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 318:	00000097          	auipc	ra,0x0
 31c:	f5e080e7          	jalr	-162(ra) # 276 <memmove>
}
 320:	60a2                	ld	ra,8(sp)
 322:	6402                	ld	s0,0(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret

0000000000000328 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 328:	4885                	li	a7,1
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <exit>:
.global exit
exit:
 li a7, SYS_exit
 330:	4889                	li	a7,2
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <wait>:
.global wait
wait:
 li a7, SYS_wait
 338:	488d                	li	a7,3
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 340:	4891                	li	a7,4
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <read>:
.global read
read:
 li a7, SYS_read
 348:	4895                	li	a7,5
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <write>:
.global write
write:
 li a7, SYS_write
 350:	48c1                	li	a7,16
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <close>:
.global close
close:
 li a7, SYS_close
 358:	48d5                	li	a7,21
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <kill>:
.global kill
kill:
 li a7, SYS_kill
 360:	4899                	li	a7,6
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <exec>:
.global exec
exec:
 li a7, SYS_exec
 368:	489d                	li	a7,7
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <open>:
.global open
open:
 li a7, SYS_open
 370:	48bd                	li	a7,15
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 378:	48c5                	li	a7,17
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 380:	48c9                	li	a7,18
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 388:	48a1                	li	a7,8
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <link>:
.global link
link:
 li a7, SYS_link
 390:	48cd                	li	a7,19
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 398:	48d1                	li	a7,20
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3a0:	48a5                	li	a7,9
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3a8:	48a9                	li	a7,10
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3b0:	48ad                	li	a7,11
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3b8:	48b1                	li	a7,12
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3c0:	48b5                	li	a7,13
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3c8:	48b9                	li	a7,14
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3d0:	48d9                	li	a7,22
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3d8:	1101                	addi	sp,sp,-32
 3da:	ec06                	sd	ra,24(sp)
 3dc:	e822                	sd	s0,16(sp)
 3de:	1000                	addi	s0,sp,32
 3e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3e4:	4605                	li	a2,1
 3e6:	fef40593          	addi	a1,s0,-17
 3ea:	00000097          	auipc	ra,0x0
 3ee:	f66080e7          	jalr	-154(ra) # 350 <write>
}
 3f2:	60e2                	ld	ra,24(sp)
 3f4:	6442                	ld	s0,16(sp)
 3f6:	6105                	addi	sp,sp,32
 3f8:	8082                	ret

00000000000003fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3fa:	7139                	addi	sp,sp,-64
 3fc:	fc06                	sd	ra,56(sp)
 3fe:	f822                	sd	s0,48(sp)
 400:	f426                	sd	s1,40(sp)
 402:	f04a                	sd	s2,32(sp)
 404:	ec4e                	sd	s3,24(sp)
 406:	0080                	addi	s0,sp,64
 408:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40a:	c299                	beqz	a3,410 <printint+0x16>
 40c:	0805c063          	bltz	a1,48c <printint+0x92>
  neg = 0;
 410:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 412:	fc040313          	addi	t1,s0,-64
  neg = 0;
 416:	869a                	mv	a3,t1
  i = 0;
 418:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 41a:	00000817          	auipc	a6,0x0
 41e:	49e80813          	addi	a6,a6,1182 # 8b8 <digits>
 422:	88be                	mv	a7,a5
 424:	0017851b          	addiw	a0,a5,1
 428:	87aa                	mv	a5,a0
 42a:	02c5f73b          	remuw	a4,a1,a2
 42e:	1702                	slli	a4,a4,0x20
 430:	9301                	srli	a4,a4,0x20
 432:	9742                	add	a4,a4,a6
 434:	00074703          	lbu	a4,0(a4)
 438:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 43c:	872e                	mv	a4,a1
 43e:	02c5d5bb          	divuw	a1,a1,a2
 442:	0685                	addi	a3,a3,1
 444:	fcc77fe3          	bgeu	a4,a2,422 <printint+0x28>
  if(neg)
 448:	000e0c63          	beqz	t3,460 <printint+0x66>
    buf[i++] = '-';
 44c:	fd050793          	addi	a5,a0,-48
 450:	00878533          	add	a0,a5,s0
 454:	02d00793          	li	a5,45
 458:	fef50823          	sb	a5,-16(a0)
 45c:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 460:	fff7899b          	addiw	s3,a5,-1
 464:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 468:	fff4c583          	lbu	a1,-1(s1)
 46c:	854a                	mv	a0,s2
 46e:	00000097          	auipc	ra,0x0
 472:	f6a080e7          	jalr	-150(ra) # 3d8 <putc>
  while(--i >= 0)
 476:	39fd                	addiw	s3,s3,-1
 478:	14fd                	addi	s1,s1,-1
 47a:	fe09d7e3          	bgez	s3,468 <printint+0x6e>
}
 47e:	70e2                	ld	ra,56(sp)
 480:	7442                	ld	s0,48(sp)
 482:	74a2                	ld	s1,40(sp)
 484:	7902                	ld	s2,32(sp)
 486:	69e2                	ld	s3,24(sp)
 488:	6121                	addi	sp,sp,64
 48a:	8082                	ret
    x = -xx;
 48c:	40b005bb          	negw	a1,a1
    neg = 1;
 490:	4e05                	li	t3,1
    x = -xx;
 492:	b741                	j	412 <printint+0x18>

0000000000000494 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 494:	715d                	addi	sp,sp,-80
 496:	e486                	sd	ra,72(sp)
 498:	e0a2                	sd	s0,64(sp)
 49a:	f84a                	sd	s2,48(sp)
 49c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 49e:	0005c903          	lbu	s2,0(a1)
 4a2:	1a090a63          	beqz	s2,656 <vprintf+0x1c2>
 4a6:	fc26                	sd	s1,56(sp)
 4a8:	f44e                	sd	s3,40(sp)
 4aa:	f052                	sd	s4,32(sp)
 4ac:	ec56                	sd	s5,24(sp)
 4ae:	e85a                	sd	s6,16(sp)
 4b0:	e45e                	sd	s7,8(sp)
 4b2:	8aaa                	mv	s5,a0
 4b4:	8bb2                	mv	s7,a2
 4b6:	00158493          	addi	s1,a1,1
  state = 0;
 4ba:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4bc:	02500a13          	li	s4,37
 4c0:	4b55                	li	s6,21
 4c2:	a839                	j	4e0 <vprintf+0x4c>
        putc(fd, c);
 4c4:	85ca                	mv	a1,s2
 4c6:	8556                	mv	a0,s5
 4c8:	00000097          	auipc	ra,0x0
 4cc:	f10080e7          	jalr	-240(ra) # 3d8 <putc>
 4d0:	a019                	j	4d6 <vprintf+0x42>
    } else if(state == '%'){
 4d2:	01498d63          	beq	s3,s4,4ec <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 4d6:	0485                	addi	s1,s1,1
 4d8:	fff4c903          	lbu	s2,-1(s1)
 4dc:	16090763          	beqz	s2,64a <vprintf+0x1b6>
    if(state == 0){
 4e0:	fe0999e3          	bnez	s3,4d2 <vprintf+0x3e>
      if(c == '%'){
 4e4:	ff4910e3          	bne	s2,s4,4c4 <vprintf+0x30>
        state = '%';
 4e8:	89d2                	mv	s3,s4
 4ea:	b7f5                	j	4d6 <vprintf+0x42>
      if(c == 'd'){
 4ec:	13490463          	beq	s2,s4,614 <vprintf+0x180>
 4f0:	f9d9079b          	addiw	a5,s2,-99
 4f4:	0ff7f793          	zext.b	a5,a5
 4f8:	12fb6763          	bltu	s6,a5,626 <vprintf+0x192>
 4fc:	f9d9079b          	addiw	a5,s2,-99
 500:	0ff7f713          	zext.b	a4,a5
 504:	12eb6163          	bltu	s6,a4,626 <vprintf+0x192>
 508:	00271793          	slli	a5,a4,0x2
 50c:	00000717          	auipc	a4,0x0
 510:	35470713          	addi	a4,a4,852 # 860 <malloc+0x116>
 514:	97ba                	add	a5,a5,a4
 516:	439c                	lw	a5,0(a5)
 518:	97ba                	add	a5,a5,a4
 51a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 51c:	008b8913          	addi	s2,s7,8
 520:	4685                	li	a3,1
 522:	4629                	li	a2,10
 524:	000ba583          	lw	a1,0(s7)
 528:	8556                	mv	a0,s5
 52a:	00000097          	auipc	ra,0x0
 52e:	ed0080e7          	jalr	-304(ra) # 3fa <printint>
 532:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 534:	4981                	li	s3,0
 536:	b745                	j	4d6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 538:	008b8913          	addi	s2,s7,8
 53c:	4681                	li	a3,0
 53e:	4629                	li	a2,10
 540:	000ba583          	lw	a1,0(s7)
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	eb4080e7          	jalr	-332(ra) # 3fa <printint>
 54e:	8bca                	mv	s7,s2
      state = 0;
 550:	4981                	li	s3,0
 552:	b751                	j	4d6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 554:	008b8913          	addi	s2,s7,8
 558:	4681                	li	a3,0
 55a:	4641                	li	a2,16
 55c:	000ba583          	lw	a1,0(s7)
 560:	8556                	mv	a0,s5
 562:	00000097          	auipc	ra,0x0
 566:	e98080e7          	jalr	-360(ra) # 3fa <printint>
 56a:	8bca                	mv	s7,s2
      state = 0;
 56c:	4981                	li	s3,0
 56e:	b7a5                	j	4d6 <vprintf+0x42>
 570:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 572:	008b8c13          	addi	s8,s7,8
 576:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 57a:	03000593          	li	a1,48
 57e:	8556                	mv	a0,s5
 580:	00000097          	auipc	ra,0x0
 584:	e58080e7          	jalr	-424(ra) # 3d8 <putc>
  putc(fd, 'x');
 588:	07800593          	li	a1,120
 58c:	8556                	mv	a0,s5
 58e:	00000097          	auipc	ra,0x0
 592:	e4a080e7          	jalr	-438(ra) # 3d8 <putc>
 596:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 598:	00000b97          	auipc	s7,0x0
 59c:	320b8b93          	addi	s7,s7,800 # 8b8 <digits>
 5a0:	03c9d793          	srli	a5,s3,0x3c
 5a4:	97de                	add	a5,a5,s7
 5a6:	0007c583          	lbu	a1,0(a5)
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e2c080e7          	jalr	-468(ra) # 3d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5b4:	0992                	slli	s3,s3,0x4
 5b6:	397d                	addiw	s2,s2,-1
 5b8:	fe0914e3          	bnez	s2,5a0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5bc:	8be2                	mv	s7,s8
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	6c02                	ld	s8,0(sp)
 5c2:	bf11                	j	4d6 <vprintf+0x42>
        s = va_arg(ap, char*);
 5c4:	008b8993          	addi	s3,s7,8
 5c8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5cc:	02090163          	beqz	s2,5ee <vprintf+0x15a>
        while(*s != 0){
 5d0:	00094583          	lbu	a1,0(s2)
 5d4:	c9a5                	beqz	a1,644 <vprintf+0x1b0>
          putc(fd, *s);
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	e00080e7          	jalr	-512(ra) # 3d8 <putc>
          s++;
 5e0:	0905                	addi	s2,s2,1
        while(*s != 0){
 5e2:	00094583          	lbu	a1,0(s2)
 5e6:	f9e5                	bnez	a1,5d6 <vprintf+0x142>
        s = va_arg(ap, char*);
 5e8:	8bce                	mv	s7,s3
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	b5ed                	j	4d6 <vprintf+0x42>
          s = "(null)";
 5ee:	00000917          	auipc	s2,0x0
 5f2:	26a90913          	addi	s2,s2,618 # 858 <malloc+0x10e>
        while(*s != 0){
 5f6:	02800593          	li	a1,40
 5fa:	bff1                	j	5d6 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 5fc:	008b8913          	addi	s2,s7,8
 600:	000bc583          	lbu	a1,0(s7)
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	dd2080e7          	jalr	-558(ra) # 3d8 <putc>
 60e:	8bca                	mv	s7,s2
      state = 0;
 610:	4981                	li	s3,0
 612:	b5d1                	j	4d6 <vprintf+0x42>
        putc(fd, c);
 614:	02500593          	li	a1,37
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	dbe080e7          	jalr	-578(ra) # 3d8 <putc>
      state = 0;
 622:	4981                	li	s3,0
 624:	bd4d                	j	4d6 <vprintf+0x42>
        putc(fd, '%');
 626:	02500593          	li	a1,37
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	dac080e7          	jalr	-596(ra) # 3d8 <putc>
        putc(fd, c);
 634:	85ca                	mv	a1,s2
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	da0080e7          	jalr	-608(ra) # 3d8 <putc>
      state = 0;
 640:	4981                	li	s3,0
 642:	bd51                	j	4d6 <vprintf+0x42>
        s = va_arg(ap, char*);
 644:	8bce                	mv	s7,s3
      state = 0;
 646:	4981                	li	s3,0
 648:	b579                	j	4d6 <vprintf+0x42>
 64a:	74e2                	ld	s1,56(sp)
 64c:	79a2                	ld	s3,40(sp)
 64e:	7a02                	ld	s4,32(sp)
 650:	6ae2                	ld	s5,24(sp)
 652:	6b42                	ld	s6,16(sp)
 654:	6ba2                	ld	s7,8(sp)
    }
  }
}
 656:	60a6                	ld	ra,72(sp)
 658:	6406                	ld	s0,64(sp)
 65a:	7942                	ld	s2,48(sp)
 65c:	6161                	addi	sp,sp,80
 65e:	8082                	ret

0000000000000660 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 660:	715d                	addi	sp,sp,-80
 662:	ec06                	sd	ra,24(sp)
 664:	e822                	sd	s0,16(sp)
 666:	1000                	addi	s0,sp,32
 668:	e010                	sd	a2,0(s0)
 66a:	e414                	sd	a3,8(s0)
 66c:	e818                	sd	a4,16(s0)
 66e:	ec1c                	sd	a5,24(s0)
 670:	03043023          	sd	a6,32(s0)
 674:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 678:	8622                	mv	a2,s0
 67a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 67e:	00000097          	auipc	ra,0x0
 682:	e16080e7          	jalr	-490(ra) # 494 <vprintf>
}
 686:	60e2                	ld	ra,24(sp)
 688:	6442                	ld	s0,16(sp)
 68a:	6161                	addi	sp,sp,80
 68c:	8082                	ret

000000000000068e <printf>:

void
printf(const char *fmt, ...)
{
 68e:	711d                	addi	sp,sp,-96
 690:	ec06                	sd	ra,24(sp)
 692:	e822                	sd	s0,16(sp)
 694:	1000                	addi	s0,sp,32
 696:	e40c                	sd	a1,8(s0)
 698:	e810                	sd	a2,16(s0)
 69a:	ec14                	sd	a3,24(s0)
 69c:	f018                	sd	a4,32(s0)
 69e:	f41c                	sd	a5,40(s0)
 6a0:	03043823          	sd	a6,48(s0)
 6a4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6a8:	00840613          	addi	a2,s0,8
 6ac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6b0:	85aa                	mv	a1,a0
 6b2:	4505                	li	a0,1
 6b4:	00000097          	auipc	ra,0x0
 6b8:	de0080e7          	jalr	-544(ra) # 494 <vprintf>
}
 6bc:	60e2                	ld	ra,24(sp)
 6be:	6442                	ld	s0,16(sp)
 6c0:	6125                	addi	sp,sp,96
 6c2:	8082                	ret

00000000000006c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c4:	1141                	addi	sp,sp,-16
 6c6:	e406                	sd	ra,8(sp)
 6c8:	e022                	sd	s0,0(sp)
 6ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6cc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d0:	00000797          	auipc	a5,0x0
 6d4:	5e87b783          	ld	a5,1512(a5) # cb8 <freep>
 6d8:	a02d                	j	702 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6da:	4618                	lw	a4,8(a2)
 6dc:	9f2d                	addw	a4,a4,a1
 6de:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e2:	6398                	ld	a4,0(a5)
 6e4:	6310                	ld	a2,0(a4)
 6e6:	a83d                	j	724 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6e8:	ff852703          	lw	a4,-8(a0)
 6ec:	9f31                	addw	a4,a4,a2
 6ee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6f0:	ff053683          	ld	a3,-16(a0)
 6f4:	a091                	j	738 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f6:	6398                	ld	a4,0(a5)
 6f8:	00e7e463          	bltu	a5,a4,700 <free+0x3c>
 6fc:	00e6ea63          	bltu	a3,a4,710 <free+0x4c>
{
 700:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 702:	fed7fae3          	bgeu	a5,a3,6f6 <free+0x32>
 706:	6398                	ld	a4,0(a5)
 708:	00e6e463          	bltu	a3,a4,710 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70c:	fee7eae3          	bltu	a5,a4,700 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 710:	ff852583          	lw	a1,-8(a0)
 714:	6390                	ld	a2,0(a5)
 716:	02059813          	slli	a6,a1,0x20
 71a:	01c85713          	srli	a4,a6,0x1c
 71e:	9736                	add	a4,a4,a3
 720:	fae60de3          	beq	a2,a4,6da <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 724:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 728:	4790                	lw	a2,8(a5)
 72a:	02061593          	slli	a1,a2,0x20
 72e:	01c5d713          	srli	a4,a1,0x1c
 732:	973e                	add	a4,a4,a5
 734:	fae68ae3          	beq	a3,a4,6e8 <free+0x24>
    p->s.ptr = bp->s.ptr;
 738:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 73a:	00000717          	auipc	a4,0x0
 73e:	56f73f23          	sd	a5,1406(a4) # cb8 <freep>
}
 742:	60a2                	ld	ra,8(sp)
 744:	6402                	ld	s0,0(sp)
 746:	0141                	addi	sp,sp,16
 748:	8082                	ret

000000000000074a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 74a:	7139                	addi	sp,sp,-64
 74c:	fc06                	sd	ra,56(sp)
 74e:	f822                	sd	s0,48(sp)
 750:	f04a                	sd	s2,32(sp)
 752:	ec4e                	sd	s3,24(sp)
 754:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 756:	02051993          	slli	s3,a0,0x20
 75a:	0209d993          	srli	s3,s3,0x20
 75e:	09bd                	addi	s3,s3,15
 760:	0049d993          	srli	s3,s3,0x4
 764:	2985                	addiw	s3,s3,1
 766:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 768:	00000517          	auipc	a0,0x0
 76c:	55053503          	ld	a0,1360(a0) # cb8 <freep>
 770:	c905                	beqz	a0,7a0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 772:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 774:	4798                	lw	a4,8(a5)
 776:	09377a63          	bgeu	a4,s3,80a <malloc+0xc0>
 77a:	f426                	sd	s1,40(sp)
 77c:	e852                	sd	s4,16(sp)
 77e:	e456                	sd	s5,8(sp)
 780:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 782:	8a4e                	mv	s4,s3
 784:	6705                	lui	a4,0x1
 786:	00e9f363          	bgeu	s3,a4,78c <malloc+0x42>
 78a:	6a05                	lui	s4,0x1
 78c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 790:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 794:	00000497          	auipc	s1,0x0
 798:	52448493          	addi	s1,s1,1316 # cb8 <freep>
  if(p == (char*)-1)
 79c:	5afd                	li	s5,-1
 79e:	a089                	j	7e0 <malloc+0x96>
 7a0:	f426                	sd	s1,40(sp)
 7a2:	e852                	sd	s4,16(sp)
 7a4:	e456                	sd	s5,8(sp)
 7a6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7a8:	00000797          	auipc	a5,0x0
 7ac:	51878793          	addi	a5,a5,1304 # cc0 <base>
 7b0:	00000717          	auipc	a4,0x0
 7b4:	50f73423          	sd	a5,1288(a4) # cb8 <freep>
 7b8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7ba:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7be:	b7d1                	j	782 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 7c0:	6398                	ld	a4,0(a5)
 7c2:	e118                	sd	a4,0(a0)
 7c4:	a8b9                	j	822 <malloc+0xd8>
  hp->s.size = nu;
 7c6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7ca:	0541                	addi	a0,a0,16
 7cc:	00000097          	auipc	ra,0x0
 7d0:	ef8080e7          	jalr	-264(ra) # 6c4 <free>
  return freep;
 7d4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7d6:	c135                	beqz	a0,83a <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7da:	4798                	lw	a4,8(a5)
 7dc:	03277363          	bgeu	a4,s2,802 <malloc+0xb8>
    if(p == freep)
 7e0:	6098                	ld	a4,0(s1)
 7e2:	853e                	mv	a0,a5
 7e4:	fef71ae3          	bne	a4,a5,7d8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7e8:	8552                	mv	a0,s4
 7ea:	00000097          	auipc	ra,0x0
 7ee:	bce080e7          	jalr	-1074(ra) # 3b8 <sbrk>
  if(p == (char*)-1)
 7f2:	fd551ae3          	bne	a0,s5,7c6 <malloc+0x7c>
        return 0;
 7f6:	4501                	li	a0,0
 7f8:	74a2                	ld	s1,40(sp)
 7fa:	6a42                	ld	s4,16(sp)
 7fc:	6aa2                	ld	s5,8(sp)
 7fe:	6b02                	ld	s6,0(sp)
 800:	a03d                	j	82e <malloc+0xe4>
 802:	74a2                	ld	s1,40(sp)
 804:	6a42                	ld	s4,16(sp)
 806:	6aa2                	ld	s5,8(sp)
 808:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 80a:	fae90be3          	beq	s2,a4,7c0 <malloc+0x76>
        p->s.size -= nunits;
 80e:	4137073b          	subw	a4,a4,s3
 812:	c798                	sw	a4,8(a5)
        p += p->s.size;
 814:	02071693          	slli	a3,a4,0x20
 818:	01c6d713          	srli	a4,a3,0x1c
 81c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 81e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 822:	00000717          	auipc	a4,0x0
 826:	48a73b23          	sd	a0,1174(a4) # cb8 <freep>
      return (void*)(p + 1);
 82a:	01078513          	addi	a0,a5,16
  }
}
 82e:	70e2                	ld	ra,56(sp)
 830:	7442                	ld	s0,48(sp)
 832:	7902                	ld	s2,32(sp)
 834:	69e2                	ld	s3,24(sp)
 836:	6121                	addi	sp,sp,64
 838:	8082                	ret
 83a:	74a2                	ld	s1,40(sp)
 83c:	6a42                	ld	s4,16(sp)
 83e:	6aa2                	ld	s5,8(sp)
 840:	6b02                	ld	s6,0(sp)
 842:	b7f5                	j	82e <malloc+0xe4>
