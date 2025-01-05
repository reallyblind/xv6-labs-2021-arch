
user/_trace:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	712d                	addi	sp,sp,-288
   2:	ee06                	sd	ra,280(sp)
   4:	ea22                	sd	s0,272(sp)
   6:	e626                	sd	s1,264(sp)
   8:	e24a                	sd	s2,256(sp)
   a:	1200                	addi	s0,sp,288
   c:	892e                	mv	s2,a1
  int i;
  char *nargv[MAXARG];

  if(argc < 3 || (argv[1][0] < '0' || argv[1][0] > '9')){
   e:	4789                	li	a5,2
  10:	00a7dd63          	bge	a5,a0,2a <main+0x2a>
  14:	84aa                	mv	s1,a0
  16:	6588                	ld	a0,8(a1)
  18:	00054783          	lbu	a5,0(a0)
  1c:	fd07879b          	addiw	a5,a5,-48
  20:	0ff7f793          	zext.b	a5,a5
  24:	4725                	li	a4,9
  26:	02f77263          	bgeu	a4,a5,4a <main+0x4a>
    fprintf(2, "Usage: %s mask command\n", argv[0]);
  2a:	00093603          	ld	a2,0(s2)
  2e:	00001597          	auipc	a1,0x1
  32:	84a58593          	addi	a1,a1,-1974 # 878 <malloc+0xfe>
  36:	4509                	li	a0,2
  38:	00000097          	auipc	ra,0x0
  3c:	658080e7          	jalr	1624(ra) # 690 <fprintf>
    exit(1);
  40:	4505                	li	a0,1
  42:	00000097          	auipc	ra,0x0
  46:	31e080e7          	jalr	798(ra) # 360 <exit>
  }

  if (trace(atoi(argv[1])) < 0) {
  4a:	00000097          	auipc	ra,0x0
  4e:	210080e7          	jalr	528(ra) # 25a <atoi>
  52:	00000097          	auipc	ra,0x0
  56:	3ae080e7          	jalr	942(ra) # 400 <trace>
  5a:	04054363          	bltz	a0,a0 <main+0xa0>
  5e:	01090793          	addi	a5,s2,16
  62:	ee040713          	addi	a4,s0,-288
  66:	34f5                	addiw	s1,s1,-3
  68:	02049693          	slli	a3,s1,0x20
  6c:	01d6d493          	srli	s1,a3,0x1d
  70:	94be                	add	s1,s1,a5
  72:	10090593          	addi	a1,s2,256
    fprintf(2, "%s: trace failed\n", argv[0]);
    exit(1);
  }
  
  for(i = 2; i < argc && i < MAXARG; i++){
    nargv[i-2] = argv[i];
  76:	6394                	ld	a3,0(a5)
  78:	e314                	sd	a3,0(a4)
  for(i = 2; i < argc && i < MAXARG; i++){
  7a:	00978663          	beq	a5,s1,86 <main+0x86>
  7e:	07a1                	addi	a5,a5,8
  80:	0721                	addi	a4,a4,8
  82:	feb79ae3          	bne	a5,a1,76 <main+0x76>
  }
  exec(nargv[0], nargv);
  86:	ee040593          	addi	a1,s0,-288
  8a:	ee043503          	ld	a0,-288(s0)
  8e:	00000097          	auipc	ra,0x0
  92:	30a080e7          	jalr	778(ra) # 398 <exec>
  exit(0);
  96:	4501                	li	a0,0
  98:	00000097          	auipc	ra,0x0
  9c:	2c8080e7          	jalr	712(ra) # 360 <exit>
    fprintf(2, "%s: trace failed\n", argv[0]);
  a0:	00093603          	ld	a2,0(s2)
  a4:	00000597          	auipc	a1,0x0
  a8:	7ec58593          	addi	a1,a1,2028 # 890 <malloc+0x116>
  ac:	4509                	li	a0,2
  ae:	00000097          	auipc	ra,0x0
  b2:	5e2080e7          	jalr	1506(ra) # 690 <fprintf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	2a8080e7          	jalr	680(ra) # 360 <exit>

00000000000000c0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  c8:	87aa                	mv	a5,a0
  ca:	0585                	addi	a1,a1,1
  cc:	0785                	addi	a5,a5,1
  ce:	fff5c703          	lbu	a4,-1(a1)
  d2:	fee78fa3          	sb	a4,-1(a5)
  d6:	fb75                	bnez	a4,ca <strcpy+0xa>
    ;
  return os;
}
  d8:	60a2                	ld	ra,8(sp)
  da:	6402                	ld	s0,0(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret

00000000000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e406                	sd	ra,8(sp)
  e4:	e022                	sd	s0,0(sp)
  e6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cb91                	beqz	a5,100 <strcmp+0x20>
  ee:	0005c703          	lbu	a4,0(a1)
  f2:	00f71763          	bne	a4,a5,100 <strcmp+0x20>
    p++, q++;
  f6:	0505                	addi	a0,a0,1
  f8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  fa:	00054783          	lbu	a5,0(a0)
  fe:	fbe5                	bnez	a5,ee <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 100:	0005c503          	lbu	a0,0(a1)
}
 104:	40a7853b          	subw	a0,a5,a0
 108:	60a2                	ld	ra,8(sp)
 10a:	6402                	ld	s0,0(sp)
 10c:	0141                	addi	sp,sp,16
 10e:	8082                	ret

0000000000000110 <strlen>:

uint
strlen(const char *s)
{
 110:	1141                	addi	sp,sp,-16
 112:	e406                	sd	ra,8(sp)
 114:	e022                	sd	s0,0(sp)
 116:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 118:	00054783          	lbu	a5,0(a0)
 11c:	cf99                	beqz	a5,13a <strlen+0x2a>
 11e:	0505                	addi	a0,a0,1
 120:	87aa                	mv	a5,a0
 122:	86be                	mv	a3,a5
 124:	0785                	addi	a5,a5,1
 126:	fff7c703          	lbu	a4,-1(a5)
 12a:	ff65                	bnez	a4,122 <strlen+0x12>
 12c:	40a6853b          	subw	a0,a3,a0
 130:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 132:	60a2                	ld	ra,8(sp)
 134:	6402                	ld	s0,0(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret
  for(n = 0; s[n]; n++)
 13a:	4501                	li	a0,0
 13c:	bfdd                	j	132 <strlen+0x22>

000000000000013e <memset>:

void*
memset(void *dst, int c, uint n)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e406                	sd	ra,8(sp)
 142:	e022                	sd	s0,0(sp)
 144:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 146:	ca19                	beqz	a2,15c <memset+0x1e>
 148:	87aa                	mv	a5,a0
 14a:	1602                	slli	a2,a2,0x20
 14c:	9201                	srli	a2,a2,0x20
 14e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 152:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 156:	0785                	addi	a5,a5,1
 158:	fee79de3          	bne	a5,a4,152 <memset+0x14>
  }
  return dst;
}
 15c:	60a2                	ld	ra,8(sp)
 15e:	6402                	ld	s0,0(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strchr>:

char*
strchr(const char *s, char c)
{
 164:	1141                	addi	sp,sp,-16
 166:	e406                	sd	ra,8(sp)
 168:	e022                	sd	s0,0(sp)
 16a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cf81                	beqz	a5,188 <strchr+0x24>
    if(*s == c)
 172:	00f58763          	beq	a1,a5,180 <strchr+0x1c>
  for(; *s; s++)
 176:	0505                	addi	a0,a0,1
 178:	00054783          	lbu	a5,0(a0)
 17c:	fbfd                	bnez	a5,172 <strchr+0xe>
      return (char*)s;
  return 0;
 17e:	4501                	li	a0,0
}
 180:	60a2                	ld	ra,8(sp)
 182:	6402                	ld	s0,0(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret
  return 0;
 188:	4501                	li	a0,0
 18a:	bfdd                	j	180 <strchr+0x1c>

000000000000018c <gets>:

char*
gets(char *buf, int max)
{
 18c:	7159                	addi	sp,sp,-112
 18e:	f486                	sd	ra,104(sp)
 190:	f0a2                	sd	s0,96(sp)
 192:	eca6                	sd	s1,88(sp)
 194:	e8ca                	sd	s2,80(sp)
 196:	e4ce                	sd	s3,72(sp)
 198:	e0d2                	sd	s4,64(sp)
 19a:	fc56                	sd	s5,56(sp)
 19c:	f85a                	sd	s6,48(sp)
 19e:	f45e                	sd	s7,40(sp)
 1a0:	f062                	sd	s8,32(sp)
 1a2:	ec66                	sd	s9,24(sp)
 1a4:	e86a                	sd	s10,16(sp)
 1a6:	1880                	addi	s0,sp,112
 1a8:	8caa                	mv	s9,a0
 1aa:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ac:	892a                	mv	s2,a0
 1ae:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1b0:	f9f40b13          	addi	s6,s0,-97
 1b4:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1b6:	4ba9                	li	s7,10
 1b8:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1ba:	8d26                	mv	s10,s1
 1bc:	0014899b          	addiw	s3,s1,1
 1c0:	84ce                	mv	s1,s3
 1c2:	0349d763          	bge	s3,s4,1f0 <gets+0x64>
    cc = read(0, &c, 1);
 1c6:	8656                	mv	a2,s5
 1c8:	85da                	mv	a1,s6
 1ca:	4501                	li	a0,0
 1cc:	00000097          	auipc	ra,0x0
 1d0:	1ac080e7          	jalr	428(ra) # 378 <read>
    if(cc < 1)
 1d4:	00a05e63          	blez	a0,1f0 <gets+0x64>
    buf[i++] = c;
 1d8:	f9f44783          	lbu	a5,-97(s0)
 1dc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e0:	01778763          	beq	a5,s7,1ee <gets+0x62>
 1e4:	0905                	addi	s2,s2,1
 1e6:	fd879ae3          	bne	a5,s8,1ba <gets+0x2e>
    buf[i++] = c;
 1ea:	8d4e                	mv	s10,s3
 1ec:	a011                	j	1f0 <gets+0x64>
 1ee:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1f0:	9d66                	add	s10,s10,s9
 1f2:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1f6:	8566                	mv	a0,s9
 1f8:	70a6                	ld	ra,104(sp)
 1fa:	7406                	ld	s0,96(sp)
 1fc:	64e6                	ld	s1,88(sp)
 1fe:	6946                	ld	s2,80(sp)
 200:	69a6                	ld	s3,72(sp)
 202:	6a06                	ld	s4,64(sp)
 204:	7ae2                	ld	s5,56(sp)
 206:	7b42                	ld	s6,48(sp)
 208:	7ba2                	ld	s7,40(sp)
 20a:	7c02                	ld	s8,32(sp)
 20c:	6ce2                	ld	s9,24(sp)
 20e:	6d42                	ld	s10,16(sp)
 210:	6165                	addi	sp,sp,112
 212:	8082                	ret

0000000000000214 <stat>:

int
stat(const char *n, struct stat *st)
{
 214:	1101                	addi	sp,sp,-32
 216:	ec06                	sd	ra,24(sp)
 218:	e822                	sd	s0,16(sp)
 21a:	e04a                	sd	s2,0(sp)
 21c:	1000                	addi	s0,sp,32
 21e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 220:	4581                	li	a1,0
 222:	00000097          	auipc	ra,0x0
 226:	17e080e7          	jalr	382(ra) # 3a0 <open>
  if(fd < 0)
 22a:	02054663          	bltz	a0,256 <stat+0x42>
 22e:	e426                	sd	s1,8(sp)
 230:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 232:	85ca                	mv	a1,s2
 234:	00000097          	auipc	ra,0x0
 238:	184080e7          	jalr	388(ra) # 3b8 <fstat>
 23c:	892a                	mv	s2,a0
  close(fd);
 23e:	8526                	mv	a0,s1
 240:	00000097          	auipc	ra,0x0
 244:	148080e7          	jalr	328(ra) # 388 <close>
  return r;
 248:	64a2                	ld	s1,8(sp)
}
 24a:	854a                	mv	a0,s2
 24c:	60e2                	ld	ra,24(sp)
 24e:	6442                	ld	s0,16(sp)
 250:	6902                	ld	s2,0(sp)
 252:	6105                	addi	sp,sp,32
 254:	8082                	ret
    return -1;
 256:	597d                	li	s2,-1
 258:	bfcd                	j	24a <stat+0x36>

000000000000025a <atoi>:

int
atoi(const char *s)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 262:	00054683          	lbu	a3,0(a0)
 266:	fd06879b          	addiw	a5,a3,-48
 26a:	0ff7f793          	zext.b	a5,a5
 26e:	4625                	li	a2,9
 270:	02f66963          	bltu	a2,a5,2a2 <atoi+0x48>
 274:	872a                	mv	a4,a0
  n = 0;
 276:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 278:	0705                	addi	a4,a4,1
 27a:	0025179b          	slliw	a5,a0,0x2
 27e:	9fa9                	addw	a5,a5,a0
 280:	0017979b          	slliw	a5,a5,0x1
 284:	9fb5                	addw	a5,a5,a3
 286:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 28a:	00074683          	lbu	a3,0(a4)
 28e:	fd06879b          	addiw	a5,a3,-48
 292:	0ff7f793          	zext.b	a5,a5
 296:	fef671e3          	bgeu	a2,a5,278 <atoi+0x1e>
  return n;
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret
  n = 0;
 2a2:	4501                	li	a0,0
 2a4:	bfdd                	j	29a <atoi+0x40>

00000000000002a6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e406                	sd	ra,8(sp)
 2aa:	e022                	sd	s0,0(sp)
 2ac:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2ae:	02b57563          	bgeu	a0,a1,2d8 <memmove+0x32>
    while(n-- > 0)
 2b2:	00c05f63          	blez	a2,2d0 <memmove+0x2a>
 2b6:	1602                	slli	a2,a2,0x20
 2b8:	9201                	srli	a2,a2,0x20
 2ba:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2be:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c0:	0585                	addi	a1,a1,1
 2c2:	0705                	addi	a4,a4,1
 2c4:	fff5c683          	lbu	a3,-1(a1)
 2c8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2cc:	fee79ae3          	bne	a5,a4,2c0 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d0:	60a2                	ld	ra,8(sp)
 2d2:	6402                	ld	s0,0(sp)
 2d4:	0141                	addi	sp,sp,16
 2d6:	8082                	ret
    dst += n;
 2d8:	00c50733          	add	a4,a0,a2
    src += n;
 2dc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2de:	fec059e3          	blez	a2,2d0 <memmove+0x2a>
 2e2:	fff6079b          	addiw	a5,a2,-1
 2e6:	1782                	slli	a5,a5,0x20
 2e8:	9381                	srli	a5,a5,0x20
 2ea:	fff7c793          	not	a5,a5
 2ee:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f0:	15fd                	addi	a1,a1,-1
 2f2:	177d                	addi	a4,a4,-1
 2f4:	0005c683          	lbu	a3,0(a1)
 2f8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2fc:	fef71ae3          	bne	a4,a5,2f0 <memmove+0x4a>
 300:	bfc1                	j	2d0 <memmove+0x2a>

0000000000000302 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 30a:	ca0d                	beqz	a2,33c <memcmp+0x3a>
 30c:	fff6069b          	addiw	a3,a2,-1
 310:	1682                	slli	a3,a3,0x20
 312:	9281                	srli	a3,a3,0x20
 314:	0685                	addi	a3,a3,1
 316:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 318:	00054783          	lbu	a5,0(a0)
 31c:	0005c703          	lbu	a4,0(a1)
 320:	00e79863          	bne	a5,a4,330 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 324:	0505                	addi	a0,a0,1
    p2++;
 326:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 328:	fed518e3          	bne	a0,a3,318 <memcmp+0x16>
  }
  return 0;
 32c:	4501                	li	a0,0
 32e:	a019                	j	334 <memcmp+0x32>
      return *p1 - *p2;
 330:	40e7853b          	subw	a0,a5,a4
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret
  return 0;
 33c:	4501                	li	a0,0
 33e:	bfdd                	j	334 <memcmp+0x32>

0000000000000340 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 340:	1141                	addi	sp,sp,-16
 342:	e406                	sd	ra,8(sp)
 344:	e022                	sd	s0,0(sp)
 346:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 348:	00000097          	auipc	ra,0x0
 34c:	f5e080e7          	jalr	-162(ra) # 2a6 <memmove>
}
 350:	60a2                	ld	ra,8(sp)
 352:	6402                	ld	s0,0(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret

0000000000000358 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 358:	4885                	li	a7,1
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <exit>:
.global exit
exit:
 li a7, SYS_exit
 360:	4889                	li	a7,2
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <wait>:
.global wait
wait:
 li a7, SYS_wait
 368:	488d                	li	a7,3
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 370:	4891                	li	a7,4
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <read>:
.global read
read:
 li a7, SYS_read
 378:	4895                	li	a7,5
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <write>:
.global write
write:
 li a7, SYS_write
 380:	48c1                	li	a7,16
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <close>:
.global close
close:
 li a7, SYS_close
 388:	48d5                	li	a7,21
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <kill>:
.global kill
kill:
 li a7, SYS_kill
 390:	4899                	li	a7,6
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <exec>:
.global exec
exec:
 li a7, SYS_exec
 398:	489d                	li	a7,7
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <open>:
.global open
open:
 li a7, SYS_open
 3a0:	48bd                	li	a7,15
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3a8:	48c5                	li	a7,17
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3b0:	48c9                	li	a7,18
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3b8:	48a1                	li	a7,8
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <link>:
.global link
link:
 li a7, SYS_link
 3c0:	48cd                	li	a7,19
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3c8:	48d1                	li	a7,20
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3d0:	48a5                	li	a7,9
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3d8:	48a9                	li	a7,10
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3e0:	48ad                	li	a7,11
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3e8:	48b1                	li	a7,12
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3f0:	48b5                	li	a7,13
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3f8:	48b9                	li	a7,14
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <trace>:
.global trace
trace:
 li a7, SYS_trace
 400:	48d9                	li	a7,22
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 408:	1101                	addi	sp,sp,-32
 40a:	ec06                	sd	ra,24(sp)
 40c:	e822                	sd	s0,16(sp)
 40e:	1000                	addi	s0,sp,32
 410:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 414:	4605                	li	a2,1
 416:	fef40593          	addi	a1,s0,-17
 41a:	00000097          	auipc	ra,0x0
 41e:	f66080e7          	jalr	-154(ra) # 380 <write>
}
 422:	60e2                	ld	ra,24(sp)
 424:	6442                	ld	s0,16(sp)
 426:	6105                	addi	sp,sp,32
 428:	8082                	ret

000000000000042a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 42a:	7139                	addi	sp,sp,-64
 42c:	fc06                	sd	ra,56(sp)
 42e:	f822                	sd	s0,48(sp)
 430:	f426                	sd	s1,40(sp)
 432:	f04a                	sd	s2,32(sp)
 434:	ec4e                	sd	s3,24(sp)
 436:	0080                	addi	s0,sp,64
 438:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 43a:	c299                	beqz	a3,440 <printint+0x16>
 43c:	0805c063          	bltz	a1,4bc <printint+0x92>
  neg = 0;
 440:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 442:	fc040313          	addi	t1,s0,-64
  neg = 0;
 446:	869a                	mv	a3,t1
  i = 0;
 448:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 44a:	00000817          	auipc	a6,0x0
 44e:	4be80813          	addi	a6,a6,1214 # 908 <digits>
 452:	88be                	mv	a7,a5
 454:	0017851b          	addiw	a0,a5,1
 458:	87aa                	mv	a5,a0
 45a:	02c5f73b          	remuw	a4,a1,a2
 45e:	1702                	slli	a4,a4,0x20
 460:	9301                	srli	a4,a4,0x20
 462:	9742                	add	a4,a4,a6
 464:	00074703          	lbu	a4,0(a4)
 468:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 46c:	872e                	mv	a4,a1
 46e:	02c5d5bb          	divuw	a1,a1,a2
 472:	0685                	addi	a3,a3,1
 474:	fcc77fe3          	bgeu	a4,a2,452 <printint+0x28>
  if(neg)
 478:	000e0c63          	beqz	t3,490 <printint+0x66>
    buf[i++] = '-';
 47c:	fd050793          	addi	a5,a0,-48
 480:	00878533          	add	a0,a5,s0
 484:	02d00793          	li	a5,45
 488:	fef50823          	sb	a5,-16(a0)
 48c:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 490:	fff7899b          	addiw	s3,a5,-1
 494:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 498:	fff4c583          	lbu	a1,-1(s1)
 49c:	854a                	mv	a0,s2
 49e:	00000097          	auipc	ra,0x0
 4a2:	f6a080e7          	jalr	-150(ra) # 408 <putc>
  while(--i >= 0)
 4a6:	39fd                	addiw	s3,s3,-1
 4a8:	14fd                	addi	s1,s1,-1
 4aa:	fe09d7e3          	bgez	s3,498 <printint+0x6e>
}
 4ae:	70e2                	ld	ra,56(sp)
 4b0:	7442                	ld	s0,48(sp)
 4b2:	74a2                	ld	s1,40(sp)
 4b4:	7902                	ld	s2,32(sp)
 4b6:	69e2                	ld	s3,24(sp)
 4b8:	6121                	addi	sp,sp,64
 4ba:	8082                	ret
    x = -xx;
 4bc:	40b005bb          	negw	a1,a1
    neg = 1;
 4c0:	4e05                	li	t3,1
    x = -xx;
 4c2:	b741                	j	442 <printint+0x18>

00000000000004c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4c4:	715d                	addi	sp,sp,-80
 4c6:	e486                	sd	ra,72(sp)
 4c8:	e0a2                	sd	s0,64(sp)
 4ca:	f84a                	sd	s2,48(sp)
 4cc:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4ce:	0005c903          	lbu	s2,0(a1)
 4d2:	1a090a63          	beqz	s2,686 <vprintf+0x1c2>
 4d6:	fc26                	sd	s1,56(sp)
 4d8:	f44e                	sd	s3,40(sp)
 4da:	f052                	sd	s4,32(sp)
 4dc:	ec56                	sd	s5,24(sp)
 4de:	e85a                	sd	s6,16(sp)
 4e0:	e45e                	sd	s7,8(sp)
 4e2:	8aaa                	mv	s5,a0
 4e4:	8bb2                	mv	s7,a2
 4e6:	00158493          	addi	s1,a1,1
  state = 0;
 4ea:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4ec:	02500a13          	li	s4,37
 4f0:	4b55                	li	s6,21
 4f2:	a839                	j	510 <vprintf+0x4c>
        putc(fd, c);
 4f4:	85ca                	mv	a1,s2
 4f6:	8556                	mv	a0,s5
 4f8:	00000097          	auipc	ra,0x0
 4fc:	f10080e7          	jalr	-240(ra) # 408 <putc>
 500:	a019                	j	506 <vprintf+0x42>
    } else if(state == '%'){
 502:	01498d63          	beq	s3,s4,51c <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 506:	0485                	addi	s1,s1,1
 508:	fff4c903          	lbu	s2,-1(s1)
 50c:	16090763          	beqz	s2,67a <vprintf+0x1b6>
    if(state == 0){
 510:	fe0999e3          	bnez	s3,502 <vprintf+0x3e>
      if(c == '%'){
 514:	ff4910e3          	bne	s2,s4,4f4 <vprintf+0x30>
        state = '%';
 518:	89d2                	mv	s3,s4
 51a:	b7f5                	j	506 <vprintf+0x42>
      if(c == 'd'){
 51c:	13490463          	beq	s2,s4,644 <vprintf+0x180>
 520:	f9d9079b          	addiw	a5,s2,-99
 524:	0ff7f793          	zext.b	a5,a5
 528:	12fb6763          	bltu	s6,a5,656 <vprintf+0x192>
 52c:	f9d9079b          	addiw	a5,s2,-99
 530:	0ff7f713          	zext.b	a4,a5
 534:	12eb6163          	bltu	s6,a4,656 <vprintf+0x192>
 538:	00271793          	slli	a5,a4,0x2
 53c:	00000717          	auipc	a4,0x0
 540:	37470713          	addi	a4,a4,884 # 8b0 <malloc+0x136>
 544:	97ba                	add	a5,a5,a4
 546:	439c                	lw	a5,0(a5)
 548:	97ba                	add	a5,a5,a4
 54a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 54c:	008b8913          	addi	s2,s7,8
 550:	4685                	li	a3,1
 552:	4629                	li	a2,10
 554:	000ba583          	lw	a1,0(s7)
 558:	8556                	mv	a0,s5
 55a:	00000097          	auipc	ra,0x0
 55e:	ed0080e7          	jalr	-304(ra) # 42a <printint>
 562:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 564:	4981                	li	s3,0
 566:	b745                	j	506 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 568:	008b8913          	addi	s2,s7,8
 56c:	4681                	li	a3,0
 56e:	4629                	li	a2,10
 570:	000ba583          	lw	a1,0(s7)
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	eb4080e7          	jalr	-332(ra) # 42a <printint>
 57e:	8bca                	mv	s7,s2
      state = 0;
 580:	4981                	li	s3,0
 582:	b751                	j	506 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 584:	008b8913          	addi	s2,s7,8
 588:	4681                	li	a3,0
 58a:	4641                	li	a2,16
 58c:	000ba583          	lw	a1,0(s7)
 590:	8556                	mv	a0,s5
 592:	00000097          	auipc	ra,0x0
 596:	e98080e7          	jalr	-360(ra) # 42a <printint>
 59a:	8bca                	mv	s7,s2
      state = 0;
 59c:	4981                	li	s3,0
 59e:	b7a5                	j	506 <vprintf+0x42>
 5a0:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5a2:	008b8c13          	addi	s8,s7,8
 5a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5aa:	03000593          	li	a1,48
 5ae:	8556                	mv	a0,s5
 5b0:	00000097          	auipc	ra,0x0
 5b4:	e58080e7          	jalr	-424(ra) # 408 <putc>
  putc(fd, 'x');
 5b8:	07800593          	li	a1,120
 5bc:	8556                	mv	a0,s5
 5be:	00000097          	auipc	ra,0x0
 5c2:	e4a080e7          	jalr	-438(ra) # 408 <putc>
 5c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5c8:	00000b97          	auipc	s7,0x0
 5cc:	340b8b93          	addi	s7,s7,832 # 908 <digits>
 5d0:	03c9d793          	srli	a5,s3,0x3c
 5d4:	97de                	add	a5,a5,s7
 5d6:	0007c583          	lbu	a1,0(a5)
 5da:	8556                	mv	a0,s5
 5dc:	00000097          	auipc	ra,0x0
 5e0:	e2c080e7          	jalr	-468(ra) # 408 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5e4:	0992                	slli	s3,s3,0x4
 5e6:	397d                	addiw	s2,s2,-1
 5e8:	fe0914e3          	bnez	s2,5d0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5ec:	8be2                	mv	s7,s8
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	6c02                	ld	s8,0(sp)
 5f2:	bf11                	j	506 <vprintf+0x42>
        s = va_arg(ap, char*);
 5f4:	008b8993          	addi	s3,s7,8
 5f8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5fc:	02090163          	beqz	s2,61e <vprintf+0x15a>
        while(*s != 0){
 600:	00094583          	lbu	a1,0(s2)
 604:	c9a5                	beqz	a1,674 <vprintf+0x1b0>
          putc(fd, *s);
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e00080e7          	jalr	-512(ra) # 408 <putc>
          s++;
 610:	0905                	addi	s2,s2,1
        while(*s != 0){
 612:	00094583          	lbu	a1,0(s2)
 616:	f9e5                	bnez	a1,606 <vprintf+0x142>
        s = va_arg(ap, char*);
 618:	8bce                	mv	s7,s3
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b5ed                	j	506 <vprintf+0x42>
          s = "(null)";
 61e:	00000917          	auipc	s2,0x0
 622:	28a90913          	addi	s2,s2,650 # 8a8 <malloc+0x12e>
        while(*s != 0){
 626:	02800593          	li	a1,40
 62a:	bff1                	j	606 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 62c:	008b8913          	addi	s2,s7,8
 630:	000bc583          	lbu	a1,0(s7)
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	dd2080e7          	jalr	-558(ra) # 408 <putc>
 63e:	8bca                	mv	s7,s2
      state = 0;
 640:	4981                	li	s3,0
 642:	b5d1                	j	506 <vprintf+0x42>
        putc(fd, c);
 644:	02500593          	li	a1,37
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	dbe080e7          	jalr	-578(ra) # 408 <putc>
      state = 0;
 652:	4981                	li	s3,0
 654:	bd4d                	j	506 <vprintf+0x42>
        putc(fd, '%');
 656:	02500593          	li	a1,37
 65a:	8556                	mv	a0,s5
 65c:	00000097          	auipc	ra,0x0
 660:	dac080e7          	jalr	-596(ra) # 408 <putc>
        putc(fd, c);
 664:	85ca                	mv	a1,s2
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	da0080e7          	jalr	-608(ra) # 408 <putc>
      state = 0;
 670:	4981                	li	s3,0
 672:	bd51                	j	506 <vprintf+0x42>
        s = va_arg(ap, char*);
 674:	8bce                	mv	s7,s3
      state = 0;
 676:	4981                	li	s3,0
 678:	b579                	j	506 <vprintf+0x42>
 67a:	74e2                	ld	s1,56(sp)
 67c:	79a2                	ld	s3,40(sp)
 67e:	7a02                	ld	s4,32(sp)
 680:	6ae2                	ld	s5,24(sp)
 682:	6b42                	ld	s6,16(sp)
 684:	6ba2                	ld	s7,8(sp)
    }
  }
}
 686:	60a6                	ld	ra,72(sp)
 688:	6406                	ld	s0,64(sp)
 68a:	7942                	ld	s2,48(sp)
 68c:	6161                	addi	sp,sp,80
 68e:	8082                	ret

0000000000000690 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 690:	715d                	addi	sp,sp,-80
 692:	ec06                	sd	ra,24(sp)
 694:	e822                	sd	s0,16(sp)
 696:	1000                	addi	s0,sp,32
 698:	e010                	sd	a2,0(s0)
 69a:	e414                	sd	a3,8(s0)
 69c:	e818                	sd	a4,16(s0)
 69e:	ec1c                	sd	a5,24(s0)
 6a0:	03043023          	sd	a6,32(s0)
 6a4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6a8:	8622                	mv	a2,s0
 6aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6ae:	00000097          	auipc	ra,0x0
 6b2:	e16080e7          	jalr	-490(ra) # 4c4 <vprintf>
}
 6b6:	60e2                	ld	ra,24(sp)
 6b8:	6442                	ld	s0,16(sp)
 6ba:	6161                	addi	sp,sp,80
 6bc:	8082                	ret

00000000000006be <printf>:

void
printf(const char *fmt, ...)
{
 6be:	711d                	addi	sp,sp,-96
 6c0:	ec06                	sd	ra,24(sp)
 6c2:	e822                	sd	s0,16(sp)
 6c4:	1000                	addi	s0,sp,32
 6c6:	e40c                	sd	a1,8(s0)
 6c8:	e810                	sd	a2,16(s0)
 6ca:	ec14                	sd	a3,24(s0)
 6cc:	f018                	sd	a4,32(s0)
 6ce:	f41c                	sd	a5,40(s0)
 6d0:	03043823          	sd	a6,48(s0)
 6d4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6d8:	00840613          	addi	a2,s0,8
 6dc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6e0:	85aa                	mv	a1,a0
 6e2:	4505                	li	a0,1
 6e4:	00000097          	auipc	ra,0x0
 6e8:	de0080e7          	jalr	-544(ra) # 4c4 <vprintf>
}
 6ec:	60e2                	ld	ra,24(sp)
 6ee:	6442                	ld	s0,16(sp)
 6f0:	6125                	addi	sp,sp,96
 6f2:	8082                	ret

00000000000006f4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f4:	1141                	addi	sp,sp,-16
 6f6:	e406                	sd	ra,8(sp)
 6f8:	e022                	sd	s0,0(sp)
 6fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 700:	00000797          	auipc	a5,0x0
 704:	6007b783          	ld	a5,1536(a5) # d00 <freep>
 708:	a02d                	j	732 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 70a:	4618                	lw	a4,8(a2)
 70c:	9f2d                	addw	a4,a4,a1
 70e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 712:	6398                	ld	a4,0(a5)
 714:	6310                	ld	a2,0(a4)
 716:	a83d                	j	754 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 718:	ff852703          	lw	a4,-8(a0)
 71c:	9f31                	addw	a4,a4,a2
 71e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 720:	ff053683          	ld	a3,-16(a0)
 724:	a091                	j	768 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 726:	6398                	ld	a4,0(a5)
 728:	00e7e463          	bltu	a5,a4,730 <free+0x3c>
 72c:	00e6ea63          	bltu	a3,a4,740 <free+0x4c>
{
 730:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 732:	fed7fae3          	bgeu	a5,a3,726 <free+0x32>
 736:	6398                	ld	a4,0(a5)
 738:	00e6e463          	bltu	a3,a4,740 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73c:	fee7eae3          	bltu	a5,a4,730 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 740:	ff852583          	lw	a1,-8(a0)
 744:	6390                	ld	a2,0(a5)
 746:	02059813          	slli	a6,a1,0x20
 74a:	01c85713          	srli	a4,a6,0x1c
 74e:	9736                	add	a4,a4,a3
 750:	fae60de3          	beq	a2,a4,70a <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 754:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 758:	4790                	lw	a2,8(a5)
 75a:	02061593          	slli	a1,a2,0x20
 75e:	01c5d713          	srli	a4,a1,0x1c
 762:	973e                	add	a4,a4,a5
 764:	fae68ae3          	beq	a3,a4,718 <free+0x24>
    p->s.ptr = bp->s.ptr;
 768:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 76a:	00000717          	auipc	a4,0x0
 76e:	58f73b23          	sd	a5,1430(a4) # d00 <freep>
}
 772:	60a2                	ld	ra,8(sp)
 774:	6402                	ld	s0,0(sp)
 776:	0141                	addi	sp,sp,16
 778:	8082                	ret

000000000000077a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 77a:	7139                	addi	sp,sp,-64
 77c:	fc06                	sd	ra,56(sp)
 77e:	f822                	sd	s0,48(sp)
 780:	f04a                	sd	s2,32(sp)
 782:	ec4e                	sd	s3,24(sp)
 784:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 786:	02051993          	slli	s3,a0,0x20
 78a:	0209d993          	srli	s3,s3,0x20
 78e:	09bd                	addi	s3,s3,15
 790:	0049d993          	srli	s3,s3,0x4
 794:	2985                	addiw	s3,s3,1
 796:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 798:	00000517          	auipc	a0,0x0
 79c:	56853503          	ld	a0,1384(a0) # d00 <freep>
 7a0:	c905                	beqz	a0,7d0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a4:	4798                	lw	a4,8(a5)
 7a6:	09377a63          	bgeu	a4,s3,83a <malloc+0xc0>
 7aa:	f426                	sd	s1,40(sp)
 7ac:	e852                	sd	s4,16(sp)
 7ae:	e456                	sd	s5,8(sp)
 7b0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 7b2:	8a4e                	mv	s4,s3
 7b4:	6705                	lui	a4,0x1
 7b6:	00e9f363          	bgeu	s3,a4,7bc <malloc+0x42>
 7ba:	6a05                	lui	s4,0x1
 7bc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 7c0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c4:	00000497          	auipc	s1,0x0
 7c8:	53c48493          	addi	s1,s1,1340 # d00 <freep>
  if(p == (char*)-1)
 7cc:	5afd                	li	s5,-1
 7ce:	a089                	j	810 <malloc+0x96>
 7d0:	f426                	sd	s1,40(sp)
 7d2:	e852                	sd	s4,16(sp)
 7d4:	e456                	sd	s5,8(sp)
 7d6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7d8:	00000797          	auipc	a5,0x0
 7dc:	53078793          	addi	a5,a5,1328 # d08 <base>
 7e0:	00000717          	auipc	a4,0x0
 7e4:	52f73023          	sd	a5,1312(a4) # d00 <freep>
 7e8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7ea:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ee:	b7d1                	j	7b2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 7f0:	6398                	ld	a4,0(a5)
 7f2:	e118                	sd	a4,0(a0)
 7f4:	a8b9                	j	852 <malloc+0xd8>
  hp->s.size = nu;
 7f6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7fa:	0541                	addi	a0,a0,16
 7fc:	00000097          	auipc	ra,0x0
 800:	ef8080e7          	jalr	-264(ra) # 6f4 <free>
  return freep;
 804:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 806:	c135                	beqz	a0,86a <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 808:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80a:	4798                	lw	a4,8(a5)
 80c:	03277363          	bgeu	a4,s2,832 <malloc+0xb8>
    if(p == freep)
 810:	6098                	ld	a4,0(s1)
 812:	853e                	mv	a0,a5
 814:	fef71ae3          	bne	a4,a5,808 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 818:	8552                	mv	a0,s4
 81a:	00000097          	auipc	ra,0x0
 81e:	bce080e7          	jalr	-1074(ra) # 3e8 <sbrk>
  if(p == (char*)-1)
 822:	fd551ae3          	bne	a0,s5,7f6 <malloc+0x7c>
        return 0;
 826:	4501                	li	a0,0
 828:	74a2                	ld	s1,40(sp)
 82a:	6a42                	ld	s4,16(sp)
 82c:	6aa2                	ld	s5,8(sp)
 82e:	6b02                	ld	s6,0(sp)
 830:	a03d                	j	85e <malloc+0xe4>
 832:	74a2                	ld	s1,40(sp)
 834:	6a42                	ld	s4,16(sp)
 836:	6aa2                	ld	s5,8(sp)
 838:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 83a:	fae90be3          	beq	s2,a4,7f0 <malloc+0x76>
        p->s.size -= nunits;
 83e:	4137073b          	subw	a4,a4,s3
 842:	c798                	sw	a4,8(a5)
        p += p->s.size;
 844:	02071693          	slli	a3,a4,0x20
 848:	01c6d713          	srli	a4,a3,0x1c
 84c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 84e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 852:	00000717          	auipc	a4,0x0
 856:	4aa73723          	sd	a0,1198(a4) # d00 <freep>
      return (void*)(p + 1);
 85a:	01078513          	addi	a0,a5,16
  }
}
 85e:	70e2                	ld	ra,56(sp)
 860:	7442                	ld	s0,48(sp)
 862:	7902                	ld	s2,32(sp)
 864:	69e2                	ld	s3,24(sp)
 866:	6121                	addi	sp,sp,64
 868:	8082                	ret
 86a:	74a2                	ld	s1,40(sp)
 86c:	6a42                	ld	s4,16(sp)
 86e:	6aa2                	ld	s5,8(sp)
 870:	6b02                	ld	s6,0(sp)
 872:	b7f5                	j	85e <malloc+0xe4>
