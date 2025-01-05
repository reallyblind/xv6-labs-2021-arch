
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	00001917          	auipc	s2,0x1
  18:	dcc90913          	addi	s2,s2,-564 # de0 <buf>
  1c:	20000a13          	li	s4,512
    if (write(1, buf, n) != n) {
  20:	4a85                	li	s5,1
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  22:	8652                	mv	a2,s4
  24:	85ca                	mv	a1,s2
  26:	854e                	mv	a0,s3
  28:	00000097          	auipc	ra,0x0
  2c:	3be080e7          	jalr	958(ra) # 3e6 <read>
  30:	84aa                	mv	s1,a0
  32:	02a05963          	blez	a0,64 <cat+0x64>
    if (write(1, buf, n) != n) {
  36:	8626                	mv	a2,s1
  38:	85ca                	mv	a1,s2
  3a:	8556                	mv	a0,s5
  3c:	00000097          	auipc	ra,0x0
  40:	3b2080e7          	jalr	946(ra) # 3ee <write>
  44:	fc950fe3          	beq	a0,s1,22 <cat+0x22>
      fprintf(2, "cat: write error\n");
  48:	00001597          	auipc	a1,0x1
  4c:	8a058593          	addi	a1,a1,-1888 # 8e8 <malloc+0x100>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	6ac080e7          	jalr	1708(ra) # 6fe <fprintf>
      exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	372080e7          	jalr	882(ra) # 3ce <exit>
    }
  }
  if(n < 0){
  64:	00054b63          	bltz	a0,7a <cat+0x7a>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  68:	70e2                	ld	ra,56(sp)
  6a:	7442                	ld	s0,48(sp)
  6c:	74a2                	ld	s1,40(sp)
  6e:	7902                	ld	s2,32(sp)
  70:	69e2                	ld	s3,24(sp)
  72:	6a42                	ld	s4,16(sp)
  74:	6aa2                	ld	s5,8(sp)
  76:	6121                	addi	sp,sp,64
  78:	8082                	ret
    fprintf(2, "cat: read error\n");
  7a:	00001597          	auipc	a1,0x1
  7e:	88658593          	addi	a1,a1,-1914 # 900 <malloc+0x118>
  82:	4509                	li	a0,2
  84:	00000097          	auipc	ra,0x0
  88:	67a080e7          	jalr	1658(ra) # 6fe <fprintf>
    exit(1);
  8c:	4505                	li	a0,1
  8e:	00000097          	auipc	ra,0x0
  92:	340080e7          	jalr	832(ra) # 3ce <exit>

0000000000000096 <main>:

int
main(int argc, char *argv[])
{
  96:	7179                	addi	sp,sp,-48
  98:	f406                	sd	ra,40(sp)
  9a:	f022                	sd	s0,32(sp)
  9c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  9e:	4785                	li	a5,1
  a0:	04a7da63          	bge	a5,a0,f4 <main+0x5e>
  a4:	ec26                	sd	s1,24(sp)
  a6:	e84a                	sd	s2,16(sp)
  a8:	e44e                	sd	s3,8(sp)
  aa:	00858913          	addi	s2,a1,8
  ae:	ffe5099b          	addiw	s3,a0,-2
  b2:	02099793          	slli	a5,s3,0x20
  b6:	01d7d993          	srli	s3,a5,0x1d
  ba:	05c1                	addi	a1,a1,16
  bc:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  be:	4581                	li	a1,0
  c0:	00093503          	ld	a0,0(s2)
  c4:	00000097          	auipc	ra,0x0
  c8:	34a080e7          	jalr	842(ra) # 40e <open>
  cc:	84aa                	mv	s1,a0
  ce:	04054063          	bltz	a0,10e <main+0x78>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  d2:	00000097          	auipc	ra,0x0
  d6:	f2e080e7          	jalr	-210(ra) # 0 <cat>
    close(fd);
  da:	8526                	mv	a0,s1
  dc:	00000097          	auipc	ra,0x0
  e0:	31a080e7          	jalr	794(ra) # 3f6 <close>
  for(i = 1; i < argc; i++){
  e4:	0921                	addi	s2,s2,8
  e6:	fd391ce3          	bne	s2,s3,be <main+0x28>
  }
  exit(0);
  ea:	4501                	li	a0,0
  ec:	00000097          	auipc	ra,0x0
  f0:	2e2080e7          	jalr	738(ra) # 3ce <exit>
  f4:	ec26                	sd	s1,24(sp)
  f6:	e84a                	sd	s2,16(sp)
  f8:	e44e                	sd	s3,8(sp)
    cat(0);
  fa:	4501                	li	a0,0
  fc:	00000097          	auipc	ra,0x0
 100:	f04080e7          	jalr	-252(ra) # 0 <cat>
    exit(0);
 104:	4501                	li	a0,0
 106:	00000097          	auipc	ra,0x0
 10a:	2c8080e7          	jalr	712(ra) # 3ce <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
 10e:	00093603          	ld	a2,0(s2)
 112:	00001597          	auipc	a1,0x1
 116:	80658593          	addi	a1,a1,-2042 # 918 <malloc+0x130>
 11a:	4509                	li	a0,2
 11c:	00000097          	auipc	ra,0x0
 120:	5e2080e7          	jalr	1506(ra) # 6fe <fprintf>
      exit(1);
 124:	4505                	li	a0,1
 126:	00000097          	auipc	ra,0x0
 12a:	2a8080e7          	jalr	680(ra) # 3ce <exit>

000000000000012e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e406                	sd	ra,8(sp)
 132:	e022                	sd	s0,0(sp)
 134:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 136:	87aa                	mv	a5,a0
 138:	0585                	addi	a1,a1,1
 13a:	0785                	addi	a5,a5,1
 13c:	fff5c703          	lbu	a4,-1(a1)
 140:	fee78fa3          	sb	a4,-1(a5)
 144:	fb75                	bnez	a4,138 <strcpy+0xa>
    ;
  return os;
}
 146:	60a2                	ld	ra,8(sp)
 148:	6402                	ld	s0,0(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret

000000000000014e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 14e:	1141                	addi	sp,sp,-16
 150:	e406                	sd	ra,8(sp)
 152:	e022                	sd	s0,0(sp)
 154:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	cb91                	beqz	a5,16e <strcmp+0x20>
 15c:	0005c703          	lbu	a4,0(a1)
 160:	00f71763          	bne	a4,a5,16e <strcmp+0x20>
    p++, q++;
 164:	0505                	addi	a0,a0,1
 166:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 168:	00054783          	lbu	a5,0(a0)
 16c:	fbe5                	bnez	a5,15c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 16e:	0005c503          	lbu	a0,0(a1)
}
 172:	40a7853b          	subw	a0,a5,a0
 176:	60a2                	ld	ra,8(sp)
 178:	6402                	ld	s0,0(sp)
 17a:	0141                	addi	sp,sp,16
 17c:	8082                	ret

000000000000017e <strlen>:

uint
strlen(const char *s)
{
 17e:	1141                	addi	sp,sp,-16
 180:	e406                	sd	ra,8(sp)
 182:	e022                	sd	s0,0(sp)
 184:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 186:	00054783          	lbu	a5,0(a0)
 18a:	cf99                	beqz	a5,1a8 <strlen+0x2a>
 18c:	0505                	addi	a0,a0,1
 18e:	87aa                	mv	a5,a0
 190:	86be                	mv	a3,a5
 192:	0785                	addi	a5,a5,1
 194:	fff7c703          	lbu	a4,-1(a5)
 198:	ff65                	bnez	a4,190 <strlen+0x12>
 19a:	40a6853b          	subw	a0,a3,a0
 19e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1a0:	60a2                	ld	ra,8(sp)
 1a2:	6402                	ld	s0,0(sp)
 1a4:	0141                	addi	sp,sp,16
 1a6:	8082                	ret
  for(n = 0; s[n]; n++)
 1a8:	4501                	li	a0,0
 1aa:	bfdd                	j	1a0 <strlen+0x22>

00000000000001ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ac:	1141                	addi	sp,sp,-16
 1ae:	e406                	sd	ra,8(sp)
 1b0:	e022                	sd	s0,0(sp)
 1b2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1b4:	ca19                	beqz	a2,1ca <memset+0x1e>
 1b6:	87aa                	mv	a5,a0
 1b8:	1602                	slli	a2,a2,0x20
 1ba:	9201                	srli	a2,a2,0x20
 1bc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1c0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1c4:	0785                	addi	a5,a5,1
 1c6:	fee79de3          	bne	a5,a4,1c0 <memset+0x14>
  }
  return dst;
}
 1ca:	60a2                	ld	ra,8(sp)
 1cc:	6402                	ld	s0,0(sp)
 1ce:	0141                	addi	sp,sp,16
 1d0:	8082                	ret

00000000000001d2 <strchr>:

char*
strchr(const char *s, char c)
{
 1d2:	1141                	addi	sp,sp,-16
 1d4:	e406                	sd	ra,8(sp)
 1d6:	e022                	sd	s0,0(sp)
 1d8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1da:	00054783          	lbu	a5,0(a0)
 1de:	cf81                	beqz	a5,1f6 <strchr+0x24>
    if(*s == c)
 1e0:	00f58763          	beq	a1,a5,1ee <strchr+0x1c>
  for(; *s; s++)
 1e4:	0505                	addi	a0,a0,1
 1e6:	00054783          	lbu	a5,0(a0)
 1ea:	fbfd                	bnez	a5,1e0 <strchr+0xe>
      return (char*)s;
  return 0;
 1ec:	4501                	li	a0,0
}
 1ee:	60a2                	ld	ra,8(sp)
 1f0:	6402                	ld	s0,0(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret
  return 0;
 1f6:	4501                	li	a0,0
 1f8:	bfdd                	j	1ee <strchr+0x1c>

00000000000001fa <gets>:

char*
gets(char *buf, int max)
{
 1fa:	7159                	addi	sp,sp,-112
 1fc:	f486                	sd	ra,104(sp)
 1fe:	f0a2                	sd	s0,96(sp)
 200:	eca6                	sd	s1,88(sp)
 202:	e8ca                	sd	s2,80(sp)
 204:	e4ce                	sd	s3,72(sp)
 206:	e0d2                	sd	s4,64(sp)
 208:	fc56                	sd	s5,56(sp)
 20a:	f85a                	sd	s6,48(sp)
 20c:	f45e                	sd	s7,40(sp)
 20e:	f062                	sd	s8,32(sp)
 210:	ec66                	sd	s9,24(sp)
 212:	e86a                	sd	s10,16(sp)
 214:	1880                	addi	s0,sp,112
 216:	8caa                	mv	s9,a0
 218:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21a:	892a                	mv	s2,a0
 21c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 21e:	f9f40b13          	addi	s6,s0,-97
 222:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 224:	4ba9                	li	s7,10
 226:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 228:	8d26                	mv	s10,s1
 22a:	0014899b          	addiw	s3,s1,1
 22e:	84ce                	mv	s1,s3
 230:	0349d763          	bge	s3,s4,25e <gets+0x64>
    cc = read(0, &c, 1);
 234:	8656                	mv	a2,s5
 236:	85da                	mv	a1,s6
 238:	4501                	li	a0,0
 23a:	00000097          	auipc	ra,0x0
 23e:	1ac080e7          	jalr	428(ra) # 3e6 <read>
    if(cc < 1)
 242:	00a05e63          	blez	a0,25e <gets+0x64>
    buf[i++] = c;
 246:	f9f44783          	lbu	a5,-97(s0)
 24a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 24e:	01778763          	beq	a5,s7,25c <gets+0x62>
 252:	0905                	addi	s2,s2,1
 254:	fd879ae3          	bne	a5,s8,228 <gets+0x2e>
    buf[i++] = c;
 258:	8d4e                	mv	s10,s3
 25a:	a011                	j	25e <gets+0x64>
 25c:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 25e:	9d66                	add	s10,s10,s9
 260:	000d0023          	sb	zero,0(s10)
  return buf;
}
 264:	8566                	mv	a0,s9
 266:	70a6                	ld	ra,104(sp)
 268:	7406                	ld	s0,96(sp)
 26a:	64e6                	ld	s1,88(sp)
 26c:	6946                	ld	s2,80(sp)
 26e:	69a6                	ld	s3,72(sp)
 270:	6a06                	ld	s4,64(sp)
 272:	7ae2                	ld	s5,56(sp)
 274:	7b42                	ld	s6,48(sp)
 276:	7ba2                	ld	s7,40(sp)
 278:	7c02                	ld	s8,32(sp)
 27a:	6ce2                	ld	s9,24(sp)
 27c:	6d42                	ld	s10,16(sp)
 27e:	6165                	addi	sp,sp,112
 280:	8082                	ret

0000000000000282 <stat>:

int
stat(const char *n, struct stat *st)
{
 282:	1101                	addi	sp,sp,-32
 284:	ec06                	sd	ra,24(sp)
 286:	e822                	sd	s0,16(sp)
 288:	e04a                	sd	s2,0(sp)
 28a:	1000                	addi	s0,sp,32
 28c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28e:	4581                	li	a1,0
 290:	00000097          	auipc	ra,0x0
 294:	17e080e7          	jalr	382(ra) # 40e <open>
  if(fd < 0)
 298:	02054663          	bltz	a0,2c4 <stat+0x42>
 29c:	e426                	sd	s1,8(sp)
 29e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2a0:	85ca                	mv	a1,s2
 2a2:	00000097          	auipc	ra,0x0
 2a6:	184080e7          	jalr	388(ra) # 426 <fstat>
 2aa:	892a                	mv	s2,a0
  close(fd);
 2ac:	8526                	mv	a0,s1
 2ae:	00000097          	auipc	ra,0x0
 2b2:	148080e7          	jalr	328(ra) # 3f6 <close>
  return r;
 2b6:	64a2                	ld	s1,8(sp)
}
 2b8:	854a                	mv	a0,s2
 2ba:	60e2                	ld	ra,24(sp)
 2bc:	6442                	ld	s0,16(sp)
 2be:	6902                	ld	s2,0(sp)
 2c0:	6105                	addi	sp,sp,32
 2c2:	8082                	ret
    return -1;
 2c4:	597d                	li	s2,-1
 2c6:	bfcd                	j	2b8 <stat+0x36>

00000000000002c8 <atoi>:

int
atoi(const char *s)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d0:	00054683          	lbu	a3,0(a0)
 2d4:	fd06879b          	addiw	a5,a3,-48
 2d8:	0ff7f793          	zext.b	a5,a5
 2dc:	4625                	li	a2,9
 2de:	02f66963          	bltu	a2,a5,310 <atoi+0x48>
 2e2:	872a                	mv	a4,a0
  n = 0;
 2e4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2e6:	0705                	addi	a4,a4,1
 2e8:	0025179b          	slliw	a5,a0,0x2
 2ec:	9fa9                	addw	a5,a5,a0
 2ee:	0017979b          	slliw	a5,a5,0x1
 2f2:	9fb5                	addw	a5,a5,a3
 2f4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2f8:	00074683          	lbu	a3,0(a4)
 2fc:	fd06879b          	addiw	a5,a3,-48
 300:	0ff7f793          	zext.b	a5,a5
 304:	fef671e3          	bgeu	a2,a5,2e6 <atoi+0x1e>
  return n;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
  n = 0;
 310:	4501                	li	a0,0
 312:	bfdd                	j	308 <atoi+0x40>

0000000000000314 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 314:	1141                	addi	sp,sp,-16
 316:	e406                	sd	ra,8(sp)
 318:	e022                	sd	s0,0(sp)
 31a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 31c:	02b57563          	bgeu	a0,a1,346 <memmove+0x32>
    while(n-- > 0)
 320:	00c05f63          	blez	a2,33e <memmove+0x2a>
 324:	1602                	slli	a2,a2,0x20
 326:	9201                	srli	a2,a2,0x20
 328:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 32c:	872a                	mv	a4,a0
      *dst++ = *src++;
 32e:	0585                	addi	a1,a1,1
 330:	0705                	addi	a4,a4,1
 332:	fff5c683          	lbu	a3,-1(a1)
 336:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 33a:	fee79ae3          	bne	a5,a4,32e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 33e:	60a2                	ld	ra,8(sp)
 340:	6402                	ld	s0,0(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret
    dst += n;
 346:	00c50733          	add	a4,a0,a2
    src += n;
 34a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 34c:	fec059e3          	blez	a2,33e <memmove+0x2a>
 350:	fff6079b          	addiw	a5,a2,-1
 354:	1782                	slli	a5,a5,0x20
 356:	9381                	srli	a5,a5,0x20
 358:	fff7c793          	not	a5,a5
 35c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 35e:	15fd                	addi	a1,a1,-1
 360:	177d                	addi	a4,a4,-1
 362:	0005c683          	lbu	a3,0(a1)
 366:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 36a:	fef71ae3          	bne	a4,a5,35e <memmove+0x4a>
 36e:	bfc1                	j	33e <memmove+0x2a>

0000000000000370 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 370:	1141                	addi	sp,sp,-16
 372:	e406                	sd	ra,8(sp)
 374:	e022                	sd	s0,0(sp)
 376:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 378:	ca0d                	beqz	a2,3aa <memcmp+0x3a>
 37a:	fff6069b          	addiw	a3,a2,-1
 37e:	1682                	slli	a3,a3,0x20
 380:	9281                	srli	a3,a3,0x20
 382:	0685                	addi	a3,a3,1
 384:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 386:	00054783          	lbu	a5,0(a0)
 38a:	0005c703          	lbu	a4,0(a1)
 38e:	00e79863          	bne	a5,a4,39e <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 392:	0505                	addi	a0,a0,1
    p2++;
 394:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 396:	fed518e3          	bne	a0,a3,386 <memcmp+0x16>
  }
  return 0;
 39a:	4501                	li	a0,0
 39c:	a019                	j	3a2 <memcmp+0x32>
      return *p1 - *p2;
 39e:	40e7853b          	subw	a0,a5,a4
}
 3a2:	60a2                	ld	ra,8(sp)
 3a4:	6402                	ld	s0,0(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret
  return 0;
 3aa:	4501                	li	a0,0
 3ac:	bfdd                	j	3a2 <memcmp+0x32>

00000000000003ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e406                	sd	ra,8(sp)
 3b2:	e022                	sd	s0,0(sp)
 3b4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3b6:	00000097          	auipc	ra,0x0
 3ba:	f5e080e7          	jalr	-162(ra) # 314 <memmove>
}
 3be:	60a2                	ld	ra,8(sp)
 3c0:	6402                	ld	s0,0(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3c6:	4885                	li	a7,1
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ce:	4889                	li	a7,2
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d6:	488d                	li	a7,3
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3de:	4891                	li	a7,4
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <read>:
.global read
read:
 li a7, SYS_read
 3e6:	4895                	li	a7,5
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <write>:
.global write
write:
 li a7, SYS_write
 3ee:	48c1                	li	a7,16
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <close>:
.global close
close:
 li a7, SYS_close
 3f6:	48d5                	li	a7,21
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fe:	4899                	li	a7,6
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <exec>:
.global exec
exec:
 li a7, SYS_exec
 406:	489d                	li	a7,7
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <open>:
.global open
open:
 li a7, SYS_open
 40e:	48bd                	li	a7,15
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 416:	48c5                	li	a7,17
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 41e:	48c9                	li	a7,18
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 426:	48a1                	li	a7,8
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <link>:
.global link
link:
 li a7, SYS_link
 42e:	48cd                	li	a7,19
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 436:	48d1                	li	a7,20
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 43e:	48a5                	li	a7,9
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <dup>:
.global dup
dup:
 li a7, SYS_dup
 446:	48a9                	li	a7,10
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 44e:	48ad                	li	a7,11
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 456:	48b1                	li	a7,12
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 45e:	48b5                	li	a7,13
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 466:	48b9                	li	a7,14
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <trace>:
.global trace
trace:
 li a7, SYS_trace
 46e:	48d9                	li	a7,22
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 476:	1101                	addi	sp,sp,-32
 478:	ec06                	sd	ra,24(sp)
 47a:	e822                	sd	s0,16(sp)
 47c:	1000                	addi	s0,sp,32
 47e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 482:	4605                	li	a2,1
 484:	fef40593          	addi	a1,s0,-17
 488:	00000097          	auipc	ra,0x0
 48c:	f66080e7          	jalr	-154(ra) # 3ee <write>
}
 490:	60e2                	ld	ra,24(sp)
 492:	6442                	ld	s0,16(sp)
 494:	6105                	addi	sp,sp,32
 496:	8082                	ret

0000000000000498 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 498:	7139                	addi	sp,sp,-64
 49a:	fc06                	sd	ra,56(sp)
 49c:	f822                	sd	s0,48(sp)
 49e:	f426                	sd	s1,40(sp)
 4a0:	f04a                	sd	s2,32(sp)
 4a2:	ec4e                	sd	s3,24(sp)
 4a4:	0080                	addi	s0,sp,64
 4a6:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4a8:	c299                	beqz	a3,4ae <printint+0x16>
 4aa:	0805c063          	bltz	a1,52a <printint+0x92>
  neg = 0;
 4ae:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4b0:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4b4:	869a                	mv	a3,t1
  i = 0;
 4b6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4b8:	00000817          	auipc	a6,0x0
 4bc:	4d880813          	addi	a6,a6,1240 # 990 <digits>
 4c0:	88be                	mv	a7,a5
 4c2:	0017851b          	addiw	a0,a5,1
 4c6:	87aa                	mv	a5,a0
 4c8:	02c5f73b          	remuw	a4,a1,a2
 4cc:	1702                	slli	a4,a4,0x20
 4ce:	9301                	srli	a4,a4,0x20
 4d0:	9742                	add	a4,a4,a6
 4d2:	00074703          	lbu	a4,0(a4)
 4d6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4da:	872e                	mv	a4,a1
 4dc:	02c5d5bb          	divuw	a1,a1,a2
 4e0:	0685                	addi	a3,a3,1
 4e2:	fcc77fe3          	bgeu	a4,a2,4c0 <printint+0x28>
  if(neg)
 4e6:	000e0c63          	beqz	t3,4fe <printint+0x66>
    buf[i++] = '-';
 4ea:	fd050793          	addi	a5,a0,-48
 4ee:	00878533          	add	a0,a5,s0
 4f2:	02d00793          	li	a5,45
 4f6:	fef50823          	sb	a5,-16(a0)
 4fa:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4fe:	fff7899b          	addiw	s3,a5,-1
 502:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 506:	fff4c583          	lbu	a1,-1(s1)
 50a:	854a                	mv	a0,s2
 50c:	00000097          	auipc	ra,0x0
 510:	f6a080e7          	jalr	-150(ra) # 476 <putc>
  while(--i >= 0)
 514:	39fd                	addiw	s3,s3,-1
 516:	14fd                	addi	s1,s1,-1
 518:	fe09d7e3          	bgez	s3,506 <printint+0x6e>
}
 51c:	70e2                	ld	ra,56(sp)
 51e:	7442                	ld	s0,48(sp)
 520:	74a2                	ld	s1,40(sp)
 522:	7902                	ld	s2,32(sp)
 524:	69e2                	ld	s3,24(sp)
 526:	6121                	addi	sp,sp,64
 528:	8082                	ret
    x = -xx;
 52a:	40b005bb          	negw	a1,a1
    neg = 1;
 52e:	4e05                	li	t3,1
    x = -xx;
 530:	b741                	j	4b0 <printint+0x18>

0000000000000532 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 532:	715d                	addi	sp,sp,-80
 534:	e486                	sd	ra,72(sp)
 536:	e0a2                	sd	s0,64(sp)
 538:	f84a                	sd	s2,48(sp)
 53a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 53c:	0005c903          	lbu	s2,0(a1)
 540:	1a090a63          	beqz	s2,6f4 <vprintf+0x1c2>
 544:	fc26                	sd	s1,56(sp)
 546:	f44e                	sd	s3,40(sp)
 548:	f052                	sd	s4,32(sp)
 54a:	ec56                	sd	s5,24(sp)
 54c:	e85a                	sd	s6,16(sp)
 54e:	e45e                	sd	s7,8(sp)
 550:	8aaa                	mv	s5,a0
 552:	8bb2                	mv	s7,a2
 554:	00158493          	addi	s1,a1,1
  state = 0;
 558:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 55a:	02500a13          	li	s4,37
 55e:	4b55                	li	s6,21
 560:	a839                	j	57e <vprintf+0x4c>
        putc(fd, c);
 562:	85ca                	mv	a1,s2
 564:	8556                	mv	a0,s5
 566:	00000097          	auipc	ra,0x0
 56a:	f10080e7          	jalr	-240(ra) # 476 <putc>
 56e:	a019                	j	574 <vprintf+0x42>
    } else if(state == '%'){
 570:	01498d63          	beq	s3,s4,58a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 574:	0485                	addi	s1,s1,1
 576:	fff4c903          	lbu	s2,-1(s1)
 57a:	16090763          	beqz	s2,6e8 <vprintf+0x1b6>
    if(state == 0){
 57e:	fe0999e3          	bnez	s3,570 <vprintf+0x3e>
      if(c == '%'){
 582:	ff4910e3          	bne	s2,s4,562 <vprintf+0x30>
        state = '%';
 586:	89d2                	mv	s3,s4
 588:	b7f5                	j	574 <vprintf+0x42>
      if(c == 'd'){
 58a:	13490463          	beq	s2,s4,6b2 <vprintf+0x180>
 58e:	f9d9079b          	addiw	a5,s2,-99
 592:	0ff7f793          	zext.b	a5,a5
 596:	12fb6763          	bltu	s6,a5,6c4 <vprintf+0x192>
 59a:	f9d9079b          	addiw	a5,s2,-99
 59e:	0ff7f713          	zext.b	a4,a5
 5a2:	12eb6163          	bltu	s6,a4,6c4 <vprintf+0x192>
 5a6:	00271793          	slli	a5,a4,0x2
 5aa:	00000717          	auipc	a4,0x0
 5ae:	38e70713          	addi	a4,a4,910 # 938 <malloc+0x150>
 5b2:	97ba                	add	a5,a5,a4
 5b4:	439c                	lw	a5,0(a5)
 5b6:	97ba                	add	a5,a5,a4
 5b8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5ba:	008b8913          	addi	s2,s7,8
 5be:	4685                	li	a3,1
 5c0:	4629                	li	a2,10
 5c2:	000ba583          	lw	a1,0(s7)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	ed0080e7          	jalr	-304(ra) # 498 <printint>
 5d0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	b745                	j	574 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d6:	008b8913          	addi	s2,s7,8
 5da:	4681                	li	a3,0
 5dc:	4629                	li	a2,10
 5de:	000ba583          	lw	a1,0(s7)
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	eb4080e7          	jalr	-332(ra) # 498 <printint>
 5ec:	8bca                	mv	s7,s2
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	b751                	j	574 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5f2:	008b8913          	addi	s2,s7,8
 5f6:	4681                	li	a3,0
 5f8:	4641                	li	a2,16
 5fa:	000ba583          	lw	a1,0(s7)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e98080e7          	jalr	-360(ra) # 498 <printint>
 608:	8bca                	mv	s7,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	b7a5                	j	574 <vprintf+0x42>
 60e:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 610:	008b8c13          	addi	s8,s7,8
 614:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 618:	03000593          	li	a1,48
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	e58080e7          	jalr	-424(ra) # 476 <putc>
  putc(fd, 'x');
 626:	07800593          	li	a1,120
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e4a080e7          	jalr	-438(ra) # 476 <putc>
 634:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 636:	00000b97          	auipc	s7,0x0
 63a:	35ab8b93          	addi	s7,s7,858 # 990 <digits>
 63e:	03c9d793          	srli	a5,s3,0x3c
 642:	97de                	add	a5,a5,s7
 644:	0007c583          	lbu	a1,0(a5)
 648:	8556                	mv	a0,s5
 64a:	00000097          	auipc	ra,0x0
 64e:	e2c080e7          	jalr	-468(ra) # 476 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 652:	0992                	slli	s3,s3,0x4
 654:	397d                	addiw	s2,s2,-1
 656:	fe0914e3          	bnez	s2,63e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 65a:	8be2                	mv	s7,s8
      state = 0;
 65c:	4981                	li	s3,0
 65e:	6c02                	ld	s8,0(sp)
 660:	bf11                	j	574 <vprintf+0x42>
        s = va_arg(ap, char*);
 662:	008b8993          	addi	s3,s7,8
 666:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 66a:	02090163          	beqz	s2,68c <vprintf+0x15a>
        while(*s != 0){
 66e:	00094583          	lbu	a1,0(s2)
 672:	c9a5                	beqz	a1,6e2 <vprintf+0x1b0>
          putc(fd, *s);
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e00080e7          	jalr	-512(ra) # 476 <putc>
          s++;
 67e:	0905                	addi	s2,s2,1
        while(*s != 0){
 680:	00094583          	lbu	a1,0(s2)
 684:	f9e5                	bnez	a1,674 <vprintf+0x142>
        s = va_arg(ap, char*);
 686:	8bce                	mv	s7,s3
      state = 0;
 688:	4981                	li	s3,0
 68a:	b5ed                	j	574 <vprintf+0x42>
          s = "(null)";
 68c:	00000917          	auipc	s2,0x0
 690:	2a490913          	addi	s2,s2,676 # 930 <malloc+0x148>
        while(*s != 0){
 694:	02800593          	li	a1,40
 698:	bff1                	j	674 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 69a:	008b8913          	addi	s2,s7,8
 69e:	000bc583          	lbu	a1,0(s7)
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	dd2080e7          	jalr	-558(ra) # 476 <putc>
 6ac:	8bca                	mv	s7,s2
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	b5d1                	j	574 <vprintf+0x42>
        putc(fd, c);
 6b2:	02500593          	li	a1,37
 6b6:	8556                	mv	a0,s5
 6b8:	00000097          	auipc	ra,0x0
 6bc:	dbe080e7          	jalr	-578(ra) # 476 <putc>
      state = 0;
 6c0:	4981                	li	s3,0
 6c2:	bd4d                	j	574 <vprintf+0x42>
        putc(fd, '%');
 6c4:	02500593          	li	a1,37
 6c8:	8556                	mv	a0,s5
 6ca:	00000097          	auipc	ra,0x0
 6ce:	dac080e7          	jalr	-596(ra) # 476 <putc>
        putc(fd, c);
 6d2:	85ca                	mv	a1,s2
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	da0080e7          	jalr	-608(ra) # 476 <putc>
      state = 0;
 6de:	4981                	li	s3,0
 6e0:	bd51                	j	574 <vprintf+0x42>
        s = va_arg(ap, char*);
 6e2:	8bce                	mv	s7,s3
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	b579                	j	574 <vprintf+0x42>
 6e8:	74e2                	ld	s1,56(sp)
 6ea:	79a2                	ld	s3,40(sp)
 6ec:	7a02                	ld	s4,32(sp)
 6ee:	6ae2                	ld	s5,24(sp)
 6f0:	6b42                	ld	s6,16(sp)
 6f2:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6f4:	60a6                	ld	ra,72(sp)
 6f6:	6406                	ld	s0,64(sp)
 6f8:	7942                	ld	s2,48(sp)
 6fa:	6161                	addi	sp,sp,80
 6fc:	8082                	ret

00000000000006fe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6fe:	715d                	addi	sp,sp,-80
 700:	ec06                	sd	ra,24(sp)
 702:	e822                	sd	s0,16(sp)
 704:	1000                	addi	s0,sp,32
 706:	e010                	sd	a2,0(s0)
 708:	e414                	sd	a3,8(s0)
 70a:	e818                	sd	a4,16(s0)
 70c:	ec1c                	sd	a5,24(s0)
 70e:	03043023          	sd	a6,32(s0)
 712:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 716:	8622                	mv	a2,s0
 718:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 71c:	00000097          	auipc	ra,0x0
 720:	e16080e7          	jalr	-490(ra) # 532 <vprintf>
}
 724:	60e2                	ld	ra,24(sp)
 726:	6442                	ld	s0,16(sp)
 728:	6161                	addi	sp,sp,80
 72a:	8082                	ret

000000000000072c <printf>:

void
printf(const char *fmt, ...)
{
 72c:	711d                	addi	sp,sp,-96
 72e:	ec06                	sd	ra,24(sp)
 730:	e822                	sd	s0,16(sp)
 732:	1000                	addi	s0,sp,32
 734:	e40c                	sd	a1,8(s0)
 736:	e810                	sd	a2,16(s0)
 738:	ec14                	sd	a3,24(s0)
 73a:	f018                	sd	a4,32(s0)
 73c:	f41c                	sd	a5,40(s0)
 73e:	03043823          	sd	a6,48(s0)
 742:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 746:	00840613          	addi	a2,s0,8
 74a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 74e:	85aa                	mv	a1,a0
 750:	4505                	li	a0,1
 752:	00000097          	auipc	ra,0x0
 756:	de0080e7          	jalr	-544(ra) # 532 <vprintf>
}
 75a:	60e2                	ld	ra,24(sp)
 75c:	6442                	ld	s0,16(sp)
 75e:	6125                	addi	sp,sp,96
 760:	8082                	ret

0000000000000762 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 762:	1141                	addi	sp,sp,-16
 764:	e406                	sd	ra,8(sp)
 766:	e022                	sd	s0,0(sp)
 768:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 76a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76e:	00000797          	auipc	a5,0x0
 772:	66a7b783          	ld	a5,1642(a5) # dd8 <freep>
 776:	a02d                	j	7a0 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 778:	4618                	lw	a4,8(a2)
 77a:	9f2d                	addw	a4,a4,a1
 77c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 780:	6398                	ld	a4,0(a5)
 782:	6310                	ld	a2,0(a4)
 784:	a83d                	j	7c2 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 786:	ff852703          	lw	a4,-8(a0)
 78a:	9f31                	addw	a4,a4,a2
 78c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 78e:	ff053683          	ld	a3,-16(a0)
 792:	a091                	j	7d6 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	6398                	ld	a4,0(a5)
 796:	00e7e463          	bltu	a5,a4,79e <free+0x3c>
 79a:	00e6ea63          	bltu	a3,a4,7ae <free+0x4c>
{
 79e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	fed7fae3          	bgeu	a5,a3,794 <free+0x32>
 7a4:	6398                	ld	a4,0(a5)
 7a6:	00e6e463          	bltu	a3,a4,7ae <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7aa:	fee7eae3          	bltu	a5,a4,79e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7ae:	ff852583          	lw	a1,-8(a0)
 7b2:	6390                	ld	a2,0(a5)
 7b4:	02059813          	slli	a6,a1,0x20
 7b8:	01c85713          	srli	a4,a6,0x1c
 7bc:	9736                	add	a4,a4,a3
 7be:	fae60de3          	beq	a2,a4,778 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7c2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c6:	4790                	lw	a2,8(a5)
 7c8:	02061593          	slli	a1,a2,0x20
 7cc:	01c5d713          	srli	a4,a1,0x1c
 7d0:	973e                	add	a4,a4,a5
 7d2:	fae68ae3          	beq	a3,a4,786 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7d6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7d8:	00000717          	auipc	a4,0x0
 7dc:	60f73023          	sd	a5,1536(a4) # dd8 <freep>
}
 7e0:	60a2                	ld	ra,8(sp)
 7e2:	6402                	ld	s0,0(sp)
 7e4:	0141                	addi	sp,sp,16
 7e6:	8082                	ret

00000000000007e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e8:	7139                	addi	sp,sp,-64
 7ea:	fc06                	sd	ra,56(sp)
 7ec:	f822                	sd	s0,48(sp)
 7ee:	f04a                	sd	s2,32(sp)
 7f0:	ec4e                	sd	s3,24(sp)
 7f2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f4:	02051993          	slli	s3,a0,0x20
 7f8:	0209d993          	srli	s3,s3,0x20
 7fc:	09bd                	addi	s3,s3,15
 7fe:	0049d993          	srli	s3,s3,0x4
 802:	2985                	addiw	s3,s3,1
 804:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 806:	00000517          	auipc	a0,0x0
 80a:	5d253503          	ld	a0,1490(a0) # dd8 <freep>
 80e:	c905                	beqz	a0,83e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 812:	4798                	lw	a4,8(a5)
 814:	09377a63          	bgeu	a4,s3,8a8 <malloc+0xc0>
 818:	f426                	sd	s1,40(sp)
 81a:	e852                	sd	s4,16(sp)
 81c:	e456                	sd	s5,8(sp)
 81e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 820:	8a4e                	mv	s4,s3
 822:	6705                	lui	a4,0x1
 824:	00e9f363          	bgeu	s3,a4,82a <malloc+0x42>
 828:	6a05                	lui	s4,0x1
 82a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 82e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 832:	00000497          	auipc	s1,0x0
 836:	5a648493          	addi	s1,s1,1446 # dd8 <freep>
  if(p == (char*)-1)
 83a:	5afd                	li	s5,-1
 83c:	a089                	j	87e <malloc+0x96>
 83e:	f426                	sd	s1,40(sp)
 840:	e852                	sd	s4,16(sp)
 842:	e456                	sd	s5,8(sp)
 844:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 846:	00000797          	auipc	a5,0x0
 84a:	79a78793          	addi	a5,a5,1946 # fe0 <base>
 84e:	00000717          	auipc	a4,0x0
 852:	58f73523          	sd	a5,1418(a4) # dd8 <freep>
 856:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 858:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 85c:	b7d1                	j	820 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 85e:	6398                	ld	a4,0(a5)
 860:	e118                	sd	a4,0(a0)
 862:	a8b9                	j	8c0 <malloc+0xd8>
  hp->s.size = nu;
 864:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 868:	0541                	addi	a0,a0,16
 86a:	00000097          	auipc	ra,0x0
 86e:	ef8080e7          	jalr	-264(ra) # 762 <free>
  return freep;
 872:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 874:	c135                	beqz	a0,8d8 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 876:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 878:	4798                	lw	a4,8(a5)
 87a:	03277363          	bgeu	a4,s2,8a0 <malloc+0xb8>
    if(p == freep)
 87e:	6098                	ld	a4,0(s1)
 880:	853e                	mv	a0,a5
 882:	fef71ae3          	bne	a4,a5,876 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 886:	8552                	mv	a0,s4
 888:	00000097          	auipc	ra,0x0
 88c:	bce080e7          	jalr	-1074(ra) # 456 <sbrk>
  if(p == (char*)-1)
 890:	fd551ae3          	bne	a0,s5,864 <malloc+0x7c>
        return 0;
 894:	4501                	li	a0,0
 896:	74a2                	ld	s1,40(sp)
 898:	6a42                	ld	s4,16(sp)
 89a:	6aa2                	ld	s5,8(sp)
 89c:	6b02                	ld	s6,0(sp)
 89e:	a03d                	j	8cc <malloc+0xe4>
 8a0:	74a2                	ld	s1,40(sp)
 8a2:	6a42                	ld	s4,16(sp)
 8a4:	6aa2                	ld	s5,8(sp)
 8a6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8a8:	fae90be3          	beq	s2,a4,85e <malloc+0x76>
        p->s.size -= nunits;
 8ac:	4137073b          	subw	a4,a4,s3
 8b0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b2:	02071693          	slli	a3,a4,0x20
 8b6:	01c6d713          	srli	a4,a3,0x1c
 8ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8c0:	00000717          	auipc	a4,0x0
 8c4:	50a73c23          	sd	a0,1304(a4) # dd8 <freep>
      return (void*)(p + 1);
 8c8:	01078513          	addi	a0,a5,16
  }
}
 8cc:	70e2                	ld	ra,56(sp)
 8ce:	7442                	ld	s0,48(sp)
 8d0:	7902                	ld	s2,32(sp)
 8d2:	69e2                	ld	s3,24(sp)
 8d4:	6121                	addi	sp,sp,64
 8d6:	8082                	ret
 8d8:	74a2                	ld	s1,40(sp)
 8da:	6a42                	ld	s4,16(sp)
 8dc:	6aa2                	ld	s5,8(sp)
 8de:	6b02                	ld	s6,0(sp)
 8e0:	b7f5                	j	8cc <malloc+0xe4>
