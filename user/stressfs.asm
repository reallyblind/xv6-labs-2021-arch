
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	22913423          	sd	s1,552(sp)
  10:	23213023          	sd	s2,544(sp)
  14:	21313c23          	sd	s3,536(sp)
  18:	21413823          	sd	s4,528(sp)
  1c:	0480                	addi	s0,sp,576
  int fd, i;
  char path[] = "stressfs0";
  1e:	00001797          	auipc	a5,0x1
  22:	8e278793          	addi	a5,a5,-1822 # 900 <malloc+0x12a>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	89c50513          	addi	a0,a0,-1892 # 8d0 <malloc+0xfa>
  3c:	00000097          	auipc	ra,0x0
  40:	6de080e7          	jalr	1758(ra) # 71a <printf>
  memset(data, 'a', sizeof(data));
  44:	20000613          	li	a2,512
  48:	06100593          	li	a1,97
  4c:	dc040513          	addi	a0,s0,-576
  50:	00000097          	auipc	ra,0x0
  54:	14a080e7          	jalr	330(ra) # 19a <memset>

  for(i = 0; i < 4; i++)
  58:	4481                	li	s1,0
  5a:	4911                	li	s2,4
    if(fork() > 0)
  5c:	00000097          	auipc	ra,0x0
  60:	358080e7          	jalr	856(ra) # 3b4 <fork>
  64:	00a04563          	bgtz	a0,6e <main+0x6e>
  for(i = 0; i < 4; i++)
  68:	2485                	addiw	s1,s1,1
  6a:	ff2499e3          	bne	s1,s2,5c <main+0x5c>
      break;

  printf("write %d\n", i);
  6e:	85a6                	mv	a1,s1
  70:	00001517          	auipc	a0,0x1
  74:	87850513          	addi	a0,a0,-1928 # 8e8 <malloc+0x112>
  78:	00000097          	auipc	ra,0x0
  7c:	6a2080e7          	jalr	1698(ra) # 71a <printf>

  path[8] += i;
  80:	fc844783          	lbu	a5,-56(s0)
  84:	9fa5                	addw	a5,a5,s1
  86:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  8a:	20200593          	li	a1,514
  8e:	fc040513          	addi	a0,s0,-64
  92:	00000097          	auipc	ra,0x0
  96:	36a080e7          	jalr	874(ra) # 3fc <open>
  9a:	892a                	mv	s2,a0
  9c:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  9e:	dc040a13          	addi	s4,s0,-576
  a2:	20000993          	li	s3,512
  a6:	864e                	mv	a2,s3
  a8:	85d2                	mv	a1,s4
  aa:	854a                	mv	a0,s2
  ac:	00000097          	auipc	ra,0x0
  b0:	330080e7          	jalr	816(ra) # 3dc <write>
  for(i = 0; i < 20; i++)
  b4:	34fd                	addiw	s1,s1,-1
  b6:	f8e5                	bnez	s1,a6 <main+0xa6>
  close(fd);
  b8:	854a                	mv	a0,s2
  ba:	00000097          	auipc	ra,0x0
  be:	32a080e7          	jalr	810(ra) # 3e4 <close>

  printf("read\n");
  c2:	00001517          	auipc	a0,0x1
  c6:	83650513          	addi	a0,a0,-1994 # 8f8 <malloc+0x122>
  ca:	00000097          	auipc	ra,0x0
  ce:	650080e7          	jalr	1616(ra) # 71a <printf>

  fd = open(path, O_RDONLY);
  d2:	4581                	li	a1,0
  d4:	fc040513          	addi	a0,s0,-64
  d8:	00000097          	auipc	ra,0x0
  dc:	324080e7          	jalr	804(ra) # 3fc <open>
  e0:	892a                	mv	s2,a0
  e2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e4:	dc040a13          	addi	s4,s0,-576
  e8:	20000993          	li	s3,512
  ec:	864e                	mv	a2,s3
  ee:	85d2                	mv	a1,s4
  f0:	854a                	mv	a0,s2
  f2:	00000097          	auipc	ra,0x0
  f6:	2e2080e7          	jalr	738(ra) # 3d4 <read>
  for (i = 0; i < 20; i++)
  fa:	34fd                	addiw	s1,s1,-1
  fc:	f8e5                	bnez	s1,ec <main+0xec>
  close(fd);
  fe:	854a                	mv	a0,s2
 100:	00000097          	auipc	ra,0x0
 104:	2e4080e7          	jalr	740(ra) # 3e4 <close>

  wait(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2ba080e7          	jalr	698(ra) # 3c4 <wait>

  exit(0);
 112:	4501                	li	a0,0
 114:	00000097          	auipc	ra,0x0
 118:	2a8080e7          	jalr	680(ra) # 3bc <exit>

000000000000011c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e406                	sd	ra,8(sp)
 120:	e022                	sd	s0,0(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0xa>
    ;
  return os;
}
 134:	60a2                	ld	ra,8(sp)
 136:	6402                	ld	s0,0(sp)
 138:	0141                	addi	sp,sp,16
 13a:	8082                	ret

000000000000013c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13c:	1141                	addi	sp,sp,-16
 13e:	e406                	sd	ra,8(sp)
 140:	e022                	sd	s0,0(sp)
 142:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x20>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x20>
    p++, q++;
 152:	0505                	addi	a0,a0,1
 154:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	60a2                	ld	ra,8(sp)
 166:	6402                	ld	s0,0(sp)
 168:	0141                	addi	sp,sp,16
 16a:	8082                	ret

000000000000016c <strlen>:

uint
strlen(const char *s)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e406                	sd	ra,8(sp)
 170:	e022                	sd	s0,0(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf99                	beqz	a5,196 <strlen+0x2a>
 17a:	0505                	addi	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	86be                	mv	a3,a5
 180:	0785                	addi	a5,a5,1
 182:	fff7c703          	lbu	a4,-1(a5)
 186:	ff65                	bnez	a4,17e <strlen+0x12>
 188:	40a6853b          	subw	a0,a3,a0
 18c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 18e:	60a2                	ld	ra,8(sp)
 190:	6402                	ld	s0,0(sp)
 192:	0141                	addi	sp,sp,16
 194:	8082                	ret
  for(n = 0; s[n]; n++)
 196:	4501                	li	a0,0
 198:	bfdd                	j	18e <strlen+0x22>

000000000000019a <memset>:

void*
memset(void *dst, int c, uint n)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e406                	sd	ra,8(sp)
 19e:	e022                	sd	s0,0(sp)
 1a0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a2:	ca19                	beqz	a2,1b8 <memset+0x1e>
 1a4:	87aa                	mv	a5,a0
 1a6:	1602                	slli	a2,a2,0x20
 1a8:	9201                	srli	a2,a2,0x20
 1aa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ae:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1b2:	0785                	addi	a5,a5,1
 1b4:	fee79de3          	bne	a5,a4,1ae <memset+0x14>
  }
  return dst;
}
 1b8:	60a2                	ld	ra,8(sp)
 1ba:	6402                	ld	s0,0(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e406                	sd	ra,8(sp)
 1c4:	e022                	sd	s0,0(sp)
 1c6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	cf81                	beqz	a5,1e4 <strchr+0x24>
    if(*s == c)
 1ce:	00f58763          	beq	a1,a5,1dc <strchr+0x1c>
  for(; *s; s++)
 1d2:	0505                	addi	a0,a0,1
 1d4:	00054783          	lbu	a5,0(a0)
 1d8:	fbfd                	bnez	a5,1ce <strchr+0xe>
      return (char*)s;
  return 0;
 1da:	4501                	li	a0,0
}
 1dc:	60a2                	ld	ra,8(sp)
 1de:	6402                	ld	s0,0(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
  return 0;
 1e4:	4501                	li	a0,0
 1e6:	bfdd                	j	1dc <strchr+0x1c>

00000000000001e8 <gets>:

char*
gets(char *buf, int max)
{
 1e8:	7159                	addi	sp,sp,-112
 1ea:	f486                	sd	ra,104(sp)
 1ec:	f0a2                	sd	s0,96(sp)
 1ee:	eca6                	sd	s1,88(sp)
 1f0:	e8ca                	sd	s2,80(sp)
 1f2:	e4ce                	sd	s3,72(sp)
 1f4:	e0d2                	sd	s4,64(sp)
 1f6:	fc56                	sd	s5,56(sp)
 1f8:	f85a                	sd	s6,48(sp)
 1fa:	f45e                	sd	s7,40(sp)
 1fc:	f062                	sd	s8,32(sp)
 1fe:	ec66                	sd	s9,24(sp)
 200:	e86a                	sd	s10,16(sp)
 202:	1880                	addi	s0,sp,112
 204:	8caa                	mv	s9,a0
 206:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 208:	892a                	mv	s2,a0
 20a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 20c:	f9f40b13          	addi	s6,s0,-97
 210:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 212:	4ba9                	li	s7,10
 214:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 216:	8d26                	mv	s10,s1
 218:	0014899b          	addiw	s3,s1,1
 21c:	84ce                	mv	s1,s3
 21e:	0349d763          	bge	s3,s4,24c <gets+0x64>
    cc = read(0, &c, 1);
 222:	8656                	mv	a2,s5
 224:	85da                	mv	a1,s6
 226:	4501                	li	a0,0
 228:	00000097          	auipc	ra,0x0
 22c:	1ac080e7          	jalr	428(ra) # 3d4 <read>
    if(cc < 1)
 230:	00a05e63          	blez	a0,24c <gets+0x64>
    buf[i++] = c;
 234:	f9f44783          	lbu	a5,-97(s0)
 238:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 23c:	01778763          	beq	a5,s7,24a <gets+0x62>
 240:	0905                	addi	s2,s2,1
 242:	fd879ae3          	bne	a5,s8,216 <gets+0x2e>
    buf[i++] = c;
 246:	8d4e                	mv	s10,s3
 248:	a011                	j	24c <gets+0x64>
 24a:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 24c:	9d66                	add	s10,s10,s9
 24e:	000d0023          	sb	zero,0(s10)
  return buf;
}
 252:	8566                	mv	a0,s9
 254:	70a6                	ld	ra,104(sp)
 256:	7406                	ld	s0,96(sp)
 258:	64e6                	ld	s1,88(sp)
 25a:	6946                	ld	s2,80(sp)
 25c:	69a6                	ld	s3,72(sp)
 25e:	6a06                	ld	s4,64(sp)
 260:	7ae2                	ld	s5,56(sp)
 262:	7b42                	ld	s6,48(sp)
 264:	7ba2                	ld	s7,40(sp)
 266:	7c02                	ld	s8,32(sp)
 268:	6ce2                	ld	s9,24(sp)
 26a:	6d42                	ld	s10,16(sp)
 26c:	6165                	addi	sp,sp,112
 26e:	8082                	ret

0000000000000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	1101                	addi	sp,sp,-32
 272:	ec06                	sd	ra,24(sp)
 274:	e822                	sd	s0,16(sp)
 276:	e04a                	sd	s2,0(sp)
 278:	1000                	addi	s0,sp,32
 27a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27c:	4581                	li	a1,0
 27e:	00000097          	auipc	ra,0x0
 282:	17e080e7          	jalr	382(ra) # 3fc <open>
  if(fd < 0)
 286:	02054663          	bltz	a0,2b2 <stat+0x42>
 28a:	e426                	sd	s1,8(sp)
 28c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 28e:	85ca                	mv	a1,s2
 290:	00000097          	auipc	ra,0x0
 294:	184080e7          	jalr	388(ra) # 414 <fstat>
 298:	892a                	mv	s2,a0
  close(fd);
 29a:	8526                	mv	a0,s1
 29c:	00000097          	auipc	ra,0x0
 2a0:	148080e7          	jalr	328(ra) # 3e4 <close>
  return r;
 2a4:	64a2                	ld	s1,8(sp)
}
 2a6:	854a                	mv	a0,s2
 2a8:	60e2                	ld	ra,24(sp)
 2aa:	6442                	ld	s0,16(sp)
 2ac:	6902                	ld	s2,0(sp)
 2ae:	6105                	addi	sp,sp,32
 2b0:	8082                	ret
    return -1;
 2b2:	597d                	li	s2,-1
 2b4:	bfcd                	j	2a6 <stat+0x36>

00000000000002b6 <atoi>:

int
atoi(const char *s)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2be:	00054683          	lbu	a3,0(a0)
 2c2:	fd06879b          	addiw	a5,a3,-48
 2c6:	0ff7f793          	zext.b	a5,a5
 2ca:	4625                	li	a2,9
 2cc:	02f66963          	bltu	a2,a5,2fe <atoi+0x48>
 2d0:	872a                	mv	a4,a0
  n = 0;
 2d2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d4:	0705                	addi	a4,a4,1
 2d6:	0025179b          	slliw	a5,a0,0x2
 2da:	9fa9                	addw	a5,a5,a0
 2dc:	0017979b          	slliw	a5,a5,0x1
 2e0:	9fb5                	addw	a5,a5,a3
 2e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e6:	00074683          	lbu	a3,0(a4)
 2ea:	fd06879b          	addiw	a5,a3,-48
 2ee:	0ff7f793          	zext.b	a5,a5
 2f2:	fef671e3          	bgeu	a2,a5,2d4 <atoi+0x1e>
  return n;
}
 2f6:	60a2                	ld	ra,8(sp)
 2f8:	6402                	ld	s0,0(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
  n = 0;
 2fe:	4501                	li	a0,0
 300:	bfdd                	j	2f6 <atoi+0x40>

0000000000000302 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 30a:	02b57563          	bgeu	a0,a1,334 <memmove+0x32>
    while(n-- > 0)
 30e:	00c05f63          	blez	a2,32c <memmove+0x2a>
 312:	1602                	slli	a2,a2,0x20
 314:	9201                	srli	a2,a2,0x20
 316:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 31a:	872a                	mv	a4,a0
      *dst++ = *src++;
 31c:	0585                	addi	a1,a1,1
 31e:	0705                	addi	a4,a4,1
 320:	fff5c683          	lbu	a3,-1(a1)
 324:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 328:	fee79ae3          	bne	a5,a4,31c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
    dst += n;
 334:	00c50733          	add	a4,a0,a2
    src += n;
 338:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 33a:	fec059e3          	blez	a2,32c <memmove+0x2a>
 33e:	fff6079b          	addiw	a5,a2,-1
 342:	1782                	slli	a5,a5,0x20
 344:	9381                	srli	a5,a5,0x20
 346:	fff7c793          	not	a5,a5
 34a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34c:	15fd                	addi	a1,a1,-1
 34e:	177d                	addi	a4,a4,-1
 350:	0005c683          	lbu	a3,0(a1)
 354:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 358:	fef71ae3          	bne	a4,a5,34c <memmove+0x4a>
 35c:	bfc1                	j	32c <memmove+0x2a>

000000000000035e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 366:	ca0d                	beqz	a2,398 <memcmp+0x3a>
 368:	fff6069b          	addiw	a3,a2,-1
 36c:	1682                	slli	a3,a3,0x20
 36e:	9281                	srli	a3,a3,0x20
 370:	0685                	addi	a3,a3,1
 372:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 374:	00054783          	lbu	a5,0(a0)
 378:	0005c703          	lbu	a4,0(a1)
 37c:	00e79863          	bne	a5,a4,38c <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 380:	0505                	addi	a0,a0,1
    p2++;
 382:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 384:	fed518e3          	bne	a0,a3,374 <memcmp+0x16>
  }
  return 0;
 388:	4501                	li	a0,0
 38a:	a019                	j	390 <memcmp+0x32>
      return *p1 - *p2;
 38c:	40e7853b          	subw	a0,a5,a4
}
 390:	60a2                	ld	ra,8(sp)
 392:	6402                	ld	s0,0(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret
  return 0;
 398:	4501                	li	a0,0
 39a:	bfdd                	j	390 <memcmp+0x32>

000000000000039c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3a4:	00000097          	auipc	ra,0x0
 3a8:	f5e080e7          	jalr	-162(ra) # 302 <memmove>
}
 3ac:	60a2                	ld	ra,8(sp)
 3ae:	6402                	ld	s0,0(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret

00000000000003b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b4:	4885                	li	a7,1
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3bc:	4889                	li	a7,2
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c4:	488d                	li	a7,3
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3cc:	4891                	li	a7,4
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <read>:
.global read
read:
 li a7, SYS_read
 3d4:	4895                	li	a7,5
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <write>:
.global write
write:
 li a7, SYS_write
 3dc:	48c1                	li	a7,16
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <close>:
.global close
close:
 li a7, SYS_close
 3e4:	48d5                	li	a7,21
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ec:	4899                	li	a7,6
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f4:	489d                	li	a7,7
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <open>:
.global open
open:
 li a7, SYS_open
 3fc:	48bd                	li	a7,15
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 404:	48c5                	li	a7,17
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 40c:	48c9                	li	a7,18
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 414:	48a1                	li	a7,8
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <link>:
.global link
link:
 li a7, SYS_link
 41c:	48cd                	li	a7,19
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 424:	48d1                	li	a7,20
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 42c:	48a5                	li	a7,9
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <dup>:
.global dup
dup:
 li a7, SYS_dup
 434:	48a9                	li	a7,10
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 43c:	48ad                	li	a7,11
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 444:	48b1                	li	a7,12
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 44c:	48b5                	li	a7,13
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 454:	48b9                	li	a7,14
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <trace>:
.global trace
trace:
 li a7, SYS_trace
 45c:	48d9                	li	a7,22
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 464:	1101                	addi	sp,sp,-32
 466:	ec06                	sd	ra,24(sp)
 468:	e822                	sd	s0,16(sp)
 46a:	1000                	addi	s0,sp,32
 46c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 470:	4605                	li	a2,1
 472:	fef40593          	addi	a1,s0,-17
 476:	00000097          	auipc	ra,0x0
 47a:	f66080e7          	jalr	-154(ra) # 3dc <write>
}
 47e:	60e2                	ld	ra,24(sp)
 480:	6442                	ld	s0,16(sp)
 482:	6105                	addi	sp,sp,32
 484:	8082                	ret

0000000000000486 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 486:	7139                	addi	sp,sp,-64
 488:	fc06                	sd	ra,56(sp)
 48a:	f822                	sd	s0,48(sp)
 48c:	f426                	sd	s1,40(sp)
 48e:	f04a                	sd	s2,32(sp)
 490:	ec4e                	sd	s3,24(sp)
 492:	0080                	addi	s0,sp,64
 494:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 496:	c299                	beqz	a3,49c <printint+0x16>
 498:	0805c063          	bltz	a1,518 <printint+0x92>
  neg = 0;
 49c:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 49e:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4a2:	869a                	mv	a3,t1
  i = 0;
 4a4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4a6:	00000817          	auipc	a6,0x0
 4aa:	4ca80813          	addi	a6,a6,1226 # 970 <digits>
 4ae:	88be                	mv	a7,a5
 4b0:	0017851b          	addiw	a0,a5,1
 4b4:	87aa                	mv	a5,a0
 4b6:	02c5f73b          	remuw	a4,a1,a2
 4ba:	1702                	slli	a4,a4,0x20
 4bc:	9301                	srli	a4,a4,0x20
 4be:	9742                	add	a4,a4,a6
 4c0:	00074703          	lbu	a4,0(a4)
 4c4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4c8:	872e                	mv	a4,a1
 4ca:	02c5d5bb          	divuw	a1,a1,a2
 4ce:	0685                	addi	a3,a3,1
 4d0:	fcc77fe3          	bgeu	a4,a2,4ae <printint+0x28>
  if(neg)
 4d4:	000e0c63          	beqz	t3,4ec <printint+0x66>
    buf[i++] = '-';
 4d8:	fd050793          	addi	a5,a0,-48
 4dc:	00878533          	add	a0,a5,s0
 4e0:	02d00793          	li	a5,45
 4e4:	fef50823          	sb	a5,-16(a0)
 4e8:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4ec:	fff7899b          	addiw	s3,a5,-1
 4f0:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4f4:	fff4c583          	lbu	a1,-1(s1)
 4f8:	854a                	mv	a0,s2
 4fa:	00000097          	auipc	ra,0x0
 4fe:	f6a080e7          	jalr	-150(ra) # 464 <putc>
  while(--i >= 0)
 502:	39fd                	addiw	s3,s3,-1
 504:	14fd                	addi	s1,s1,-1
 506:	fe09d7e3          	bgez	s3,4f4 <printint+0x6e>
}
 50a:	70e2                	ld	ra,56(sp)
 50c:	7442                	ld	s0,48(sp)
 50e:	74a2                	ld	s1,40(sp)
 510:	7902                	ld	s2,32(sp)
 512:	69e2                	ld	s3,24(sp)
 514:	6121                	addi	sp,sp,64
 516:	8082                	ret
    x = -xx;
 518:	40b005bb          	negw	a1,a1
    neg = 1;
 51c:	4e05                	li	t3,1
    x = -xx;
 51e:	b741                	j	49e <printint+0x18>

0000000000000520 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 520:	715d                	addi	sp,sp,-80
 522:	e486                	sd	ra,72(sp)
 524:	e0a2                	sd	s0,64(sp)
 526:	f84a                	sd	s2,48(sp)
 528:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 52a:	0005c903          	lbu	s2,0(a1)
 52e:	1a090a63          	beqz	s2,6e2 <vprintf+0x1c2>
 532:	fc26                	sd	s1,56(sp)
 534:	f44e                	sd	s3,40(sp)
 536:	f052                	sd	s4,32(sp)
 538:	ec56                	sd	s5,24(sp)
 53a:	e85a                	sd	s6,16(sp)
 53c:	e45e                	sd	s7,8(sp)
 53e:	8aaa                	mv	s5,a0
 540:	8bb2                	mv	s7,a2
 542:	00158493          	addi	s1,a1,1
  state = 0;
 546:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 548:	02500a13          	li	s4,37
 54c:	4b55                	li	s6,21
 54e:	a839                	j	56c <vprintf+0x4c>
        putc(fd, c);
 550:	85ca                	mv	a1,s2
 552:	8556                	mv	a0,s5
 554:	00000097          	auipc	ra,0x0
 558:	f10080e7          	jalr	-240(ra) # 464 <putc>
 55c:	a019                	j	562 <vprintf+0x42>
    } else if(state == '%'){
 55e:	01498d63          	beq	s3,s4,578 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 562:	0485                	addi	s1,s1,1
 564:	fff4c903          	lbu	s2,-1(s1)
 568:	16090763          	beqz	s2,6d6 <vprintf+0x1b6>
    if(state == 0){
 56c:	fe0999e3          	bnez	s3,55e <vprintf+0x3e>
      if(c == '%'){
 570:	ff4910e3          	bne	s2,s4,550 <vprintf+0x30>
        state = '%';
 574:	89d2                	mv	s3,s4
 576:	b7f5                	j	562 <vprintf+0x42>
      if(c == 'd'){
 578:	13490463          	beq	s2,s4,6a0 <vprintf+0x180>
 57c:	f9d9079b          	addiw	a5,s2,-99
 580:	0ff7f793          	zext.b	a5,a5
 584:	12fb6763          	bltu	s6,a5,6b2 <vprintf+0x192>
 588:	f9d9079b          	addiw	a5,s2,-99
 58c:	0ff7f713          	zext.b	a4,a5
 590:	12eb6163          	bltu	s6,a4,6b2 <vprintf+0x192>
 594:	00271793          	slli	a5,a4,0x2
 598:	00000717          	auipc	a4,0x0
 59c:	38070713          	addi	a4,a4,896 # 918 <malloc+0x142>
 5a0:	97ba                	add	a5,a5,a4
 5a2:	439c                	lw	a5,0(a5)
 5a4:	97ba                	add	a5,a5,a4
 5a6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5a8:	008b8913          	addi	s2,s7,8
 5ac:	4685                	li	a3,1
 5ae:	4629                	li	a2,10
 5b0:	000ba583          	lw	a1,0(s7)
 5b4:	8556                	mv	a0,s5
 5b6:	00000097          	auipc	ra,0x0
 5ba:	ed0080e7          	jalr	-304(ra) # 486 <printint>
 5be:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5c0:	4981                	li	s3,0
 5c2:	b745                	j	562 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5c4:	008b8913          	addi	s2,s7,8
 5c8:	4681                	li	a3,0
 5ca:	4629                	li	a2,10
 5cc:	000ba583          	lw	a1,0(s7)
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	eb4080e7          	jalr	-332(ra) # 486 <printint>
 5da:	8bca                	mv	s7,s2
      state = 0;
 5dc:	4981                	li	s3,0
 5de:	b751                	j	562 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5e0:	008b8913          	addi	s2,s7,8
 5e4:	4681                	li	a3,0
 5e6:	4641                	li	a2,16
 5e8:	000ba583          	lw	a1,0(s7)
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	e98080e7          	jalr	-360(ra) # 486 <printint>
 5f6:	8bca                	mv	s7,s2
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	b7a5                	j	562 <vprintf+0x42>
 5fc:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5fe:	008b8c13          	addi	s8,s7,8
 602:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 606:	03000593          	li	a1,48
 60a:	8556                	mv	a0,s5
 60c:	00000097          	auipc	ra,0x0
 610:	e58080e7          	jalr	-424(ra) # 464 <putc>
  putc(fd, 'x');
 614:	07800593          	li	a1,120
 618:	8556                	mv	a0,s5
 61a:	00000097          	auipc	ra,0x0
 61e:	e4a080e7          	jalr	-438(ra) # 464 <putc>
 622:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 624:	00000b97          	auipc	s7,0x0
 628:	34cb8b93          	addi	s7,s7,844 # 970 <digits>
 62c:	03c9d793          	srli	a5,s3,0x3c
 630:	97de                	add	a5,a5,s7
 632:	0007c583          	lbu	a1,0(a5)
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	e2c080e7          	jalr	-468(ra) # 464 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 640:	0992                	slli	s3,s3,0x4
 642:	397d                	addiw	s2,s2,-1
 644:	fe0914e3          	bnez	s2,62c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 648:	8be2                	mv	s7,s8
      state = 0;
 64a:	4981                	li	s3,0
 64c:	6c02                	ld	s8,0(sp)
 64e:	bf11                	j	562 <vprintf+0x42>
        s = va_arg(ap, char*);
 650:	008b8993          	addi	s3,s7,8
 654:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 658:	02090163          	beqz	s2,67a <vprintf+0x15a>
        while(*s != 0){
 65c:	00094583          	lbu	a1,0(s2)
 660:	c9a5                	beqz	a1,6d0 <vprintf+0x1b0>
          putc(fd, *s);
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e00080e7          	jalr	-512(ra) # 464 <putc>
          s++;
 66c:	0905                	addi	s2,s2,1
        while(*s != 0){
 66e:	00094583          	lbu	a1,0(s2)
 672:	f9e5                	bnez	a1,662 <vprintf+0x142>
        s = va_arg(ap, char*);
 674:	8bce                	mv	s7,s3
      state = 0;
 676:	4981                	li	s3,0
 678:	b5ed                	j	562 <vprintf+0x42>
          s = "(null)";
 67a:	00000917          	auipc	s2,0x0
 67e:	29690913          	addi	s2,s2,662 # 910 <malloc+0x13a>
        while(*s != 0){
 682:	02800593          	li	a1,40
 686:	bff1                	j	662 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 688:	008b8913          	addi	s2,s7,8
 68c:	000bc583          	lbu	a1,0(s7)
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	dd2080e7          	jalr	-558(ra) # 464 <putc>
 69a:	8bca                	mv	s7,s2
      state = 0;
 69c:	4981                	li	s3,0
 69e:	b5d1                	j	562 <vprintf+0x42>
        putc(fd, c);
 6a0:	02500593          	li	a1,37
 6a4:	8556                	mv	a0,s5
 6a6:	00000097          	auipc	ra,0x0
 6aa:	dbe080e7          	jalr	-578(ra) # 464 <putc>
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	bd4d                	j	562 <vprintf+0x42>
        putc(fd, '%');
 6b2:	02500593          	li	a1,37
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	dac080e7          	jalr	-596(ra) # 464 <putc>
        putc(fd, c);
 6c0:	85ca                	mv	a1,s2
 6c2:	8556                	mv	a0,s5
 6c4:	00000097          	auipc	ra,0x0
 6c8:	da0080e7          	jalr	-608(ra) # 464 <putc>
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	bd51                	j	562 <vprintf+0x42>
        s = va_arg(ap, char*);
 6d0:	8bce                	mv	s7,s3
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	b579                	j	562 <vprintf+0x42>
 6d6:	74e2                	ld	s1,56(sp)
 6d8:	79a2                	ld	s3,40(sp)
 6da:	7a02                	ld	s4,32(sp)
 6dc:	6ae2                	ld	s5,24(sp)
 6de:	6b42                	ld	s6,16(sp)
 6e0:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6e2:	60a6                	ld	ra,72(sp)
 6e4:	6406                	ld	s0,64(sp)
 6e6:	7942                	ld	s2,48(sp)
 6e8:	6161                	addi	sp,sp,80
 6ea:	8082                	ret

00000000000006ec <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ec:	715d                	addi	sp,sp,-80
 6ee:	ec06                	sd	ra,24(sp)
 6f0:	e822                	sd	s0,16(sp)
 6f2:	1000                	addi	s0,sp,32
 6f4:	e010                	sd	a2,0(s0)
 6f6:	e414                	sd	a3,8(s0)
 6f8:	e818                	sd	a4,16(s0)
 6fa:	ec1c                	sd	a5,24(s0)
 6fc:	03043023          	sd	a6,32(s0)
 700:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 704:	8622                	mv	a2,s0
 706:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 70a:	00000097          	auipc	ra,0x0
 70e:	e16080e7          	jalr	-490(ra) # 520 <vprintf>
}
 712:	60e2                	ld	ra,24(sp)
 714:	6442                	ld	s0,16(sp)
 716:	6161                	addi	sp,sp,80
 718:	8082                	ret

000000000000071a <printf>:

void
printf(const char *fmt, ...)
{
 71a:	711d                	addi	sp,sp,-96
 71c:	ec06                	sd	ra,24(sp)
 71e:	e822                	sd	s0,16(sp)
 720:	1000                	addi	s0,sp,32
 722:	e40c                	sd	a1,8(s0)
 724:	e810                	sd	a2,16(s0)
 726:	ec14                	sd	a3,24(s0)
 728:	f018                	sd	a4,32(s0)
 72a:	f41c                	sd	a5,40(s0)
 72c:	03043823          	sd	a6,48(s0)
 730:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 734:	00840613          	addi	a2,s0,8
 738:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 73c:	85aa                	mv	a1,a0
 73e:	4505                	li	a0,1
 740:	00000097          	auipc	ra,0x0
 744:	de0080e7          	jalr	-544(ra) # 520 <vprintf>
}
 748:	60e2                	ld	ra,24(sp)
 74a:	6442                	ld	s0,16(sp)
 74c:	6125                	addi	sp,sp,96
 74e:	8082                	ret

0000000000000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	1141                	addi	sp,sp,-16
 752:	e406                	sd	ra,8(sp)
 754:	e022                	sd	s0,0(sp)
 756:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 758:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75c:	00000797          	auipc	a5,0x0
 760:	6147b783          	ld	a5,1556(a5) # d70 <freep>
 764:	a02d                	j	78e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 766:	4618                	lw	a4,8(a2)
 768:	9f2d                	addw	a4,a4,a1
 76a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 76e:	6398                	ld	a4,0(a5)
 770:	6310                	ld	a2,0(a4)
 772:	a83d                	j	7b0 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 774:	ff852703          	lw	a4,-8(a0)
 778:	9f31                	addw	a4,a4,a2
 77a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 77c:	ff053683          	ld	a3,-16(a0)
 780:	a091                	j	7c4 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	6398                	ld	a4,0(a5)
 784:	00e7e463          	bltu	a5,a4,78c <free+0x3c>
 788:	00e6ea63          	bltu	a3,a4,79c <free+0x4c>
{
 78c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78e:	fed7fae3          	bgeu	a5,a3,782 <free+0x32>
 792:	6398                	ld	a4,0(a5)
 794:	00e6e463          	bltu	a3,a4,79c <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 798:	fee7eae3          	bltu	a5,a4,78c <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 79c:	ff852583          	lw	a1,-8(a0)
 7a0:	6390                	ld	a2,0(a5)
 7a2:	02059813          	slli	a6,a1,0x20
 7a6:	01c85713          	srli	a4,a6,0x1c
 7aa:	9736                	add	a4,a4,a3
 7ac:	fae60de3          	beq	a2,a4,766 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7b0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b4:	4790                	lw	a2,8(a5)
 7b6:	02061593          	slli	a1,a2,0x20
 7ba:	01c5d713          	srli	a4,a1,0x1c
 7be:	973e                	add	a4,a4,a5
 7c0:	fae68ae3          	beq	a3,a4,774 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7c4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c6:	00000717          	auipc	a4,0x0
 7ca:	5af73523          	sd	a5,1450(a4) # d70 <freep>
}
 7ce:	60a2                	ld	ra,8(sp)
 7d0:	6402                	ld	s0,0(sp)
 7d2:	0141                	addi	sp,sp,16
 7d4:	8082                	ret

00000000000007d6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d6:	7139                	addi	sp,sp,-64
 7d8:	fc06                	sd	ra,56(sp)
 7da:	f822                	sd	s0,48(sp)
 7dc:	f04a                	sd	s2,32(sp)
 7de:	ec4e                	sd	s3,24(sp)
 7e0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	02051993          	slli	s3,a0,0x20
 7e6:	0209d993          	srli	s3,s3,0x20
 7ea:	09bd                	addi	s3,s3,15
 7ec:	0049d993          	srli	s3,s3,0x4
 7f0:	2985                	addiw	s3,s3,1
 7f2:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7f4:	00000517          	auipc	a0,0x0
 7f8:	57c53503          	ld	a0,1404(a0) # d70 <freep>
 7fc:	c905                	beqz	a0,82c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fe:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 800:	4798                	lw	a4,8(a5)
 802:	09377a63          	bgeu	a4,s3,896 <malloc+0xc0>
 806:	f426                	sd	s1,40(sp)
 808:	e852                	sd	s4,16(sp)
 80a:	e456                	sd	s5,8(sp)
 80c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 80e:	8a4e                	mv	s4,s3
 810:	6705                	lui	a4,0x1
 812:	00e9f363          	bgeu	s3,a4,818 <malloc+0x42>
 816:	6a05                	lui	s4,0x1
 818:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 81c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 820:	00000497          	auipc	s1,0x0
 824:	55048493          	addi	s1,s1,1360 # d70 <freep>
  if(p == (char*)-1)
 828:	5afd                	li	s5,-1
 82a:	a089                	j	86c <malloc+0x96>
 82c:	f426                	sd	s1,40(sp)
 82e:	e852                	sd	s4,16(sp)
 830:	e456                	sd	s5,8(sp)
 832:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 834:	00000797          	auipc	a5,0x0
 838:	54478793          	addi	a5,a5,1348 # d78 <base>
 83c:	00000717          	auipc	a4,0x0
 840:	52f73a23          	sd	a5,1332(a4) # d70 <freep>
 844:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 846:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 84a:	b7d1                	j	80e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 84c:	6398                	ld	a4,0(a5)
 84e:	e118                	sd	a4,0(a0)
 850:	a8b9                	j	8ae <malloc+0xd8>
  hp->s.size = nu;
 852:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 856:	0541                	addi	a0,a0,16
 858:	00000097          	auipc	ra,0x0
 85c:	ef8080e7          	jalr	-264(ra) # 750 <free>
  return freep;
 860:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 862:	c135                	beqz	a0,8c6 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 864:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 866:	4798                	lw	a4,8(a5)
 868:	03277363          	bgeu	a4,s2,88e <malloc+0xb8>
    if(p == freep)
 86c:	6098                	ld	a4,0(s1)
 86e:	853e                	mv	a0,a5
 870:	fef71ae3          	bne	a4,a5,864 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 874:	8552                	mv	a0,s4
 876:	00000097          	auipc	ra,0x0
 87a:	bce080e7          	jalr	-1074(ra) # 444 <sbrk>
  if(p == (char*)-1)
 87e:	fd551ae3          	bne	a0,s5,852 <malloc+0x7c>
        return 0;
 882:	4501                	li	a0,0
 884:	74a2                	ld	s1,40(sp)
 886:	6a42                	ld	s4,16(sp)
 888:	6aa2                	ld	s5,8(sp)
 88a:	6b02                	ld	s6,0(sp)
 88c:	a03d                	j	8ba <malloc+0xe4>
 88e:	74a2                	ld	s1,40(sp)
 890:	6a42                	ld	s4,16(sp)
 892:	6aa2                	ld	s5,8(sp)
 894:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 896:	fae90be3          	beq	s2,a4,84c <malloc+0x76>
        p->s.size -= nunits;
 89a:	4137073b          	subw	a4,a4,s3
 89e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a0:	02071693          	slli	a3,a4,0x20
 8a4:	01c6d713          	srli	a4,a3,0x1c
 8a8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8aa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ae:	00000717          	auipc	a4,0x0
 8b2:	4ca73123          	sd	a0,1218(a4) # d70 <freep>
      return (void*)(p + 1);
 8b6:	01078513          	addi	a0,a5,16
  }
}
 8ba:	70e2                	ld	ra,56(sp)
 8bc:	7442                	ld	s0,48(sp)
 8be:	7902                	ld	s2,32(sp)
 8c0:	69e2                	ld	s3,24(sp)
 8c2:	6121                	addi	sp,sp,64
 8c4:	8082                	ret
 8c6:	74a2                	ld	s1,40(sp)
 8c8:	6a42                	ld	s4,16(sp)
 8ca:	6aa2                	ld	s5,8(sp)
 8cc:	6b02                	ld	s6,0(sp)
 8ce:	b7f5                	j	8ba <malloc+0xe4>
