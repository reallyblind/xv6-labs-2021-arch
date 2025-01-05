
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2ba080e7          	jalr	698(ra) # 2c2 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2b4080e7          	jalr	692(ra) # 2ca <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	33a080e7          	jalr	826(ra) # 35a <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  32:	87aa                	mv	a5,a0
  34:	0585                	addi	a1,a1,1
  36:	0785                	addi	a5,a5,1
  38:	fff5c703          	lbu	a4,-1(a1)
  3c:	fee78fa3          	sb	a4,-1(a5)
  40:	fb75                	bnez	a4,34 <strcpy+0xa>
    ;
  return os;
}
  42:	60a2                	ld	ra,8(sp)
  44:	6402                	ld	s0,0(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  52:	00054783          	lbu	a5,0(a0)
  56:	cb91                	beqz	a5,6a <strcmp+0x20>
  58:	0005c703          	lbu	a4,0(a1)
  5c:	00f71763          	bne	a4,a5,6a <strcmp+0x20>
    p++, q++;
  60:	0505                	addi	a0,a0,1
  62:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	fbe5                	bnez	a5,58 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  6a:	0005c503          	lbu	a0,0(a1)
}
  6e:	40a7853b          	subw	a0,a5,a0
  72:	60a2                	ld	ra,8(sp)
  74:	6402                	ld	s0,0(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strlen>:

uint
strlen(const char *s)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  82:	00054783          	lbu	a5,0(a0)
  86:	cf99                	beqz	a5,a4 <strlen+0x2a>
  88:	0505                	addi	a0,a0,1
  8a:	87aa                	mv	a5,a0
  8c:	86be                	mv	a3,a5
  8e:	0785                	addi	a5,a5,1
  90:	fff7c703          	lbu	a4,-1(a5)
  94:	ff65                	bnez	a4,8c <strlen+0x12>
  96:	40a6853b          	subw	a0,a3,a0
  9a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  9c:	60a2                	ld	ra,8(sp)
  9e:	6402                	ld	s0,0(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret
  for(n = 0; s[n]; n++)
  a4:	4501                	li	a0,0
  a6:	bfdd                	j	9c <strlen+0x22>

00000000000000a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e406                	sd	ra,8(sp)
  ac:	e022                	sd	s0,0(sp)
  ae:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  b0:	ca19                	beqz	a2,c6 <memset+0x1e>
  b2:	87aa                	mv	a5,a0
  b4:	1602                	slli	a2,a2,0x20
  b6:	9201                	srli	a2,a2,0x20
  b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  c0:	0785                	addi	a5,a5,1
  c2:	fee79de3          	bne	a5,a4,bc <memset+0x14>
  }
  return dst;
}
  c6:	60a2                	ld	ra,8(sp)
  c8:	6402                	ld	s0,0(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret

00000000000000ce <strchr>:

char*
strchr(const char *s, char c)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d6:	00054783          	lbu	a5,0(a0)
  da:	cf81                	beqz	a5,f2 <strchr+0x24>
    if(*s == c)
  dc:	00f58763          	beq	a1,a5,ea <strchr+0x1c>
  for(; *s; s++)
  e0:	0505                	addi	a0,a0,1
  e2:	00054783          	lbu	a5,0(a0)
  e6:	fbfd                	bnez	a5,dc <strchr+0xe>
      return (char*)s;
  return 0;
  e8:	4501                	li	a0,0
}
  ea:	60a2                	ld	ra,8(sp)
  ec:	6402                	ld	s0,0(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret
  return 0;
  f2:	4501                	li	a0,0
  f4:	bfdd                	j	ea <strchr+0x1c>

00000000000000f6 <gets>:

char*
gets(char *buf, int max)
{
  f6:	7159                	addi	sp,sp,-112
  f8:	f486                	sd	ra,104(sp)
  fa:	f0a2                	sd	s0,96(sp)
  fc:	eca6                	sd	s1,88(sp)
  fe:	e8ca                	sd	s2,80(sp)
 100:	e4ce                	sd	s3,72(sp)
 102:	e0d2                	sd	s4,64(sp)
 104:	fc56                	sd	s5,56(sp)
 106:	f85a                	sd	s6,48(sp)
 108:	f45e                	sd	s7,40(sp)
 10a:	f062                	sd	s8,32(sp)
 10c:	ec66                	sd	s9,24(sp)
 10e:	e86a                	sd	s10,16(sp)
 110:	1880                	addi	s0,sp,112
 112:	8caa                	mv	s9,a0
 114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 116:	892a                	mv	s2,a0
 118:	4481                	li	s1,0
    cc = read(0, &c, 1);
 11a:	f9f40b13          	addi	s6,s0,-97
 11e:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 120:	4ba9                	li	s7,10
 122:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 124:	8d26                	mv	s10,s1
 126:	0014899b          	addiw	s3,s1,1
 12a:	84ce                	mv	s1,s3
 12c:	0349d763          	bge	s3,s4,15a <gets+0x64>
    cc = read(0, &c, 1);
 130:	8656                	mv	a2,s5
 132:	85da                	mv	a1,s6
 134:	4501                	li	a0,0
 136:	00000097          	auipc	ra,0x0
 13a:	1ac080e7          	jalr	428(ra) # 2e2 <read>
    if(cc < 1)
 13e:	00a05e63          	blez	a0,15a <gets+0x64>
    buf[i++] = c;
 142:	f9f44783          	lbu	a5,-97(s0)
 146:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 14a:	01778763          	beq	a5,s7,158 <gets+0x62>
 14e:	0905                	addi	s2,s2,1
 150:	fd879ae3          	bne	a5,s8,124 <gets+0x2e>
    buf[i++] = c;
 154:	8d4e                	mv	s10,s3
 156:	a011                	j	15a <gets+0x64>
 158:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 15a:	9d66                	add	s10,s10,s9
 15c:	000d0023          	sb	zero,0(s10)
  return buf;
}
 160:	8566                	mv	a0,s9
 162:	70a6                	ld	ra,104(sp)
 164:	7406                	ld	s0,96(sp)
 166:	64e6                	ld	s1,88(sp)
 168:	6946                	ld	s2,80(sp)
 16a:	69a6                	ld	s3,72(sp)
 16c:	6a06                	ld	s4,64(sp)
 16e:	7ae2                	ld	s5,56(sp)
 170:	7b42                	ld	s6,48(sp)
 172:	7ba2                	ld	s7,40(sp)
 174:	7c02                	ld	s8,32(sp)
 176:	6ce2                	ld	s9,24(sp)
 178:	6d42                	ld	s10,16(sp)
 17a:	6165                	addi	sp,sp,112
 17c:	8082                	ret

000000000000017e <stat>:

int
stat(const char *n, struct stat *st)
{
 17e:	1101                	addi	sp,sp,-32
 180:	ec06                	sd	ra,24(sp)
 182:	e822                	sd	s0,16(sp)
 184:	e04a                	sd	s2,0(sp)
 186:	1000                	addi	s0,sp,32
 188:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18a:	4581                	li	a1,0
 18c:	00000097          	auipc	ra,0x0
 190:	17e080e7          	jalr	382(ra) # 30a <open>
  if(fd < 0)
 194:	02054663          	bltz	a0,1c0 <stat+0x42>
 198:	e426                	sd	s1,8(sp)
 19a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19c:	85ca                	mv	a1,s2
 19e:	00000097          	auipc	ra,0x0
 1a2:	184080e7          	jalr	388(ra) # 322 <fstat>
 1a6:	892a                	mv	s2,a0
  close(fd);
 1a8:	8526                	mv	a0,s1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	148080e7          	jalr	328(ra) # 2f2 <close>
  return r;
 1b2:	64a2                	ld	s1,8(sp)
}
 1b4:	854a                	mv	a0,s2
 1b6:	60e2                	ld	ra,24(sp)
 1b8:	6442                	ld	s0,16(sp)
 1ba:	6902                	ld	s2,0(sp)
 1bc:	6105                	addi	sp,sp,32
 1be:	8082                	ret
    return -1;
 1c0:	597d                	li	s2,-1
 1c2:	bfcd                	j	1b4 <stat+0x36>

00000000000001c4 <atoi>:

int
atoi(const char *s)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e406                	sd	ra,8(sp)
 1c8:	e022                	sd	s0,0(sp)
 1ca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	00054683          	lbu	a3,0(a0)
 1d0:	fd06879b          	addiw	a5,a3,-48
 1d4:	0ff7f793          	zext.b	a5,a5
 1d8:	4625                	li	a2,9
 1da:	02f66963          	bltu	a2,a5,20c <atoi+0x48>
 1de:	872a                	mv	a4,a0
  n = 0;
 1e0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e2:	0705                	addi	a4,a4,1
 1e4:	0025179b          	slliw	a5,a0,0x2
 1e8:	9fa9                	addw	a5,a5,a0
 1ea:	0017979b          	slliw	a5,a5,0x1
 1ee:	9fb5                	addw	a5,a5,a3
 1f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f4:	00074683          	lbu	a3,0(a4)
 1f8:	fd06879b          	addiw	a5,a3,-48
 1fc:	0ff7f793          	zext.b	a5,a5
 200:	fef671e3          	bgeu	a2,a5,1e2 <atoi+0x1e>
  return n;
}
 204:	60a2                	ld	ra,8(sp)
 206:	6402                	ld	s0,0(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  n = 0;
 20c:	4501                	li	a0,0
 20e:	bfdd                	j	204 <atoi+0x40>

0000000000000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e406                	sd	ra,8(sp)
 214:	e022                	sd	s0,0(sp)
 216:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 218:	02b57563          	bgeu	a0,a1,242 <memmove+0x32>
    while(n-- > 0)
 21c:	00c05f63          	blez	a2,23a <memmove+0x2a>
 220:	1602                	slli	a2,a2,0x20
 222:	9201                	srli	a2,a2,0x20
 224:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 228:	872a                	mv	a4,a0
      *dst++ = *src++;
 22a:	0585                	addi	a1,a1,1
 22c:	0705                	addi	a4,a4,1
 22e:	fff5c683          	lbu	a3,-1(a1)
 232:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 236:	fee79ae3          	bne	a5,a4,22a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 23a:	60a2                	ld	ra,8(sp)
 23c:	6402                	ld	s0,0(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
    dst += n;
 242:	00c50733          	add	a4,a0,a2
    src += n;
 246:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 248:	fec059e3          	blez	a2,23a <memmove+0x2a>
 24c:	fff6079b          	addiw	a5,a2,-1
 250:	1782                	slli	a5,a5,0x20
 252:	9381                	srli	a5,a5,0x20
 254:	fff7c793          	not	a5,a5
 258:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 25a:	15fd                	addi	a1,a1,-1
 25c:	177d                	addi	a4,a4,-1
 25e:	0005c683          	lbu	a3,0(a1)
 262:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 266:	fef71ae3          	bne	a4,a5,25a <memmove+0x4a>
 26a:	bfc1                	j	23a <memmove+0x2a>

000000000000026c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 274:	ca0d                	beqz	a2,2a6 <memcmp+0x3a>
 276:	fff6069b          	addiw	a3,a2,-1
 27a:	1682                	slli	a3,a3,0x20
 27c:	9281                	srli	a3,a3,0x20
 27e:	0685                	addi	a3,a3,1
 280:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 282:	00054783          	lbu	a5,0(a0)
 286:	0005c703          	lbu	a4,0(a1)
 28a:	00e79863          	bne	a5,a4,29a <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 28e:	0505                	addi	a0,a0,1
    p2++;
 290:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 292:	fed518e3          	bne	a0,a3,282 <memcmp+0x16>
  }
  return 0;
 296:	4501                	li	a0,0
 298:	a019                	j	29e <memcmp+0x32>
      return *p1 - *p2;
 29a:	40e7853b          	subw	a0,a5,a4
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
  return 0;
 2a6:	4501                	li	a0,0
 2a8:	bfdd                	j	29e <memcmp+0x32>

00000000000002aa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2b2:	00000097          	auipc	ra,0x0
 2b6:	f5e080e7          	jalr	-162(ra) # 210 <memmove>
}
 2ba:	60a2                	ld	ra,8(sp)
 2bc:	6402                	ld	s0,0(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2c2:	4885                	li	a7,1
 ecall
 2c4:	00000073          	ecall
 ret
 2c8:	8082                	ret

00000000000002ca <exit>:
.global exit
exit:
 li a7, SYS_exit
 2ca:	4889                	li	a7,2
 ecall
 2cc:	00000073          	ecall
 ret
 2d0:	8082                	ret

00000000000002d2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2d2:	488d                	li	a7,3
 ecall
 2d4:	00000073          	ecall
 ret
 2d8:	8082                	ret

00000000000002da <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2da:	4891                	li	a7,4
 ecall
 2dc:	00000073          	ecall
 ret
 2e0:	8082                	ret

00000000000002e2 <read>:
.global read
read:
 li a7, SYS_read
 2e2:	4895                	li	a7,5
 ecall
 2e4:	00000073          	ecall
 ret
 2e8:	8082                	ret

00000000000002ea <write>:
.global write
write:
 li a7, SYS_write
 2ea:	48c1                	li	a7,16
 ecall
 2ec:	00000073          	ecall
 ret
 2f0:	8082                	ret

00000000000002f2 <close>:
.global close
close:
 li a7, SYS_close
 2f2:	48d5                	li	a7,21
 ecall
 2f4:	00000073          	ecall
 ret
 2f8:	8082                	ret

00000000000002fa <kill>:
.global kill
kill:
 li a7, SYS_kill
 2fa:	4899                	li	a7,6
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <exec>:
.global exec
exec:
 li a7, SYS_exec
 302:	489d                	li	a7,7
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <open>:
.global open
open:
 li a7, SYS_open
 30a:	48bd                	li	a7,15
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 312:	48c5                	li	a7,17
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 31a:	48c9                	li	a7,18
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 322:	48a1                	li	a7,8
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <link>:
.global link
link:
 li a7, SYS_link
 32a:	48cd                	li	a7,19
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 332:	48d1                	li	a7,20
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 33a:	48a5                	li	a7,9
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <dup>:
.global dup
dup:
 li a7, SYS_dup
 342:	48a9                	li	a7,10
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 34a:	48ad                	li	a7,11
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 352:	48b1                	li	a7,12
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 35a:	48b5                	li	a7,13
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 362:	48b9                	li	a7,14
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <trace>:
.global trace
trace:
 li a7, SYS_trace
 36a:	48d9                	li	a7,22
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 372:	1101                	addi	sp,sp,-32
 374:	ec06                	sd	ra,24(sp)
 376:	e822                	sd	s0,16(sp)
 378:	1000                	addi	s0,sp,32
 37a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 37e:	4605                	li	a2,1
 380:	fef40593          	addi	a1,s0,-17
 384:	00000097          	auipc	ra,0x0
 388:	f66080e7          	jalr	-154(ra) # 2ea <write>
}
 38c:	60e2                	ld	ra,24(sp)
 38e:	6442                	ld	s0,16(sp)
 390:	6105                	addi	sp,sp,32
 392:	8082                	ret

0000000000000394 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 394:	7139                	addi	sp,sp,-64
 396:	fc06                	sd	ra,56(sp)
 398:	f822                	sd	s0,48(sp)
 39a:	f426                	sd	s1,40(sp)
 39c:	f04a                	sd	s2,32(sp)
 39e:	ec4e                	sd	s3,24(sp)
 3a0:	0080                	addi	s0,sp,64
 3a2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a4:	c299                	beqz	a3,3aa <printint+0x16>
 3a6:	0805c063          	bltz	a1,426 <printint+0x92>
  neg = 0;
 3aa:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3ac:	fc040313          	addi	t1,s0,-64
  neg = 0;
 3b0:	869a                	mv	a3,t1
  i = 0;
 3b2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3b4:	00000817          	auipc	a6,0x0
 3b8:	48c80813          	addi	a6,a6,1164 # 840 <digits>
 3bc:	88be                	mv	a7,a5
 3be:	0017851b          	addiw	a0,a5,1
 3c2:	87aa                	mv	a5,a0
 3c4:	02c5f73b          	remuw	a4,a1,a2
 3c8:	1702                	slli	a4,a4,0x20
 3ca:	9301                	srli	a4,a4,0x20
 3cc:	9742                	add	a4,a4,a6
 3ce:	00074703          	lbu	a4,0(a4)
 3d2:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3d6:	872e                	mv	a4,a1
 3d8:	02c5d5bb          	divuw	a1,a1,a2
 3dc:	0685                	addi	a3,a3,1
 3de:	fcc77fe3          	bgeu	a4,a2,3bc <printint+0x28>
  if(neg)
 3e2:	000e0c63          	beqz	t3,3fa <printint+0x66>
    buf[i++] = '-';
 3e6:	fd050793          	addi	a5,a0,-48
 3ea:	00878533          	add	a0,a5,s0
 3ee:	02d00793          	li	a5,45
 3f2:	fef50823          	sb	a5,-16(a0)
 3f6:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 3fa:	fff7899b          	addiw	s3,a5,-1
 3fe:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 402:	fff4c583          	lbu	a1,-1(s1)
 406:	854a                	mv	a0,s2
 408:	00000097          	auipc	ra,0x0
 40c:	f6a080e7          	jalr	-150(ra) # 372 <putc>
  while(--i >= 0)
 410:	39fd                	addiw	s3,s3,-1
 412:	14fd                	addi	s1,s1,-1
 414:	fe09d7e3          	bgez	s3,402 <printint+0x6e>
}
 418:	70e2                	ld	ra,56(sp)
 41a:	7442                	ld	s0,48(sp)
 41c:	74a2                	ld	s1,40(sp)
 41e:	7902                	ld	s2,32(sp)
 420:	69e2                	ld	s3,24(sp)
 422:	6121                	addi	sp,sp,64
 424:	8082                	ret
    x = -xx;
 426:	40b005bb          	negw	a1,a1
    neg = 1;
 42a:	4e05                	li	t3,1
    x = -xx;
 42c:	b741                	j	3ac <printint+0x18>

000000000000042e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 42e:	715d                	addi	sp,sp,-80
 430:	e486                	sd	ra,72(sp)
 432:	e0a2                	sd	s0,64(sp)
 434:	f84a                	sd	s2,48(sp)
 436:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 438:	0005c903          	lbu	s2,0(a1)
 43c:	1a090a63          	beqz	s2,5f0 <vprintf+0x1c2>
 440:	fc26                	sd	s1,56(sp)
 442:	f44e                	sd	s3,40(sp)
 444:	f052                	sd	s4,32(sp)
 446:	ec56                	sd	s5,24(sp)
 448:	e85a                	sd	s6,16(sp)
 44a:	e45e                	sd	s7,8(sp)
 44c:	8aaa                	mv	s5,a0
 44e:	8bb2                	mv	s7,a2
 450:	00158493          	addi	s1,a1,1
  state = 0;
 454:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 456:	02500a13          	li	s4,37
 45a:	4b55                	li	s6,21
 45c:	a839                	j	47a <vprintf+0x4c>
        putc(fd, c);
 45e:	85ca                	mv	a1,s2
 460:	8556                	mv	a0,s5
 462:	00000097          	auipc	ra,0x0
 466:	f10080e7          	jalr	-240(ra) # 372 <putc>
 46a:	a019                	j	470 <vprintf+0x42>
    } else if(state == '%'){
 46c:	01498d63          	beq	s3,s4,486 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 470:	0485                	addi	s1,s1,1
 472:	fff4c903          	lbu	s2,-1(s1)
 476:	16090763          	beqz	s2,5e4 <vprintf+0x1b6>
    if(state == 0){
 47a:	fe0999e3          	bnez	s3,46c <vprintf+0x3e>
      if(c == '%'){
 47e:	ff4910e3          	bne	s2,s4,45e <vprintf+0x30>
        state = '%';
 482:	89d2                	mv	s3,s4
 484:	b7f5                	j	470 <vprintf+0x42>
      if(c == 'd'){
 486:	13490463          	beq	s2,s4,5ae <vprintf+0x180>
 48a:	f9d9079b          	addiw	a5,s2,-99
 48e:	0ff7f793          	zext.b	a5,a5
 492:	12fb6763          	bltu	s6,a5,5c0 <vprintf+0x192>
 496:	f9d9079b          	addiw	a5,s2,-99
 49a:	0ff7f713          	zext.b	a4,a5
 49e:	12eb6163          	bltu	s6,a4,5c0 <vprintf+0x192>
 4a2:	00271793          	slli	a5,a4,0x2
 4a6:	00000717          	auipc	a4,0x0
 4aa:	34270713          	addi	a4,a4,834 # 7e8 <malloc+0x104>
 4ae:	97ba                	add	a5,a5,a4
 4b0:	439c                	lw	a5,0(a5)
 4b2:	97ba                	add	a5,a5,a4
 4b4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4b6:	008b8913          	addi	s2,s7,8
 4ba:	4685                	li	a3,1
 4bc:	4629                	li	a2,10
 4be:	000ba583          	lw	a1,0(s7)
 4c2:	8556                	mv	a0,s5
 4c4:	00000097          	auipc	ra,0x0
 4c8:	ed0080e7          	jalr	-304(ra) # 394 <printint>
 4cc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ce:	4981                	li	s3,0
 4d0:	b745                	j	470 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4d2:	008b8913          	addi	s2,s7,8
 4d6:	4681                	li	a3,0
 4d8:	4629                	li	a2,10
 4da:	000ba583          	lw	a1,0(s7)
 4de:	8556                	mv	a0,s5
 4e0:	00000097          	auipc	ra,0x0
 4e4:	eb4080e7          	jalr	-332(ra) # 394 <printint>
 4e8:	8bca                	mv	s7,s2
      state = 0;
 4ea:	4981                	li	s3,0
 4ec:	b751                	j	470 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 4ee:	008b8913          	addi	s2,s7,8
 4f2:	4681                	li	a3,0
 4f4:	4641                	li	a2,16
 4f6:	000ba583          	lw	a1,0(s7)
 4fa:	8556                	mv	a0,s5
 4fc:	00000097          	auipc	ra,0x0
 500:	e98080e7          	jalr	-360(ra) # 394 <printint>
 504:	8bca                	mv	s7,s2
      state = 0;
 506:	4981                	li	s3,0
 508:	b7a5                	j	470 <vprintf+0x42>
 50a:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 50c:	008b8c13          	addi	s8,s7,8
 510:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 514:	03000593          	li	a1,48
 518:	8556                	mv	a0,s5
 51a:	00000097          	auipc	ra,0x0
 51e:	e58080e7          	jalr	-424(ra) # 372 <putc>
  putc(fd, 'x');
 522:	07800593          	li	a1,120
 526:	8556                	mv	a0,s5
 528:	00000097          	auipc	ra,0x0
 52c:	e4a080e7          	jalr	-438(ra) # 372 <putc>
 530:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 532:	00000b97          	auipc	s7,0x0
 536:	30eb8b93          	addi	s7,s7,782 # 840 <digits>
 53a:	03c9d793          	srli	a5,s3,0x3c
 53e:	97de                	add	a5,a5,s7
 540:	0007c583          	lbu	a1,0(a5)
 544:	8556                	mv	a0,s5
 546:	00000097          	auipc	ra,0x0
 54a:	e2c080e7          	jalr	-468(ra) # 372 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 54e:	0992                	slli	s3,s3,0x4
 550:	397d                	addiw	s2,s2,-1
 552:	fe0914e3          	bnez	s2,53a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 556:	8be2                	mv	s7,s8
      state = 0;
 558:	4981                	li	s3,0
 55a:	6c02                	ld	s8,0(sp)
 55c:	bf11                	j	470 <vprintf+0x42>
        s = va_arg(ap, char*);
 55e:	008b8993          	addi	s3,s7,8
 562:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 566:	02090163          	beqz	s2,588 <vprintf+0x15a>
        while(*s != 0){
 56a:	00094583          	lbu	a1,0(s2)
 56e:	c9a5                	beqz	a1,5de <vprintf+0x1b0>
          putc(fd, *s);
 570:	8556                	mv	a0,s5
 572:	00000097          	auipc	ra,0x0
 576:	e00080e7          	jalr	-512(ra) # 372 <putc>
          s++;
 57a:	0905                	addi	s2,s2,1
        while(*s != 0){
 57c:	00094583          	lbu	a1,0(s2)
 580:	f9e5                	bnez	a1,570 <vprintf+0x142>
        s = va_arg(ap, char*);
 582:	8bce                	mv	s7,s3
      state = 0;
 584:	4981                	li	s3,0
 586:	b5ed                	j	470 <vprintf+0x42>
          s = "(null)";
 588:	00000917          	auipc	s2,0x0
 58c:	25890913          	addi	s2,s2,600 # 7e0 <malloc+0xfc>
        while(*s != 0){
 590:	02800593          	li	a1,40
 594:	bff1                	j	570 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 596:	008b8913          	addi	s2,s7,8
 59a:	000bc583          	lbu	a1,0(s7)
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	dd2080e7          	jalr	-558(ra) # 372 <putc>
 5a8:	8bca                	mv	s7,s2
      state = 0;
 5aa:	4981                	li	s3,0
 5ac:	b5d1                	j	470 <vprintf+0x42>
        putc(fd, c);
 5ae:	02500593          	li	a1,37
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	dbe080e7          	jalr	-578(ra) # 372 <putc>
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	bd4d                	j	470 <vprintf+0x42>
        putc(fd, '%');
 5c0:	02500593          	li	a1,37
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	dac080e7          	jalr	-596(ra) # 372 <putc>
        putc(fd, c);
 5ce:	85ca                	mv	a1,s2
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	da0080e7          	jalr	-608(ra) # 372 <putc>
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	bd51                	j	470 <vprintf+0x42>
        s = va_arg(ap, char*);
 5de:	8bce                	mv	s7,s3
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b579                	j	470 <vprintf+0x42>
 5e4:	74e2                	ld	s1,56(sp)
 5e6:	79a2                	ld	s3,40(sp)
 5e8:	7a02                	ld	s4,32(sp)
 5ea:	6ae2                	ld	s5,24(sp)
 5ec:	6b42                	ld	s6,16(sp)
 5ee:	6ba2                	ld	s7,8(sp)
    }
  }
}
 5f0:	60a6                	ld	ra,72(sp)
 5f2:	6406                	ld	s0,64(sp)
 5f4:	7942                	ld	s2,48(sp)
 5f6:	6161                	addi	sp,sp,80
 5f8:	8082                	ret

00000000000005fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5fa:	715d                	addi	sp,sp,-80
 5fc:	ec06                	sd	ra,24(sp)
 5fe:	e822                	sd	s0,16(sp)
 600:	1000                	addi	s0,sp,32
 602:	e010                	sd	a2,0(s0)
 604:	e414                	sd	a3,8(s0)
 606:	e818                	sd	a4,16(s0)
 608:	ec1c                	sd	a5,24(s0)
 60a:	03043023          	sd	a6,32(s0)
 60e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 612:	8622                	mv	a2,s0
 614:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 618:	00000097          	auipc	ra,0x0
 61c:	e16080e7          	jalr	-490(ra) # 42e <vprintf>
}
 620:	60e2                	ld	ra,24(sp)
 622:	6442                	ld	s0,16(sp)
 624:	6161                	addi	sp,sp,80
 626:	8082                	ret

0000000000000628 <printf>:

void
printf(const char *fmt, ...)
{
 628:	711d                	addi	sp,sp,-96
 62a:	ec06                	sd	ra,24(sp)
 62c:	e822                	sd	s0,16(sp)
 62e:	1000                	addi	s0,sp,32
 630:	e40c                	sd	a1,8(s0)
 632:	e810                	sd	a2,16(s0)
 634:	ec14                	sd	a3,24(s0)
 636:	f018                	sd	a4,32(s0)
 638:	f41c                	sd	a5,40(s0)
 63a:	03043823          	sd	a6,48(s0)
 63e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 642:	00840613          	addi	a2,s0,8
 646:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 64a:	85aa                	mv	a1,a0
 64c:	4505                	li	a0,1
 64e:	00000097          	auipc	ra,0x0
 652:	de0080e7          	jalr	-544(ra) # 42e <vprintf>
}
 656:	60e2                	ld	ra,24(sp)
 658:	6442                	ld	s0,16(sp)
 65a:	6125                	addi	sp,sp,96
 65c:	8082                	ret

000000000000065e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 65e:	1141                	addi	sp,sp,-16
 660:	e406                	sd	ra,8(sp)
 662:	e022                	sd	s0,0(sp)
 664:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 666:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66a:	00000797          	auipc	a5,0x0
 66e:	5ce7b783          	ld	a5,1486(a5) # c38 <freep>
 672:	a02d                	j	69c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 674:	4618                	lw	a4,8(a2)
 676:	9f2d                	addw	a4,a4,a1
 678:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 67c:	6398                	ld	a4,0(a5)
 67e:	6310                	ld	a2,0(a4)
 680:	a83d                	j	6be <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 682:	ff852703          	lw	a4,-8(a0)
 686:	9f31                	addw	a4,a4,a2
 688:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 68a:	ff053683          	ld	a3,-16(a0)
 68e:	a091                	j	6d2 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 690:	6398                	ld	a4,0(a5)
 692:	00e7e463          	bltu	a5,a4,69a <free+0x3c>
 696:	00e6ea63          	bltu	a3,a4,6aa <free+0x4c>
{
 69a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69c:	fed7fae3          	bgeu	a5,a3,690 <free+0x32>
 6a0:	6398                	ld	a4,0(a5)
 6a2:	00e6e463          	bltu	a3,a4,6aa <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a6:	fee7eae3          	bltu	a5,a4,69a <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 6aa:	ff852583          	lw	a1,-8(a0)
 6ae:	6390                	ld	a2,0(a5)
 6b0:	02059813          	slli	a6,a1,0x20
 6b4:	01c85713          	srli	a4,a6,0x1c
 6b8:	9736                	add	a4,a4,a3
 6ba:	fae60de3          	beq	a2,a4,674 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 6be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6c2:	4790                	lw	a2,8(a5)
 6c4:	02061593          	slli	a1,a2,0x20
 6c8:	01c5d713          	srli	a4,a1,0x1c
 6cc:	973e                	add	a4,a4,a5
 6ce:	fae68ae3          	beq	a3,a4,682 <free+0x24>
    p->s.ptr = bp->s.ptr;
 6d2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6d4:	00000717          	auipc	a4,0x0
 6d8:	56f73223          	sd	a5,1380(a4) # c38 <freep>
}
 6dc:	60a2                	ld	ra,8(sp)
 6de:	6402                	ld	s0,0(sp)
 6e0:	0141                	addi	sp,sp,16
 6e2:	8082                	ret

00000000000006e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e4:	7139                	addi	sp,sp,-64
 6e6:	fc06                	sd	ra,56(sp)
 6e8:	f822                	sd	s0,48(sp)
 6ea:	f04a                	sd	s2,32(sp)
 6ec:	ec4e                	sd	s3,24(sp)
 6ee:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f0:	02051993          	slli	s3,a0,0x20
 6f4:	0209d993          	srli	s3,s3,0x20
 6f8:	09bd                	addi	s3,s3,15
 6fa:	0049d993          	srli	s3,s3,0x4
 6fe:	2985                	addiw	s3,s3,1
 700:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 702:	00000517          	auipc	a0,0x0
 706:	53653503          	ld	a0,1334(a0) # c38 <freep>
 70a:	c905                	beqz	a0,73a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 70c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 70e:	4798                	lw	a4,8(a5)
 710:	09377a63          	bgeu	a4,s3,7a4 <malloc+0xc0>
 714:	f426                	sd	s1,40(sp)
 716:	e852                	sd	s4,16(sp)
 718:	e456                	sd	s5,8(sp)
 71a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 71c:	8a4e                	mv	s4,s3
 71e:	6705                	lui	a4,0x1
 720:	00e9f363          	bgeu	s3,a4,726 <malloc+0x42>
 724:	6a05                	lui	s4,0x1
 726:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 72a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 72e:	00000497          	auipc	s1,0x0
 732:	50a48493          	addi	s1,s1,1290 # c38 <freep>
  if(p == (char*)-1)
 736:	5afd                	li	s5,-1
 738:	a089                	j	77a <malloc+0x96>
 73a:	f426                	sd	s1,40(sp)
 73c:	e852                	sd	s4,16(sp)
 73e:	e456                	sd	s5,8(sp)
 740:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 742:	00000797          	auipc	a5,0x0
 746:	4fe78793          	addi	a5,a5,1278 # c40 <base>
 74a:	00000717          	auipc	a4,0x0
 74e:	4ef73723          	sd	a5,1262(a4) # c38 <freep>
 752:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 754:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 758:	b7d1                	j	71c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 75a:	6398                	ld	a4,0(a5)
 75c:	e118                	sd	a4,0(a0)
 75e:	a8b9                	j	7bc <malloc+0xd8>
  hp->s.size = nu;
 760:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 764:	0541                	addi	a0,a0,16
 766:	00000097          	auipc	ra,0x0
 76a:	ef8080e7          	jalr	-264(ra) # 65e <free>
  return freep;
 76e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 770:	c135                	beqz	a0,7d4 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 772:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 774:	4798                	lw	a4,8(a5)
 776:	03277363          	bgeu	a4,s2,79c <malloc+0xb8>
    if(p == freep)
 77a:	6098                	ld	a4,0(s1)
 77c:	853e                	mv	a0,a5
 77e:	fef71ae3          	bne	a4,a5,772 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 782:	8552                	mv	a0,s4
 784:	00000097          	auipc	ra,0x0
 788:	bce080e7          	jalr	-1074(ra) # 352 <sbrk>
  if(p == (char*)-1)
 78c:	fd551ae3          	bne	a0,s5,760 <malloc+0x7c>
        return 0;
 790:	4501                	li	a0,0
 792:	74a2                	ld	s1,40(sp)
 794:	6a42                	ld	s4,16(sp)
 796:	6aa2                	ld	s5,8(sp)
 798:	6b02                	ld	s6,0(sp)
 79a:	a03d                	j	7c8 <malloc+0xe4>
 79c:	74a2                	ld	s1,40(sp)
 79e:	6a42                	ld	s4,16(sp)
 7a0:	6aa2                	ld	s5,8(sp)
 7a2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7a4:	fae90be3          	beq	s2,a4,75a <malloc+0x76>
        p->s.size -= nunits;
 7a8:	4137073b          	subw	a4,a4,s3
 7ac:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7ae:	02071693          	slli	a3,a4,0x20
 7b2:	01c6d713          	srli	a4,a3,0x1c
 7b6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7b8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7bc:	00000717          	auipc	a4,0x0
 7c0:	46a73e23          	sd	a0,1148(a4) # c38 <freep>
      return (void*)(p + 1);
 7c4:	01078513          	addi	a0,a5,16
  }
}
 7c8:	70e2                	ld	ra,56(sp)
 7ca:	7442                	ld	s0,48(sp)
 7cc:	7902                	ld	s2,32(sp)
 7ce:	69e2                	ld	s3,24(sp)
 7d0:	6121                	addi	sp,sp,64
 7d2:	8082                	ret
 7d4:	74a2                	ld	s1,40(sp)
 7d6:	6a42                	ld	s4,16(sp)
 7d8:	6aa2                	ld	s5,8(sp)
 7da:	6b02                	ld	s6,0(sp)
 7dc:	b7f5                	j	7c8 <malloc+0xe4>
