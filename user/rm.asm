
user/_rm:     file format elf64-littleriscv


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
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7dd63          	bge	a5,a0,44 <main+0x44>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	342080e7          	jalr	834(ra) # 36a <unlink>
  30:	02054a63          	bltz	a0,64 <main+0x64>
  for(i = 1; i < argc; i++){
  34:	04a1                	addi	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	2de080e7          	jalr	734(ra) # 31a <exit>
  44:	e426                	sd	s1,8(sp)
  46:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: rm files...\n");
  48:	00000597          	auipc	a1,0x0
  4c:	7e858593          	addi	a1,a1,2024 # 830 <malloc+0xfc>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	5f8080e7          	jalr	1528(ra) # 64a <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2be080e7          	jalr	702(ra) # 31a <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  64:	6090                	ld	a2,0(s1)
  66:	00000597          	auipc	a1,0x0
  6a:	7e258593          	addi	a1,a1,2018 # 848 <malloc+0x114>
  6e:	4509                	li	a0,2
  70:	00000097          	auipc	ra,0x0
  74:	5da080e7          	jalr	1498(ra) # 64a <fprintf>
      break;
  78:	b7c9                	j	3a <main+0x3a>

000000000000007a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  82:	87aa                	mv	a5,a0
  84:	0585                	addi	a1,a1,1
  86:	0785                	addi	a5,a5,1
  88:	fff5c703          	lbu	a4,-1(a1)
  8c:	fee78fa3          	sb	a4,-1(a5)
  90:	fb75                	bnez	a4,84 <strcpy+0xa>
    ;
  return os;
}
  92:	60a2                	ld	ra,8(sp)
  94:	6402                	ld	s0,0(sp)
  96:	0141                	addi	sp,sp,16
  98:	8082                	ret

000000000000009a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9a:	1141                	addi	sp,sp,-16
  9c:	e406                	sd	ra,8(sp)
  9e:	e022                	sd	s0,0(sp)
  a0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	cb91                	beqz	a5,ba <strcmp+0x20>
  a8:	0005c703          	lbu	a4,0(a1)
  ac:	00f71763          	bne	a4,a5,ba <strcmp+0x20>
    p++, q++;
  b0:	0505                	addi	a0,a0,1
  b2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	fbe5                	bnez	a5,a8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ba:	0005c503          	lbu	a0,0(a1)
}
  be:	40a7853b          	subw	a0,a5,a0
  c2:	60a2                	ld	ra,8(sp)
  c4:	6402                	ld	s0,0(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret

00000000000000ca <strlen>:

uint
strlen(const char *s)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e406                	sd	ra,8(sp)
  ce:	e022                	sd	s0,0(sp)
  d0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	cf99                	beqz	a5,f4 <strlen+0x2a>
  d8:	0505                	addi	a0,a0,1
  da:	87aa                	mv	a5,a0
  dc:	86be                	mv	a3,a5
  de:	0785                	addi	a5,a5,1
  e0:	fff7c703          	lbu	a4,-1(a5)
  e4:	ff65                	bnez	a4,dc <strlen+0x12>
  e6:	40a6853b          	subw	a0,a3,a0
  ea:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  ec:	60a2                	ld	ra,8(sp)
  ee:	6402                	ld	s0,0(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret
  for(n = 0; s[n]; n++)
  f4:	4501                	li	a0,0
  f6:	bfdd                	j	ec <strlen+0x22>

00000000000000f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 100:	ca19                	beqz	a2,116 <memset+0x1e>
 102:	87aa                	mv	a5,a0
 104:	1602                	slli	a2,a2,0x20
 106:	9201                	srli	a2,a2,0x20
 108:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 10c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 110:	0785                	addi	a5,a5,1
 112:	fee79de3          	bne	a5,a4,10c <memset+0x14>
  }
  return dst;
}
 116:	60a2                	ld	ra,8(sp)
 118:	6402                	ld	s0,0(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strchr>:

char*
strchr(const char *s, char c)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  for(; *s; s++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cf81                	beqz	a5,142 <strchr+0x24>
    if(*s == c)
 12c:	00f58763          	beq	a1,a5,13a <strchr+0x1c>
  for(; *s; s++)
 130:	0505                	addi	a0,a0,1
 132:	00054783          	lbu	a5,0(a0)
 136:	fbfd                	bnez	a5,12c <strchr+0xe>
      return (char*)s;
  return 0;
 138:	4501                	li	a0,0
}
 13a:	60a2                	ld	ra,8(sp)
 13c:	6402                	ld	s0,0(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
  return 0;
 142:	4501                	li	a0,0
 144:	bfdd                	j	13a <strchr+0x1c>

0000000000000146 <gets>:

char*
gets(char *buf, int max)
{
 146:	7159                	addi	sp,sp,-112
 148:	f486                	sd	ra,104(sp)
 14a:	f0a2                	sd	s0,96(sp)
 14c:	eca6                	sd	s1,88(sp)
 14e:	e8ca                	sd	s2,80(sp)
 150:	e4ce                	sd	s3,72(sp)
 152:	e0d2                	sd	s4,64(sp)
 154:	fc56                	sd	s5,56(sp)
 156:	f85a                	sd	s6,48(sp)
 158:	f45e                	sd	s7,40(sp)
 15a:	f062                	sd	s8,32(sp)
 15c:	ec66                	sd	s9,24(sp)
 15e:	e86a                	sd	s10,16(sp)
 160:	1880                	addi	s0,sp,112
 162:	8caa                	mv	s9,a0
 164:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 166:	892a                	mv	s2,a0
 168:	4481                	li	s1,0
    cc = read(0, &c, 1);
 16a:	f9f40b13          	addi	s6,s0,-97
 16e:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 170:	4ba9                	li	s7,10
 172:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 174:	8d26                	mv	s10,s1
 176:	0014899b          	addiw	s3,s1,1
 17a:	84ce                	mv	s1,s3
 17c:	0349d763          	bge	s3,s4,1aa <gets+0x64>
    cc = read(0, &c, 1);
 180:	8656                	mv	a2,s5
 182:	85da                	mv	a1,s6
 184:	4501                	li	a0,0
 186:	00000097          	auipc	ra,0x0
 18a:	1ac080e7          	jalr	428(ra) # 332 <read>
    if(cc < 1)
 18e:	00a05e63          	blez	a0,1aa <gets+0x64>
    buf[i++] = c;
 192:	f9f44783          	lbu	a5,-97(s0)
 196:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 19a:	01778763          	beq	a5,s7,1a8 <gets+0x62>
 19e:	0905                	addi	s2,s2,1
 1a0:	fd879ae3          	bne	a5,s8,174 <gets+0x2e>
    buf[i++] = c;
 1a4:	8d4e                	mv	s10,s3
 1a6:	a011                	j	1aa <gets+0x64>
 1a8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1aa:	9d66                	add	s10,s10,s9
 1ac:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1b0:	8566                	mv	a0,s9
 1b2:	70a6                	ld	ra,104(sp)
 1b4:	7406                	ld	s0,96(sp)
 1b6:	64e6                	ld	s1,88(sp)
 1b8:	6946                	ld	s2,80(sp)
 1ba:	69a6                	ld	s3,72(sp)
 1bc:	6a06                	ld	s4,64(sp)
 1be:	7ae2                	ld	s5,56(sp)
 1c0:	7b42                	ld	s6,48(sp)
 1c2:	7ba2                	ld	s7,40(sp)
 1c4:	7c02                	ld	s8,32(sp)
 1c6:	6ce2                	ld	s9,24(sp)
 1c8:	6d42                	ld	s10,16(sp)
 1ca:	6165                	addi	sp,sp,112
 1cc:	8082                	ret

00000000000001ce <stat>:

int
stat(const char *n, struct stat *st)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec06                	sd	ra,24(sp)
 1d2:	e822                	sd	s0,16(sp)
 1d4:	e04a                	sd	s2,0(sp)
 1d6:	1000                	addi	s0,sp,32
 1d8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1da:	4581                	li	a1,0
 1dc:	00000097          	auipc	ra,0x0
 1e0:	17e080e7          	jalr	382(ra) # 35a <open>
  if(fd < 0)
 1e4:	02054663          	bltz	a0,210 <stat+0x42>
 1e8:	e426                	sd	s1,8(sp)
 1ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ec:	85ca                	mv	a1,s2
 1ee:	00000097          	auipc	ra,0x0
 1f2:	184080e7          	jalr	388(ra) # 372 <fstat>
 1f6:	892a                	mv	s2,a0
  close(fd);
 1f8:	8526                	mv	a0,s1
 1fa:	00000097          	auipc	ra,0x0
 1fe:	148080e7          	jalr	328(ra) # 342 <close>
  return r;
 202:	64a2                	ld	s1,8(sp)
}
 204:	854a                	mv	a0,s2
 206:	60e2                	ld	ra,24(sp)
 208:	6442                	ld	s0,16(sp)
 20a:	6902                	ld	s2,0(sp)
 20c:	6105                	addi	sp,sp,32
 20e:	8082                	ret
    return -1;
 210:	597d                	li	s2,-1
 212:	bfcd                	j	204 <stat+0x36>

0000000000000214 <atoi>:

int
atoi(const char *s)
{
 214:	1141                	addi	sp,sp,-16
 216:	e406                	sd	ra,8(sp)
 218:	e022                	sd	s0,0(sp)
 21a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21c:	00054683          	lbu	a3,0(a0)
 220:	fd06879b          	addiw	a5,a3,-48
 224:	0ff7f793          	zext.b	a5,a5
 228:	4625                	li	a2,9
 22a:	02f66963          	bltu	a2,a5,25c <atoi+0x48>
 22e:	872a                	mv	a4,a0
  n = 0;
 230:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 232:	0705                	addi	a4,a4,1
 234:	0025179b          	slliw	a5,a0,0x2
 238:	9fa9                	addw	a5,a5,a0
 23a:	0017979b          	slliw	a5,a5,0x1
 23e:	9fb5                	addw	a5,a5,a3
 240:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 244:	00074683          	lbu	a3,0(a4)
 248:	fd06879b          	addiw	a5,a3,-48
 24c:	0ff7f793          	zext.b	a5,a5
 250:	fef671e3          	bgeu	a2,a5,232 <atoi+0x1e>
  return n;
}
 254:	60a2                	ld	ra,8(sp)
 256:	6402                	ld	s0,0(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  n = 0;
 25c:	4501                	li	a0,0
 25e:	bfdd                	j	254 <atoi+0x40>

0000000000000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e406                	sd	ra,8(sp)
 264:	e022                	sd	s0,0(sp)
 266:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 268:	02b57563          	bgeu	a0,a1,292 <memmove+0x32>
    while(n-- > 0)
 26c:	00c05f63          	blez	a2,28a <memmove+0x2a>
 270:	1602                	slli	a2,a2,0x20
 272:	9201                	srli	a2,a2,0x20
 274:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 278:	872a                	mv	a4,a0
      *dst++ = *src++;
 27a:	0585                	addi	a1,a1,1
 27c:	0705                	addi	a4,a4,1
 27e:	fff5c683          	lbu	a3,-1(a1)
 282:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28a:	60a2                	ld	ra,8(sp)
 28c:	6402                	ld	s0,0(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
    dst += n;
 292:	00c50733          	add	a4,a0,a2
    src += n;
 296:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 298:	fec059e3          	blez	a2,28a <memmove+0x2a>
 29c:	fff6079b          	addiw	a5,a2,-1
 2a0:	1782                	slli	a5,a5,0x20
 2a2:	9381                	srli	a5,a5,0x20
 2a4:	fff7c793          	not	a5,a5
 2a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2aa:	15fd                	addi	a1,a1,-1
 2ac:	177d                	addi	a4,a4,-1
 2ae:	0005c683          	lbu	a3,0(a1)
 2b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x4a>
 2ba:	bfc1                	j	28a <memmove+0x2a>

00000000000002bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e406                	sd	ra,8(sp)
 2c0:	e022                	sd	s0,0(sp)
 2c2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c4:	ca0d                	beqz	a2,2f6 <memcmp+0x3a>
 2c6:	fff6069b          	addiw	a3,a2,-1
 2ca:	1682                	slli	a3,a3,0x20
 2cc:	9281                	srli	a3,a3,0x20
 2ce:	0685                	addi	a3,a3,1
 2d0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2d2:	00054783          	lbu	a5,0(a0)
 2d6:	0005c703          	lbu	a4,0(a1)
 2da:	00e79863          	bne	a5,a4,2ea <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2de:	0505                	addi	a0,a0,1
    p2++;
 2e0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e2:	fed518e3          	bne	a0,a3,2d2 <memcmp+0x16>
  }
  return 0;
 2e6:	4501                	li	a0,0
 2e8:	a019                	j	2ee <memcmp+0x32>
      return *p1 - *p2;
 2ea:	40e7853b          	subw	a0,a5,a4
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	bfdd                	j	2ee <memcmp+0x32>

00000000000002fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e406                	sd	ra,8(sp)
 2fe:	e022                	sd	s0,0(sp)
 300:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 302:	00000097          	auipc	ra,0x0
 306:	f5e080e7          	jalr	-162(ra) # 260 <memmove>
}
 30a:	60a2                	ld	ra,8(sp)
 30c:	6402                	ld	s0,0(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 312:	4885                	li	a7,1
 ecall
 314:	00000073          	ecall
 ret
 318:	8082                	ret

000000000000031a <exit>:
.global exit
exit:
 li a7, SYS_exit
 31a:	4889                	li	a7,2
 ecall
 31c:	00000073          	ecall
 ret
 320:	8082                	ret

0000000000000322 <wait>:
.global wait
wait:
 li a7, SYS_wait
 322:	488d                	li	a7,3
 ecall
 324:	00000073          	ecall
 ret
 328:	8082                	ret

000000000000032a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 32a:	4891                	li	a7,4
 ecall
 32c:	00000073          	ecall
 ret
 330:	8082                	ret

0000000000000332 <read>:
.global read
read:
 li a7, SYS_read
 332:	4895                	li	a7,5
 ecall
 334:	00000073          	ecall
 ret
 338:	8082                	ret

000000000000033a <write>:
.global write
write:
 li a7, SYS_write
 33a:	48c1                	li	a7,16
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <close>:
.global close
close:
 li a7, SYS_close
 342:	48d5                	li	a7,21
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <kill>:
.global kill
kill:
 li a7, SYS_kill
 34a:	4899                	li	a7,6
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <exec>:
.global exec
exec:
 li a7, SYS_exec
 352:	489d                	li	a7,7
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <open>:
.global open
open:
 li a7, SYS_open
 35a:	48bd                	li	a7,15
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 362:	48c5                	li	a7,17
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 36a:	48c9                	li	a7,18
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 372:	48a1                	li	a7,8
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <link>:
.global link
link:
 li a7, SYS_link
 37a:	48cd                	li	a7,19
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 382:	48d1                	li	a7,20
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38a:	48a5                	li	a7,9
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <dup>:
.global dup
dup:
 li a7, SYS_dup
 392:	48a9                	li	a7,10
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39a:	48ad                	li	a7,11
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a2:	48b1                	li	a7,12
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3aa:	48b5                	li	a7,13
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b2:	48b9                	li	a7,14
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <trace>:
.global trace
trace:
 li a7, SYS_trace
 3ba:	48d9                	li	a7,22
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3c2:	1101                	addi	sp,sp,-32
 3c4:	ec06                	sd	ra,24(sp)
 3c6:	e822                	sd	s0,16(sp)
 3c8:	1000                	addi	s0,sp,32
 3ca:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3ce:	4605                	li	a2,1
 3d0:	fef40593          	addi	a1,s0,-17
 3d4:	00000097          	auipc	ra,0x0
 3d8:	f66080e7          	jalr	-154(ra) # 33a <write>
}
 3dc:	60e2                	ld	ra,24(sp)
 3de:	6442                	ld	s0,16(sp)
 3e0:	6105                	addi	sp,sp,32
 3e2:	8082                	ret

00000000000003e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e4:	7139                	addi	sp,sp,-64
 3e6:	fc06                	sd	ra,56(sp)
 3e8:	f822                	sd	s0,48(sp)
 3ea:	f426                	sd	s1,40(sp)
 3ec:	f04a                	sd	s2,32(sp)
 3ee:	ec4e                	sd	s3,24(sp)
 3f0:	0080                	addi	s0,sp,64
 3f2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f4:	c299                	beqz	a3,3fa <printint+0x16>
 3f6:	0805c063          	bltz	a1,476 <printint+0x92>
  neg = 0;
 3fa:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3fc:	fc040313          	addi	t1,s0,-64
  neg = 0;
 400:	869a                	mv	a3,t1
  i = 0;
 402:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 404:	00000817          	auipc	a6,0x0
 408:	4c480813          	addi	a6,a6,1220 # 8c8 <digits>
 40c:	88be                	mv	a7,a5
 40e:	0017851b          	addiw	a0,a5,1
 412:	87aa                	mv	a5,a0
 414:	02c5f73b          	remuw	a4,a1,a2
 418:	1702                	slli	a4,a4,0x20
 41a:	9301                	srli	a4,a4,0x20
 41c:	9742                	add	a4,a4,a6
 41e:	00074703          	lbu	a4,0(a4)
 422:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 426:	872e                	mv	a4,a1
 428:	02c5d5bb          	divuw	a1,a1,a2
 42c:	0685                	addi	a3,a3,1
 42e:	fcc77fe3          	bgeu	a4,a2,40c <printint+0x28>
  if(neg)
 432:	000e0c63          	beqz	t3,44a <printint+0x66>
    buf[i++] = '-';
 436:	fd050793          	addi	a5,a0,-48
 43a:	00878533          	add	a0,a5,s0
 43e:	02d00793          	li	a5,45
 442:	fef50823          	sb	a5,-16(a0)
 446:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 44a:	fff7899b          	addiw	s3,a5,-1
 44e:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 452:	fff4c583          	lbu	a1,-1(s1)
 456:	854a                	mv	a0,s2
 458:	00000097          	auipc	ra,0x0
 45c:	f6a080e7          	jalr	-150(ra) # 3c2 <putc>
  while(--i >= 0)
 460:	39fd                	addiw	s3,s3,-1
 462:	14fd                	addi	s1,s1,-1
 464:	fe09d7e3          	bgez	s3,452 <printint+0x6e>
}
 468:	70e2                	ld	ra,56(sp)
 46a:	7442                	ld	s0,48(sp)
 46c:	74a2                	ld	s1,40(sp)
 46e:	7902                	ld	s2,32(sp)
 470:	69e2                	ld	s3,24(sp)
 472:	6121                	addi	sp,sp,64
 474:	8082                	ret
    x = -xx;
 476:	40b005bb          	negw	a1,a1
    neg = 1;
 47a:	4e05                	li	t3,1
    x = -xx;
 47c:	b741                	j	3fc <printint+0x18>

000000000000047e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 47e:	715d                	addi	sp,sp,-80
 480:	e486                	sd	ra,72(sp)
 482:	e0a2                	sd	s0,64(sp)
 484:	f84a                	sd	s2,48(sp)
 486:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 488:	0005c903          	lbu	s2,0(a1)
 48c:	1a090a63          	beqz	s2,640 <vprintf+0x1c2>
 490:	fc26                	sd	s1,56(sp)
 492:	f44e                	sd	s3,40(sp)
 494:	f052                	sd	s4,32(sp)
 496:	ec56                	sd	s5,24(sp)
 498:	e85a                	sd	s6,16(sp)
 49a:	e45e                	sd	s7,8(sp)
 49c:	8aaa                	mv	s5,a0
 49e:	8bb2                	mv	s7,a2
 4a0:	00158493          	addi	s1,a1,1
  state = 0;
 4a4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4a6:	02500a13          	li	s4,37
 4aa:	4b55                	li	s6,21
 4ac:	a839                	j	4ca <vprintf+0x4c>
        putc(fd, c);
 4ae:	85ca                	mv	a1,s2
 4b0:	8556                	mv	a0,s5
 4b2:	00000097          	auipc	ra,0x0
 4b6:	f10080e7          	jalr	-240(ra) # 3c2 <putc>
 4ba:	a019                	j	4c0 <vprintf+0x42>
    } else if(state == '%'){
 4bc:	01498d63          	beq	s3,s4,4d6 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 4c0:	0485                	addi	s1,s1,1
 4c2:	fff4c903          	lbu	s2,-1(s1)
 4c6:	16090763          	beqz	s2,634 <vprintf+0x1b6>
    if(state == 0){
 4ca:	fe0999e3          	bnez	s3,4bc <vprintf+0x3e>
      if(c == '%'){
 4ce:	ff4910e3          	bne	s2,s4,4ae <vprintf+0x30>
        state = '%';
 4d2:	89d2                	mv	s3,s4
 4d4:	b7f5                	j	4c0 <vprintf+0x42>
      if(c == 'd'){
 4d6:	13490463          	beq	s2,s4,5fe <vprintf+0x180>
 4da:	f9d9079b          	addiw	a5,s2,-99
 4de:	0ff7f793          	zext.b	a5,a5
 4e2:	12fb6763          	bltu	s6,a5,610 <vprintf+0x192>
 4e6:	f9d9079b          	addiw	a5,s2,-99
 4ea:	0ff7f713          	zext.b	a4,a5
 4ee:	12eb6163          	bltu	s6,a4,610 <vprintf+0x192>
 4f2:	00271793          	slli	a5,a4,0x2
 4f6:	00000717          	auipc	a4,0x0
 4fa:	37a70713          	addi	a4,a4,890 # 870 <malloc+0x13c>
 4fe:	97ba                	add	a5,a5,a4
 500:	439c                	lw	a5,0(a5)
 502:	97ba                	add	a5,a5,a4
 504:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 506:	008b8913          	addi	s2,s7,8
 50a:	4685                	li	a3,1
 50c:	4629                	li	a2,10
 50e:	000ba583          	lw	a1,0(s7)
 512:	8556                	mv	a0,s5
 514:	00000097          	auipc	ra,0x0
 518:	ed0080e7          	jalr	-304(ra) # 3e4 <printint>
 51c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51e:	4981                	li	s3,0
 520:	b745                	j	4c0 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 522:	008b8913          	addi	s2,s7,8
 526:	4681                	li	a3,0
 528:	4629                	li	a2,10
 52a:	000ba583          	lw	a1,0(s7)
 52e:	8556                	mv	a0,s5
 530:	00000097          	auipc	ra,0x0
 534:	eb4080e7          	jalr	-332(ra) # 3e4 <printint>
 538:	8bca                	mv	s7,s2
      state = 0;
 53a:	4981                	li	s3,0
 53c:	b751                	j	4c0 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 53e:	008b8913          	addi	s2,s7,8
 542:	4681                	li	a3,0
 544:	4641                	li	a2,16
 546:	000ba583          	lw	a1,0(s7)
 54a:	8556                	mv	a0,s5
 54c:	00000097          	auipc	ra,0x0
 550:	e98080e7          	jalr	-360(ra) # 3e4 <printint>
 554:	8bca                	mv	s7,s2
      state = 0;
 556:	4981                	li	s3,0
 558:	b7a5                	j	4c0 <vprintf+0x42>
 55a:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 55c:	008b8c13          	addi	s8,s7,8
 560:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 564:	03000593          	li	a1,48
 568:	8556                	mv	a0,s5
 56a:	00000097          	auipc	ra,0x0
 56e:	e58080e7          	jalr	-424(ra) # 3c2 <putc>
  putc(fd, 'x');
 572:	07800593          	li	a1,120
 576:	8556                	mv	a0,s5
 578:	00000097          	auipc	ra,0x0
 57c:	e4a080e7          	jalr	-438(ra) # 3c2 <putc>
 580:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 582:	00000b97          	auipc	s7,0x0
 586:	346b8b93          	addi	s7,s7,838 # 8c8 <digits>
 58a:	03c9d793          	srli	a5,s3,0x3c
 58e:	97de                	add	a5,a5,s7
 590:	0007c583          	lbu	a1,0(a5)
 594:	8556                	mv	a0,s5
 596:	00000097          	auipc	ra,0x0
 59a:	e2c080e7          	jalr	-468(ra) # 3c2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 59e:	0992                	slli	s3,s3,0x4
 5a0:	397d                	addiw	s2,s2,-1
 5a2:	fe0914e3          	bnez	s2,58a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5a6:	8be2                	mv	s7,s8
      state = 0;
 5a8:	4981                	li	s3,0
 5aa:	6c02                	ld	s8,0(sp)
 5ac:	bf11                	j	4c0 <vprintf+0x42>
        s = va_arg(ap, char*);
 5ae:	008b8993          	addi	s3,s7,8
 5b2:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5b6:	02090163          	beqz	s2,5d8 <vprintf+0x15a>
        while(*s != 0){
 5ba:	00094583          	lbu	a1,0(s2)
 5be:	c9a5                	beqz	a1,62e <vprintf+0x1b0>
          putc(fd, *s);
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	e00080e7          	jalr	-512(ra) # 3c2 <putc>
          s++;
 5ca:	0905                	addi	s2,s2,1
        while(*s != 0){
 5cc:	00094583          	lbu	a1,0(s2)
 5d0:	f9e5                	bnez	a1,5c0 <vprintf+0x142>
        s = va_arg(ap, char*);
 5d2:	8bce                	mv	s7,s3
      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b5ed                	j	4c0 <vprintf+0x42>
          s = "(null)";
 5d8:	00000917          	auipc	s2,0x0
 5dc:	29090913          	addi	s2,s2,656 # 868 <malloc+0x134>
        while(*s != 0){
 5e0:	02800593          	li	a1,40
 5e4:	bff1                	j	5c0 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 5e6:	008b8913          	addi	s2,s7,8
 5ea:	000bc583          	lbu	a1,0(s7)
 5ee:	8556                	mv	a0,s5
 5f0:	00000097          	auipc	ra,0x0
 5f4:	dd2080e7          	jalr	-558(ra) # 3c2 <putc>
 5f8:	8bca                	mv	s7,s2
      state = 0;
 5fa:	4981                	li	s3,0
 5fc:	b5d1                	j	4c0 <vprintf+0x42>
        putc(fd, c);
 5fe:	02500593          	li	a1,37
 602:	8556                	mv	a0,s5
 604:	00000097          	auipc	ra,0x0
 608:	dbe080e7          	jalr	-578(ra) # 3c2 <putc>
      state = 0;
 60c:	4981                	li	s3,0
 60e:	bd4d                	j	4c0 <vprintf+0x42>
        putc(fd, '%');
 610:	02500593          	li	a1,37
 614:	8556                	mv	a0,s5
 616:	00000097          	auipc	ra,0x0
 61a:	dac080e7          	jalr	-596(ra) # 3c2 <putc>
        putc(fd, c);
 61e:	85ca                	mv	a1,s2
 620:	8556                	mv	a0,s5
 622:	00000097          	auipc	ra,0x0
 626:	da0080e7          	jalr	-608(ra) # 3c2 <putc>
      state = 0;
 62a:	4981                	li	s3,0
 62c:	bd51                	j	4c0 <vprintf+0x42>
        s = va_arg(ap, char*);
 62e:	8bce                	mv	s7,s3
      state = 0;
 630:	4981                	li	s3,0
 632:	b579                	j	4c0 <vprintf+0x42>
 634:	74e2                	ld	s1,56(sp)
 636:	79a2                	ld	s3,40(sp)
 638:	7a02                	ld	s4,32(sp)
 63a:	6ae2                	ld	s5,24(sp)
 63c:	6b42                	ld	s6,16(sp)
 63e:	6ba2                	ld	s7,8(sp)
    }
  }
}
 640:	60a6                	ld	ra,72(sp)
 642:	6406                	ld	s0,64(sp)
 644:	7942                	ld	s2,48(sp)
 646:	6161                	addi	sp,sp,80
 648:	8082                	ret

000000000000064a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 64a:	715d                	addi	sp,sp,-80
 64c:	ec06                	sd	ra,24(sp)
 64e:	e822                	sd	s0,16(sp)
 650:	1000                	addi	s0,sp,32
 652:	e010                	sd	a2,0(s0)
 654:	e414                	sd	a3,8(s0)
 656:	e818                	sd	a4,16(s0)
 658:	ec1c                	sd	a5,24(s0)
 65a:	03043023          	sd	a6,32(s0)
 65e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 662:	8622                	mv	a2,s0
 664:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 668:	00000097          	auipc	ra,0x0
 66c:	e16080e7          	jalr	-490(ra) # 47e <vprintf>
}
 670:	60e2                	ld	ra,24(sp)
 672:	6442                	ld	s0,16(sp)
 674:	6161                	addi	sp,sp,80
 676:	8082                	ret

0000000000000678 <printf>:

void
printf(const char *fmt, ...)
{
 678:	711d                	addi	sp,sp,-96
 67a:	ec06                	sd	ra,24(sp)
 67c:	e822                	sd	s0,16(sp)
 67e:	1000                	addi	s0,sp,32
 680:	e40c                	sd	a1,8(s0)
 682:	e810                	sd	a2,16(s0)
 684:	ec14                	sd	a3,24(s0)
 686:	f018                	sd	a4,32(s0)
 688:	f41c                	sd	a5,40(s0)
 68a:	03043823          	sd	a6,48(s0)
 68e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 692:	00840613          	addi	a2,s0,8
 696:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 69a:	85aa                	mv	a1,a0
 69c:	4505                	li	a0,1
 69e:	00000097          	auipc	ra,0x0
 6a2:	de0080e7          	jalr	-544(ra) # 47e <vprintf>
}
 6a6:	60e2                	ld	ra,24(sp)
 6a8:	6442                	ld	s0,16(sp)
 6aa:	6125                	addi	sp,sp,96
 6ac:	8082                	ret

00000000000006ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6ae:	1141                	addi	sp,sp,-16
 6b0:	e406                	sd	ra,8(sp)
 6b2:	e022                	sd	s0,0(sp)
 6b4:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6b6:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ba:	00000797          	auipc	a5,0x0
 6be:	60e7b783          	ld	a5,1550(a5) # cc8 <freep>
 6c2:	a02d                	j	6ec <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6c4:	4618                	lw	a4,8(a2)
 6c6:	9f2d                	addw	a4,a4,a1
 6c8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6cc:	6398                	ld	a4,0(a5)
 6ce:	6310                	ld	a2,0(a4)
 6d0:	a83d                	j	70e <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6d2:	ff852703          	lw	a4,-8(a0)
 6d6:	9f31                	addw	a4,a4,a2
 6d8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6da:	ff053683          	ld	a3,-16(a0)
 6de:	a091                	j	722 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	6398                	ld	a4,0(a5)
 6e2:	00e7e463          	bltu	a5,a4,6ea <free+0x3c>
 6e6:	00e6ea63          	bltu	a3,a4,6fa <free+0x4c>
{
 6ea:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ec:	fed7fae3          	bgeu	a5,a3,6e0 <free+0x32>
 6f0:	6398                	ld	a4,0(a5)
 6f2:	00e6e463          	bltu	a3,a4,6fa <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f6:	fee7eae3          	bltu	a5,a4,6ea <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 6fa:	ff852583          	lw	a1,-8(a0)
 6fe:	6390                	ld	a2,0(a5)
 700:	02059813          	slli	a6,a1,0x20
 704:	01c85713          	srli	a4,a6,0x1c
 708:	9736                	add	a4,a4,a3
 70a:	fae60de3          	beq	a2,a4,6c4 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 70e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 712:	4790                	lw	a2,8(a5)
 714:	02061593          	slli	a1,a2,0x20
 718:	01c5d713          	srli	a4,a1,0x1c
 71c:	973e                	add	a4,a4,a5
 71e:	fae68ae3          	beq	a3,a4,6d2 <free+0x24>
    p->s.ptr = bp->s.ptr;
 722:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 724:	00000717          	auipc	a4,0x0
 728:	5af73223          	sd	a5,1444(a4) # cc8 <freep>
}
 72c:	60a2                	ld	ra,8(sp)
 72e:	6402                	ld	s0,0(sp)
 730:	0141                	addi	sp,sp,16
 732:	8082                	ret

0000000000000734 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 734:	7139                	addi	sp,sp,-64
 736:	fc06                	sd	ra,56(sp)
 738:	f822                	sd	s0,48(sp)
 73a:	f04a                	sd	s2,32(sp)
 73c:	ec4e                	sd	s3,24(sp)
 73e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 740:	02051993          	slli	s3,a0,0x20
 744:	0209d993          	srli	s3,s3,0x20
 748:	09bd                	addi	s3,s3,15
 74a:	0049d993          	srli	s3,s3,0x4
 74e:	2985                	addiw	s3,s3,1
 750:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 752:	00000517          	auipc	a0,0x0
 756:	57653503          	ld	a0,1398(a0) # cc8 <freep>
 75a:	c905                	beqz	a0,78a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 75e:	4798                	lw	a4,8(a5)
 760:	09377a63          	bgeu	a4,s3,7f4 <malloc+0xc0>
 764:	f426                	sd	s1,40(sp)
 766:	e852                	sd	s4,16(sp)
 768:	e456                	sd	s5,8(sp)
 76a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 76c:	8a4e                	mv	s4,s3
 76e:	6705                	lui	a4,0x1
 770:	00e9f363          	bgeu	s3,a4,776 <malloc+0x42>
 774:	6a05                	lui	s4,0x1
 776:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 77a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 77e:	00000497          	auipc	s1,0x0
 782:	54a48493          	addi	s1,s1,1354 # cc8 <freep>
  if(p == (char*)-1)
 786:	5afd                	li	s5,-1
 788:	a089                	j	7ca <malloc+0x96>
 78a:	f426                	sd	s1,40(sp)
 78c:	e852                	sd	s4,16(sp)
 78e:	e456                	sd	s5,8(sp)
 790:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 792:	00000797          	auipc	a5,0x0
 796:	53e78793          	addi	a5,a5,1342 # cd0 <base>
 79a:	00000717          	auipc	a4,0x0
 79e:	52f73723          	sd	a5,1326(a4) # cc8 <freep>
 7a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7a8:	b7d1                	j	76c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 7aa:	6398                	ld	a4,0(a5)
 7ac:	e118                	sd	a4,0(a0)
 7ae:	a8b9                	j	80c <malloc+0xd8>
  hp->s.size = nu;
 7b0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7b4:	0541                	addi	a0,a0,16
 7b6:	00000097          	auipc	ra,0x0
 7ba:	ef8080e7          	jalr	-264(ra) # 6ae <free>
  return freep;
 7be:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7c0:	c135                	beqz	a0,824 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7c4:	4798                	lw	a4,8(a5)
 7c6:	03277363          	bgeu	a4,s2,7ec <malloc+0xb8>
    if(p == freep)
 7ca:	6098                	ld	a4,0(s1)
 7cc:	853e                	mv	a0,a5
 7ce:	fef71ae3          	bne	a4,a5,7c2 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7d2:	8552                	mv	a0,s4
 7d4:	00000097          	auipc	ra,0x0
 7d8:	bce080e7          	jalr	-1074(ra) # 3a2 <sbrk>
  if(p == (char*)-1)
 7dc:	fd551ae3          	bne	a0,s5,7b0 <malloc+0x7c>
        return 0;
 7e0:	4501                	li	a0,0
 7e2:	74a2                	ld	s1,40(sp)
 7e4:	6a42                	ld	s4,16(sp)
 7e6:	6aa2                	ld	s5,8(sp)
 7e8:	6b02                	ld	s6,0(sp)
 7ea:	a03d                	j	818 <malloc+0xe4>
 7ec:	74a2                	ld	s1,40(sp)
 7ee:	6a42                	ld	s4,16(sp)
 7f0:	6aa2                	ld	s5,8(sp)
 7f2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7f4:	fae90be3          	beq	s2,a4,7aa <malloc+0x76>
        p->s.size -= nunits;
 7f8:	4137073b          	subw	a4,a4,s3
 7fc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7fe:	02071693          	slli	a3,a4,0x20
 802:	01c6d713          	srli	a4,a3,0x1c
 806:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 808:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 80c:	00000717          	auipc	a4,0x0
 810:	4aa73e23          	sd	a0,1212(a4) # cc8 <freep>
      return (void*)(p + 1);
 814:	01078513          	addi	a0,a5,16
  }
}
 818:	70e2                	ld	ra,56(sp)
 81a:	7442                	ld	s0,48(sp)
 81c:	7902                	ld	s2,32(sp)
 81e:	69e2                	ld	s3,24(sp)
 820:	6121                	addi	sp,sp,64
 822:	8082                	ret
 824:	74a2                	ld	s1,40(sp)
 826:	6a42                	ld	s4,16(sp)
 828:	6aa2                	ld	s5,8(sp)
 82a:	6b02                	ld	s6,0(sp)
 82c:	b7f5                	j	818 <malloc+0xe4>
