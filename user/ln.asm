
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	02f50163          	beq	a0,a5,2c <main+0x2c>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	80858593          	addi	a1,a1,-2040 # 818 <malloc+0xfc>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	618080e7          	jalr	1560(ra) # 632 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2de080e7          	jalr	734(ra) # 302 <exit>
  2c:	e426                	sd	s1,8(sp)
  2e:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  30:	698c                	ld	a1,16(a1)
  32:	6488                	ld	a0,8(s1)
  34:	00000097          	auipc	ra,0x0
  38:	32e080e7          	jalr	814(ra) # 362 <link>
  3c:	00054763          	bltz	a0,4a <main+0x4a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	2c0080e7          	jalr	704(ra) # 302 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4a:	6894                	ld	a3,16(s1)
  4c:	6490                	ld	a2,8(s1)
  4e:	00000597          	auipc	a1,0x0
  52:	7e258593          	addi	a1,a1,2018 # 830 <malloc+0x114>
  56:	4509                	li	a0,2
  58:	00000097          	auipc	ra,0x0
  5c:	5da080e7          	jalr	1498(ra) # 632 <fprintf>
  60:	b7c5                	j	40 <main+0x40>

0000000000000062 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  62:	1141                	addi	sp,sp,-16
  64:	e406                	sd	ra,8(sp)
  66:	e022                	sd	s0,0(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0xa>
    ;
  return os;
}
  7a:	60a2                	ld	ra,8(sp)
  7c:	6402                	ld	s0,0(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret

0000000000000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	1141                	addi	sp,sp,-16
  84:	e406                	sd	ra,8(sp)
  86:	e022                	sd	s0,0(sp)
  88:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  8a:	00054783          	lbu	a5,0(a0)
  8e:	cb91                	beqz	a5,a2 <strcmp+0x20>
  90:	0005c703          	lbu	a4,0(a1)
  94:	00f71763          	bne	a4,a5,a2 <strcmp+0x20>
    p++, q++;
  98:	0505                	addi	a0,a0,1
  9a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	fbe5                	bnez	a5,90 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a2:	0005c503          	lbu	a0,0(a1)
}
  a6:	40a7853b          	subw	a0,a5,a0
  aa:	60a2                	ld	ra,8(sp)
  ac:	6402                	ld	s0,0(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret

00000000000000b2 <strlen>:

uint
strlen(const char *s)
{
  b2:	1141                	addi	sp,sp,-16
  b4:	e406                	sd	ra,8(sp)
  b6:	e022                	sd	s0,0(sp)
  b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cf99                	beqz	a5,dc <strlen+0x2a>
  c0:	0505                	addi	a0,a0,1
  c2:	87aa                	mv	a5,a0
  c4:	86be                	mv	a3,a5
  c6:	0785                	addi	a5,a5,1
  c8:	fff7c703          	lbu	a4,-1(a5)
  cc:	ff65                	bnez	a4,c4 <strlen+0x12>
  ce:	40a6853b          	subw	a0,a3,a0
  d2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  d4:	60a2                	ld	ra,8(sp)
  d6:	6402                	ld	s0,0(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret
  for(n = 0; s[n]; n++)
  dc:	4501                	li	a0,0
  de:	bfdd                	j	d4 <strlen+0x22>

00000000000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e406                	sd	ra,8(sp)
  e4:	e022                	sd	s0,0(sp)
  e6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e8:	ca19                	beqz	a2,fe <memset+0x1e>
  ea:	87aa                	mv	a5,a0
  ec:	1602                	slli	a2,a2,0x20
  ee:	9201                	srli	a2,a2,0x20
  f0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f8:	0785                	addi	a5,a5,1
  fa:	fee79de3          	bne	a5,a4,f4 <memset+0x14>
  }
  return dst;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strchr>:

char*
strchr(const char *s, char c)
{
 106:	1141                	addi	sp,sp,-16
 108:	e406                	sd	ra,8(sp)
 10a:	e022                	sd	s0,0(sp)
 10c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cf81                	beqz	a5,12a <strchr+0x24>
    if(*s == c)
 114:	00f58763          	beq	a1,a5,122 <strchr+0x1c>
  for(; *s; s++)
 118:	0505                	addi	a0,a0,1
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbfd                	bnez	a5,114 <strchr+0xe>
      return (char*)s;
  return 0;
 120:	4501                	li	a0,0
}
 122:	60a2                	ld	ra,8(sp)
 124:	6402                	ld	s0,0(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret
  return 0;
 12a:	4501                	li	a0,0
 12c:	bfdd                	j	122 <strchr+0x1c>

000000000000012e <gets>:

char*
gets(char *buf, int max)
{
 12e:	7159                	addi	sp,sp,-112
 130:	f486                	sd	ra,104(sp)
 132:	f0a2                	sd	s0,96(sp)
 134:	eca6                	sd	s1,88(sp)
 136:	e8ca                	sd	s2,80(sp)
 138:	e4ce                	sd	s3,72(sp)
 13a:	e0d2                	sd	s4,64(sp)
 13c:	fc56                	sd	s5,56(sp)
 13e:	f85a                	sd	s6,48(sp)
 140:	f45e                	sd	s7,40(sp)
 142:	f062                	sd	s8,32(sp)
 144:	ec66                	sd	s9,24(sp)
 146:	e86a                	sd	s10,16(sp)
 148:	1880                	addi	s0,sp,112
 14a:	8caa                	mv	s9,a0
 14c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14e:	892a                	mv	s2,a0
 150:	4481                	li	s1,0
    cc = read(0, &c, 1);
 152:	f9f40b13          	addi	s6,s0,-97
 156:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 158:	4ba9                	li	s7,10
 15a:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 15c:	8d26                	mv	s10,s1
 15e:	0014899b          	addiw	s3,s1,1
 162:	84ce                	mv	s1,s3
 164:	0349d763          	bge	s3,s4,192 <gets+0x64>
    cc = read(0, &c, 1);
 168:	8656                	mv	a2,s5
 16a:	85da                	mv	a1,s6
 16c:	4501                	li	a0,0
 16e:	00000097          	auipc	ra,0x0
 172:	1ac080e7          	jalr	428(ra) # 31a <read>
    if(cc < 1)
 176:	00a05e63          	blez	a0,192 <gets+0x64>
    buf[i++] = c;
 17a:	f9f44783          	lbu	a5,-97(s0)
 17e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 182:	01778763          	beq	a5,s7,190 <gets+0x62>
 186:	0905                	addi	s2,s2,1
 188:	fd879ae3          	bne	a5,s8,15c <gets+0x2e>
    buf[i++] = c;
 18c:	8d4e                	mv	s10,s3
 18e:	a011                	j	192 <gets+0x64>
 190:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 192:	9d66                	add	s10,s10,s9
 194:	000d0023          	sb	zero,0(s10)
  return buf;
}
 198:	8566                	mv	a0,s9
 19a:	70a6                	ld	ra,104(sp)
 19c:	7406                	ld	s0,96(sp)
 19e:	64e6                	ld	s1,88(sp)
 1a0:	6946                	ld	s2,80(sp)
 1a2:	69a6                	ld	s3,72(sp)
 1a4:	6a06                	ld	s4,64(sp)
 1a6:	7ae2                	ld	s5,56(sp)
 1a8:	7b42                	ld	s6,48(sp)
 1aa:	7ba2                	ld	s7,40(sp)
 1ac:	7c02                	ld	s8,32(sp)
 1ae:	6ce2                	ld	s9,24(sp)
 1b0:	6d42                	ld	s10,16(sp)
 1b2:	6165                	addi	sp,sp,112
 1b4:	8082                	ret

00000000000001b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b6:	1101                	addi	sp,sp,-32
 1b8:	ec06                	sd	ra,24(sp)
 1ba:	e822                	sd	s0,16(sp)
 1bc:	e04a                	sd	s2,0(sp)
 1be:	1000                	addi	s0,sp,32
 1c0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c2:	4581                	li	a1,0
 1c4:	00000097          	auipc	ra,0x0
 1c8:	17e080e7          	jalr	382(ra) # 342 <open>
  if(fd < 0)
 1cc:	02054663          	bltz	a0,1f8 <stat+0x42>
 1d0:	e426                	sd	s1,8(sp)
 1d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d4:	85ca                	mv	a1,s2
 1d6:	00000097          	auipc	ra,0x0
 1da:	184080e7          	jalr	388(ra) # 35a <fstat>
 1de:	892a                	mv	s2,a0
  close(fd);
 1e0:	8526                	mv	a0,s1
 1e2:	00000097          	auipc	ra,0x0
 1e6:	148080e7          	jalr	328(ra) # 32a <close>
  return r;
 1ea:	64a2                	ld	s1,8(sp)
}
 1ec:	854a                	mv	a0,s2
 1ee:	60e2                	ld	ra,24(sp)
 1f0:	6442                	ld	s0,16(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
    return -1;
 1f8:	597d                	li	s2,-1
 1fa:	bfcd                	j	1ec <stat+0x36>

00000000000001fc <atoi>:

int
atoi(const char *s)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e406                	sd	ra,8(sp)
 200:	e022                	sd	s0,0(sp)
 202:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 204:	00054683          	lbu	a3,0(a0)
 208:	fd06879b          	addiw	a5,a3,-48
 20c:	0ff7f793          	zext.b	a5,a5
 210:	4625                	li	a2,9
 212:	02f66963          	bltu	a2,a5,244 <atoi+0x48>
 216:	872a                	mv	a4,a0
  n = 0;
 218:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 21a:	0705                	addi	a4,a4,1
 21c:	0025179b          	slliw	a5,a0,0x2
 220:	9fa9                	addw	a5,a5,a0
 222:	0017979b          	slliw	a5,a5,0x1
 226:	9fb5                	addw	a5,a5,a3
 228:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22c:	00074683          	lbu	a3,0(a4)
 230:	fd06879b          	addiw	a5,a3,-48
 234:	0ff7f793          	zext.b	a5,a5
 238:	fef671e3          	bgeu	a2,a5,21a <atoi+0x1e>
  return n;
}
 23c:	60a2                	ld	ra,8(sp)
 23e:	6402                	ld	s0,0(sp)
 240:	0141                	addi	sp,sp,16
 242:	8082                	ret
  n = 0;
 244:	4501                	li	a0,0
 246:	bfdd                	j	23c <atoi+0x40>

0000000000000248 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e406                	sd	ra,8(sp)
 24c:	e022                	sd	s0,0(sp)
 24e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 250:	02b57563          	bgeu	a0,a1,27a <memmove+0x32>
    while(n-- > 0)
 254:	00c05f63          	blez	a2,272 <memmove+0x2a>
 258:	1602                	slli	a2,a2,0x20
 25a:	9201                	srli	a2,a2,0x20
 25c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 260:	872a                	mv	a4,a0
      *dst++ = *src++;
 262:	0585                	addi	a1,a1,1
 264:	0705                	addi	a4,a4,1
 266:	fff5c683          	lbu	a3,-1(a1)
 26a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 26e:	fee79ae3          	bne	a5,a4,262 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 272:	60a2                	ld	ra,8(sp)
 274:	6402                	ld	s0,0(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
    dst += n;
 27a:	00c50733          	add	a4,a0,a2
    src += n;
 27e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 280:	fec059e3          	blez	a2,272 <memmove+0x2a>
 284:	fff6079b          	addiw	a5,a2,-1
 288:	1782                	slli	a5,a5,0x20
 28a:	9381                	srli	a5,a5,0x20
 28c:	fff7c793          	not	a5,a5
 290:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 292:	15fd                	addi	a1,a1,-1
 294:	177d                	addi	a4,a4,-1
 296:	0005c683          	lbu	a3,0(a1)
 29a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 29e:	fef71ae3          	bne	a4,a5,292 <memmove+0x4a>
 2a2:	bfc1                	j	272 <memmove+0x2a>

00000000000002a4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ac:	ca0d                	beqz	a2,2de <memcmp+0x3a>
 2ae:	fff6069b          	addiw	a3,a2,-1
 2b2:	1682                	slli	a3,a3,0x20
 2b4:	9281                	srli	a3,a3,0x20
 2b6:	0685                	addi	a3,a3,1
 2b8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	0005c703          	lbu	a4,0(a1)
 2c2:	00e79863          	bne	a5,a4,2d2 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2c6:	0505                	addi	a0,a0,1
    p2++;
 2c8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ca:	fed518e3          	bne	a0,a3,2ba <memcmp+0x16>
  }
  return 0;
 2ce:	4501                	li	a0,0
 2d0:	a019                	j	2d6 <memcmp+0x32>
      return *p1 - *p2;
 2d2:	40e7853b          	subw	a0,a5,a4
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  return 0;
 2de:	4501                	li	a0,0
 2e0:	bfdd                	j	2d6 <memcmp+0x32>

00000000000002e2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e406                	sd	ra,8(sp)
 2e6:	e022                	sd	s0,0(sp)
 2e8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ea:	00000097          	auipc	ra,0x0
 2ee:	f5e080e7          	jalr	-162(ra) # 248 <memmove>
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2fa:	4885                	li	a7,1
 ecall
 2fc:	00000073          	ecall
 ret
 300:	8082                	ret

0000000000000302 <exit>:
.global exit
exit:
 li a7, SYS_exit
 302:	4889                	li	a7,2
 ecall
 304:	00000073          	ecall
 ret
 308:	8082                	ret

000000000000030a <wait>:
.global wait
wait:
 li a7, SYS_wait
 30a:	488d                	li	a7,3
 ecall
 30c:	00000073          	ecall
 ret
 310:	8082                	ret

0000000000000312 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 312:	4891                	li	a7,4
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <read>:
.global read
read:
 li a7, SYS_read
 31a:	4895                	li	a7,5
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <write>:
.global write
write:
 li a7, SYS_write
 322:	48c1                	li	a7,16
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <close>:
.global close
close:
 li a7, SYS_close
 32a:	48d5                	li	a7,21
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <kill>:
.global kill
kill:
 li a7, SYS_kill
 332:	4899                	li	a7,6
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <exec>:
.global exec
exec:
 li a7, SYS_exec
 33a:	489d                	li	a7,7
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <open>:
.global open
open:
 li a7, SYS_open
 342:	48bd                	li	a7,15
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 34a:	48c5                	li	a7,17
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 352:	48c9                	li	a7,18
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 35a:	48a1                	li	a7,8
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <link>:
.global link
link:
 li a7, SYS_link
 362:	48cd                	li	a7,19
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 36a:	48d1                	li	a7,20
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 372:	48a5                	li	a7,9
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <dup>:
.global dup
dup:
 li a7, SYS_dup
 37a:	48a9                	li	a7,10
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 382:	48ad                	li	a7,11
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 38a:	48b1                	li	a7,12
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 392:	48b5                	li	a7,13
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 39a:	48b9                	li	a7,14
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3a2:	48d9                	li	a7,22
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3aa:	1101                	addi	sp,sp,-32
 3ac:	ec06                	sd	ra,24(sp)
 3ae:	e822                	sd	s0,16(sp)
 3b0:	1000                	addi	s0,sp,32
 3b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3b6:	4605                	li	a2,1
 3b8:	fef40593          	addi	a1,s0,-17
 3bc:	00000097          	auipc	ra,0x0
 3c0:	f66080e7          	jalr	-154(ra) # 322 <write>
}
 3c4:	60e2                	ld	ra,24(sp)
 3c6:	6442                	ld	s0,16(sp)
 3c8:	6105                	addi	sp,sp,32
 3ca:	8082                	ret

00000000000003cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3cc:	7139                	addi	sp,sp,-64
 3ce:	fc06                	sd	ra,56(sp)
 3d0:	f822                	sd	s0,48(sp)
 3d2:	f426                	sd	s1,40(sp)
 3d4:	f04a                	sd	s2,32(sp)
 3d6:	ec4e                	sd	s3,24(sp)
 3d8:	0080                	addi	s0,sp,64
 3da:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3dc:	c299                	beqz	a3,3e2 <printint+0x16>
 3de:	0805c063          	bltz	a1,45e <printint+0x92>
  neg = 0;
 3e2:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3e4:	fc040313          	addi	t1,s0,-64
  neg = 0;
 3e8:	869a                	mv	a3,t1
  i = 0;
 3ea:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3ec:	00000817          	auipc	a6,0x0
 3f0:	4bc80813          	addi	a6,a6,1212 # 8a8 <digits>
 3f4:	88be                	mv	a7,a5
 3f6:	0017851b          	addiw	a0,a5,1
 3fa:	87aa                	mv	a5,a0
 3fc:	02c5f73b          	remuw	a4,a1,a2
 400:	1702                	slli	a4,a4,0x20
 402:	9301                	srli	a4,a4,0x20
 404:	9742                	add	a4,a4,a6
 406:	00074703          	lbu	a4,0(a4)
 40a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 40e:	872e                	mv	a4,a1
 410:	02c5d5bb          	divuw	a1,a1,a2
 414:	0685                	addi	a3,a3,1
 416:	fcc77fe3          	bgeu	a4,a2,3f4 <printint+0x28>
  if(neg)
 41a:	000e0c63          	beqz	t3,432 <printint+0x66>
    buf[i++] = '-';
 41e:	fd050793          	addi	a5,a0,-48
 422:	00878533          	add	a0,a5,s0
 426:	02d00793          	li	a5,45
 42a:	fef50823          	sb	a5,-16(a0)
 42e:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 432:	fff7899b          	addiw	s3,a5,-1
 436:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 43a:	fff4c583          	lbu	a1,-1(s1)
 43e:	854a                	mv	a0,s2
 440:	00000097          	auipc	ra,0x0
 444:	f6a080e7          	jalr	-150(ra) # 3aa <putc>
  while(--i >= 0)
 448:	39fd                	addiw	s3,s3,-1
 44a:	14fd                	addi	s1,s1,-1
 44c:	fe09d7e3          	bgez	s3,43a <printint+0x6e>
}
 450:	70e2                	ld	ra,56(sp)
 452:	7442                	ld	s0,48(sp)
 454:	74a2                	ld	s1,40(sp)
 456:	7902                	ld	s2,32(sp)
 458:	69e2                	ld	s3,24(sp)
 45a:	6121                	addi	sp,sp,64
 45c:	8082                	ret
    x = -xx;
 45e:	40b005bb          	negw	a1,a1
    neg = 1;
 462:	4e05                	li	t3,1
    x = -xx;
 464:	b741                	j	3e4 <printint+0x18>

0000000000000466 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 466:	715d                	addi	sp,sp,-80
 468:	e486                	sd	ra,72(sp)
 46a:	e0a2                	sd	s0,64(sp)
 46c:	f84a                	sd	s2,48(sp)
 46e:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 470:	0005c903          	lbu	s2,0(a1)
 474:	1a090a63          	beqz	s2,628 <vprintf+0x1c2>
 478:	fc26                	sd	s1,56(sp)
 47a:	f44e                	sd	s3,40(sp)
 47c:	f052                	sd	s4,32(sp)
 47e:	ec56                	sd	s5,24(sp)
 480:	e85a                	sd	s6,16(sp)
 482:	e45e                	sd	s7,8(sp)
 484:	8aaa                	mv	s5,a0
 486:	8bb2                	mv	s7,a2
 488:	00158493          	addi	s1,a1,1
  state = 0;
 48c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 48e:	02500a13          	li	s4,37
 492:	4b55                	li	s6,21
 494:	a839                	j	4b2 <vprintf+0x4c>
        putc(fd, c);
 496:	85ca                	mv	a1,s2
 498:	8556                	mv	a0,s5
 49a:	00000097          	auipc	ra,0x0
 49e:	f10080e7          	jalr	-240(ra) # 3aa <putc>
 4a2:	a019                	j	4a8 <vprintf+0x42>
    } else if(state == '%'){
 4a4:	01498d63          	beq	s3,s4,4be <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 4a8:	0485                	addi	s1,s1,1
 4aa:	fff4c903          	lbu	s2,-1(s1)
 4ae:	16090763          	beqz	s2,61c <vprintf+0x1b6>
    if(state == 0){
 4b2:	fe0999e3          	bnez	s3,4a4 <vprintf+0x3e>
      if(c == '%'){
 4b6:	ff4910e3          	bne	s2,s4,496 <vprintf+0x30>
        state = '%';
 4ba:	89d2                	mv	s3,s4
 4bc:	b7f5                	j	4a8 <vprintf+0x42>
      if(c == 'd'){
 4be:	13490463          	beq	s2,s4,5e6 <vprintf+0x180>
 4c2:	f9d9079b          	addiw	a5,s2,-99
 4c6:	0ff7f793          	zext.b	a5,a5
 4ca:	12fb6763          	bltu	s6,a5,5f8 <vprintf+0x192>
 4ce:	f9d9079b          	addiw	a5,s2,-99
 4d2:	0ff7f713          	zext.b	a4,a5
 4d6:	12eb6163          	bltu	s6,a4,5f8 <vprintf+0x192>
 4da:	00271793          	slli	a5,a4,0x2
 4de:	00000717          	auipc	a4,0x0
 4e2:	37270713          	addi	a4,a4,882 # 850 <malloc+0x134>
 4e6:	97ba                	add	a5,a5,a4
 4e8:	439c                	lw	a5,0(a5)
 4ea:	97ba                	add	a5,a5,a4
 4ec:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4ee:	008b8913          	addi	s2,s7,8
 4f2:	4685                	li	a3,1
 4f4:	4629                	li	a2,10
 4f6:	000ba583          	lw	a1,0(s7)
 4fa:	8556                	mv	a0,s5
 4fc:	00000097          	auipc	ra,0x0
 500:	ed0080e7          	jalr	-304(ra) # 3cc <printint>
 504:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 506:	4981                	li	s3,0
 508:	b745                	j	4a8 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 50a:	008b8913          	addi	s2,s7,8
 50e:	4681                	li	a3,0
 510:	4629                	li	a2,10
 512:	000ba583          	lw	a1,0(s7)
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	eb4080e7          	jalr	-332(ra) # 3cc <printint>
 520:	8bca                	mv	s7,s2
      state = 0;
 522:	4981                	li	s3,0
 524:	b751                	j	4a8 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 526:	008b8913          	addi	s2,s7,8
 52a:	4681                	li	a3,0
 52c:	4641                	li	a2,16
 52e:	000ba583          	lw	a1,0(s7)
 532:	8556                	mv	a0,s5
 534:	00000097          	auipc	ra,0x0
 538:	e98080e7          	jalr	-360(ra) # 3cc <printint>
 53c:	8bca                	mv	s7,s2
      state = 0;
 53e:	4981                	li	s3,0
 540:	b7a5                	j	4a8 <vprintf+0x42>
 542:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 544:	008b8c13          	addi	s8,s7,8
 548:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 54c:	03000593          	li	a1,48
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	e58080e7          	jalr	-424(ra) # 3aa <putc>
  putc(fd, 'x');
 55a:	07800593          	li	a1,120
 55e:	8556                	mv	a0,s5
 560:	00000097          	auipc	ra,0x0
 564:	e4a080e7          	jalr	-438(ra) # 3aa <putc>
 568:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 56a:	00000b97          	auipc	s7,0x0
 56e:	33eb8b93          	addi	s7,s7,830 # 8a8 <digits>
 572:	03c9d793          	srli	a5,s3,0x3c
 576:	97de                	add	a5,a5,s7
 578:	0007c583          	lbu	a1,0(a5)
 57c:	8556                	mv	a0,s5
 57e:	00000097          	auipc	ra,0x0
 582:	e2c080e7          	jalr	-468(ra) # 3aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 586:	0992                	slli	s3,s3,0x4
 588:	397d                	addiw	s2,s2,-1
 58a:	fe0914e3          	bnez	s2,572 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 58e:	8be2                	mv	s7,s8
      state = 0;
 590:	4981                	li	s3,0
 592:	6c02                	ld	s8,0(sp)
 594:	bf11                	j	4a8 <vprintf+0x42>
        s = va_arg(ap, char*);
 596:	008b8993          	addi	s3,s7,8
 59a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 59e:	02090163          	beqz	s2,5c0 <vprintf+0x15a>
        while(*s != 0){
 5a2:	00094583          	lbu	a1,0(s2)
 5a6:	c9a5                	beqz	a1,616 <vprintf+0x1b0>
          putc(fd, *s);
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	e00080e7          	jalr	-512(ra) # 3aa <putc>
          s++;
 5b2:	0905                	addi	s2,s2,1
        while(*s != 0){
 5b4:	00094583          	lbu	a1,0(s2)
 5b8:	f9e5                	bnez	a1,5a8 <vprintf+0x142>
        s = va_arg(ap, char*);
 5ba:	8bce                	mv	s7,s3
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	b5ed                	j	4a8 <vprintf+0x42>
          s = "(null)";
 5c0:	00000917          	auipc	s2,0x0
 5c4:	28890913          	addi	s2,s2,648 # 848 <malloc+0x12c>
        while(*s != 0){
 5c8:	02800593          	li	a1,40
 5cc:	bff1                	j	5a8 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 5ce:	008b8913          	addi	s2,s7,8
 5d2:	000bc583          	lbu	a1,0(s7)
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	dd2080e7          	jalr	-558(ra) # 3aa <putc>
 5e0:	8bca                	mv	s7,s2
      state = 0;
 5e2:	4981                	li	s3,0
 5e4:	b5d1                	j	4a8 <vprintf+0x42>
        putc(fd, c);
 5e6:	02500593          	li	a1,37
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	dbe080e7          	jalr	-578(ra) # 3aa <putc>
      state = 0;
 5f4:	4981                	li	s3,0
 5f6:	bd4d                	j	4a8 <vprintf+0x42>
        putc(fd, '%');
 5f8:	02500593          	li	a1,37
 5fc:	8556                	mv	a0,s5
 5fe:	00000097          	auipc	ra,0x0
 602:	dac080e7          	jalr	-596(ra) # 3aa <putc>
        putc(fd, c);
 606:	85ca                	mv	a1,s2
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	da0080e7          	jalr	-608(ra) # 3aa <putc>
      state = 0;
 612:	4981                	li	s3,0
 614:	bd51                	j	4a8 <vprintf+0x42>
        s = va_arg(ap, char*);
 616:	8bce                	mv	s7,s3
      state = 0;
 618:	4981                	li	s3,0
 61a:	b579                	j	4a8 <vprintf+0x42>
 61c:	74e2                	ld	s1,56(sp)
 61e:	79a2                	ld	s3,40(sp)
 620:	7a02                	ld	s4,32(sp)
 622:	6ae2                	ld	s5,24(sp)
 624:	6b42                	ld	s6,16(sp)
 626:	6ba2                	ld	s7,8(sp)
    }
  }
}
 628:	60a6                	ld	ra,72(sp)
 62a:	6406                	ld	s0,64(sp)
 62c:	7942                	ld	s2,48(sp)
 62e:	6161                	addi	sp,sp,80
 630:	8082                	ret

0000000000000632 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 632:	715d                	addi	sp,sp,-80
 634:	ec06                	sd	ra,24(sp)
 636:	e822                	sd	s0,16(sp)
 638:	1000                	addi	s0,sp,32
 63a:	e010                	sd	a2,0(s0)
 63c:	e414                	sd	a3,8(s0)
 63e:	e818                	sd	a4,16(s0)
 640:	ec1c                	sd	a5,24(s0)
 642:	03043023          	sd	a6,32(s0)
 646:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 64a:	8622                	mv	a2,s0
 64c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 650:	00000097          	auipc	ra,0x0
 654:	e16080e7          	jalr	-490(ra) # 466 <vprintf>
}
 658:	60e2                	ld	ra,24(sp)
 65a:	6442                	ld	s0,16(sp)
 65c:	6161                	addi	sp,sp,80
 65e:	8082                	ret

0000000000000660 <printf>:

void
printf(const char *fmt, ...)
{
 660:	711d                	addi	sp,sp,-96
 662:	ec06                	sd	ra,24(sp)
 664:	e822                	sd	s0,16(sp)
 666:	1000                	addi	s0,sp,32
 668:	e40c                	sd	a1,8(s0)
 66a:	e810                	sd	a2,16(s0)
 66c:	ec14                	sd	a3,24(s0)
 66e:	f018                	sd	a4,32(s0)
 670:	f41c                	sd	a5,40(s0)
 672:	03043823          	sd	a6,48(s0)
 676:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 67a:	00840613          	addi	a2,s0,8
 67e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 682:	85aa                	mv	a1,a0
 684:	4505                	li	a0,1
 686:	00000097          	auipc	ra,0x0
 68a:	de0080e7          	jalr	-544(ra) # 466 <vprintf>
}
 68e:	60e2                	ld	ra,24(sp)
 690:	6442                	ld	s0,16(sp)
 692:	6125                	addi	sp,sp,96
 694:	8082                	ret

0000000000000696 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 696:	1141                	addi	sp,sp,-16
 698:	e406                	sd	ra,8(sp)
 69a:	e022                	sd	s0,0(sp)
 69c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 69e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a2:	00000797          	auipc	a5,0x0
 6a6:	6067b783          	ld	a5,1542(a5) # ca8 <freep>
 6aa:	a02d                	j	6d4 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ac:	4618                	lw	a4,8(a2)
 6ae:	9f2d                	addw	a4,a4,a1
 6b0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b4:	6398                	ld	a4,0(a5)
 6b6:	6310                	ld	a2,0(a4)
 6b8:	a83d                	j	6f6 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6ba:	ff852703          	lw	a4,-8(a0)
 6be:	9f31                	addw	a4,a4,a2
 6c0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6c2:	ff053683          	ld	a3,-16(a0)
 6c6:	a091                	j	70a <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c8:	6398                	ld	a4,0(a5)
 6ca:	00e7e463          	bltu	a5,a4,6d2 <free+0x3c>
 6ce:	00e6ea63          	bltu	a3,a4,6e2 <free+0x4c>
{
 6d2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d4:	fed7fae3          	bgeu	a5,a3,6c8 <free+0x32>
 6d8:	6398                	ld	a4,0(a5)
 6da:	00e6e463          	bltu	a3,a4,6e2 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	fee7eae3          	bltu	a5,a4,6d2 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 6e2:	ff852583          	lw	a1,-8(a0)
 6e6:	6390                	ld	a2,0(a5)
 6e8:	02059813          	slli	a6,a1,0x20
 6ec:	01c85713          	srli	a4,a6,0x1c
 6f0:	9736                	add	a4,a4,a3
 6f2:	fae60de3          	beq	a2,a4,6ac <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 6f6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6fa:	4790                	lw	a2,8(a5)
 6fc:	02061593          	slli	a1,a2,0x20
 700:	01c5d713          	srli	a4,a1,0x1c
 704:	973e                	add	a4,a4,a5
 706:	fae68ae3          	beq	a3,a4,6ba <free+0x24>
    p->s.ptr = bp->s.ptr;
 70a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 70c:	00000717          	auipc	a4,0x0
 710:	58f73e23          	sd	a5,1436(a4) # ca8 <freep>
}
 714:	60a2                	ld	ra,8(sp)
 716:	6402                	ld	s0,0(sp)
 718:	0141                	addi	sp,sp,16
 71a:	8082                	ret

000000000000071c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 71c:	7139                	addi	sp,sp,-64
 71e:	fc06                	sd	ra,56(sp)
 720:	f822                	sd	s0,48(sp)
 722:	f04a                	sd	s2,32(sp)
 724:	ec4e                	sd	s3,24(sp)
 726:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 728:	02051993          	slli	s3,a0,0x20
 72c:	0209d993          	srli	s3,s3,0x20
 730:	09bd                	addi	s3,s3,15
 732:	0049d993          	srli	s3,s3,0x4
 736:	2985                	addiw	s3,s3,1
 738:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 73a:	00000517          	auipc	a0,0x0
 73e:	56e53503          	ld	a0,1390(a0) # ca8 <freep>
 742:	c905                	beqz	a0,772 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 744:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 746:	4798                	lw	a4,8(a5)
 748:	09377a63          	bgeu	a4,s3,7dc <malloc+0xc0>
 74c:	f426                	sd	s1,40(sp)
 74e:	e852                	sd	s4,16(sp)
 750:	e456                	sd	s5,8(sp)
 752:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 754:	8a4e                	mv	s4,s3
 756:	6705                	lui	a4,0x1
 758:	00e9f363          	bgeu	s3,a4,75e <malloc+0x42>
 75c:	6a05                	lui	s4,0x1
 75e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 762:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 766:	00000497          	auipc	s1,0x0
 76a:	54248493          	addi	s1,s1,1346 # ca8 <freep>
  if(p == (char*)-1)
 76e:	5afd                	li	s5,-1
 770:	a089                	j	7b2 <malloc+0x96>
 772:	f426                	sd	s1,40(sp)
 774:	e852                	sd	s4,16(sp)
 776:	e456                	sd	s5,8(sp)
 778:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 77a:	00000797          	auipc	a5,0x0
 77e:	53678793          	addi	a5,a5,1334 # cb0 <base>
 782:	00000717          	auipc	a4,0x0
 786:	52f73323          	sd	a5,1318(a4) # ca8 <freep>
 78a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 78c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 790:	b7d1                	j	754 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 792:	6398                	ld	a4,0(a5)
 794:	e118                	sd	a4,0(a0)
 796:	a8b9                	j	7f4 <malloc+0xd8>
  hp->s.size = nu;
 798:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 79c:	0541                	addi	a0,a0,16
 79e:	00000097          	auipc	ra,0x0
 7a2:	ef8080e7          	jalr	-264(ra) # 696 <free>
  return freep;
 7a6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7a8:	c135                	beqz	a0,80c <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7ac:	4798                	lw	a4,8(a5)
 7ae:	03277363          	bgeu	a4,s2,7d4 <malloc+0xb8>
    if(p == freep)
 7b2:	6098                	ld	a4,0(s1)
 7b4:	853e                	mv	a0,a5
 7b6:	fef71ae3          	bne	a4,a5,7aa <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7ba:	8552                	mv	a0,s4
 7bc:	00000097          	auipc	ra,0x0
 7c0:	bce080e7          	jalr	-1074(ra) # 38a <sbrk>
  if(p == (char*)-1)
 7c4:	fd551ae3          	bne	a0,s5,798 <malloc+0x7c>
        return 0;
 7c8:	4501                	li	a0,0
 7ca:	74a2                	ld	s1,40(sp)
 7cc:	6a42                	ld	s4,16(sp)
 7ce:	6aa2                	ld	s5,8(sp)
 7d0:	6b02                	ld	s6,0(sp)
 7d2:	a03d                	j	800 <malloc+0xe4>
 7d4:	74a2                	ld	s1,40(sp)
 7d6:	6a42                	ld	s4,16(sp)
 7d8:	6aa2                	ld	s5,8(sp)
 7da:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7dc:	fae90be3          	beq	s2,a4,792 <malloc+0x76>
        p->s.size -= nunits;
 7e0:	4137073b          	subw	a4,a4,s3
 7e4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7e6:	02071693          	slli	a3,a4,0x20
 7ea:	01c6d713          	srli	a4,a3,0x1c
 7ee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7f0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7f4:	00000717          	auipc	a4,0x0
 7f8:	4aa73a23          	sd	a0,1204(a4) # ca8 <freep>
      return (void*)(p + 1);
 7fc:	01078513          	addi	a0,a5,16
  }
}
 800:	70e2                	ld	ra,56(sp)
 802:	7442                	ld	s0,48(sp)
 804:	7902                	ld	s2,32(sp)
 806:	69e2                	ld	s3,24(sp)
 808:	6121                	addi	sp,sp,64
 80a:	8082                	ret
 80c:	74a2                	ld	s1,40(sp)
 80e:	6a42                	ld	s4,16(sp)
 810:	6aa2                	ld	s5,8(sp)
 812:	6b02                	ld	s6,0(sp)
 814:	b7f5                	j	800 <malloc+0xe4>
