
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	e2ad8d93          	addi	s11,s11,-470 # e58 <buf>
  36:	20000d13          	li	s10,512
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	90ca0a13          	addi	s4,s4,-1780 # 948 <malloc+0xfe>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a805                	j	74 <wc+0x74>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	00000097          	auipc	ra,0x0
  4c:	1ec080e7          	jalr	492(ra) # 234 <strchr>
  50:	c919                	beqz	a0,66 <wc+0x66>
        inword = 0;
  52:	4901                	li	s2,0
    for(i=0; i<n; i++){
  54:	0485                	addi	s1,s1,1
  56:	01348d63          	beq	s1,s3,70 <wc+0x70>
      if(buf[i] == '\n')
  5a:	0004c583          	lbu	a1,0(s1)
  5e:	ff5594e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  62:	2b85                	addiw	s7,s7,1
  64:	b7cd                	j	46 <wc+0x46>
      else if(!inword){
  66:	fe0917e3          	bnez	s2,54 <wc+0x54>
        w++;
  6a:	2c05                	addiw	s8,s8,1
        inword = 1;
  6c:	4905                	li	s2,1
  6e:	b7dd                	j	54 <wc+0x54>
  70:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  74:	866a                	mv	a2,s10
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	3cc080e7          	jalr	972(ra) # 448 <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
  8a:	00001497          	auipc	s1,0x1
  8e:	dce48493          	addi	s1,s1,-562 # e58 <buf>
  92:	009b09b3          	add	s3,s6,s1
  96:	b7d1                	j	5a <wc+0x5a>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86e6                	mv	a3,s9
  a2:	8662                	mv	a2,s8
  a4:	85de                	mv	a1,s7
  a6:	00001517          	auipc	a0,0x1
  aa:	8c250513          	addi	a0,a0,-1854 # 968 <malloc+0x11e>
  ae:	00000097          	auipc	ra,0x0
  b2:	6e0080e7          	jalr	1760(ra) # 78e <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	addi	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	88450513          	addi	a0,a0,-1916 # 958 <malloc+0x10e>
  dc:	00000097          	auipc	ra,0x0
  e0:	6b2080e7          	jalr	1714(ra) # 78e <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	34a080e7          	jalr	842(ra) # 430 <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	addi	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  f6:	4785                	li	a5,1
  f8:	04a7dc63          	bge	a5,a0,150 <main+0x62>
  fc:	ec26                	sd	s1,24(sp)
  fe:	e84a                	sd	s2,16(sp)
 100:	e44e                	sd	s3,8(sp)
 102:	00858913          	addi	s2,a1,8
 106:	ffe5099b          	addiw	s3,a0,-2
 10a:	02099793          	slli	a5,s3,0x20
 10e:	01d7d993          	srli	s3,a5,0x1d
 112:	05c1                	addi	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	354080e7          	jalr	852(ra) # 470 <open>
 124:	84aa                	mv	s1,a0
 126:	04054663          	bltz	a0,172 <main+0x84>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	320080e7          	jalr	800(ra) # 458 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	2e8080e7          	jalr	744(ra) # 430 <exit>
 150:	ec26                	sd	s1,24(sp)
 152:	e84a                	sd	s2,16(sp)
 154:	e44e                	sd	s3,8(sp)
    wc(0, "");
 156:	00000597          	auipc	a1,0x0
 15a:	7fa58593          	addi	a1,a1,2042 # 950 <malloc+0x106>
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	ea0080e7          	jalr	-352(ra) # 0 <wc>
    exit(0);
 168:	4501                	li	a0,0
 16a:	00000097          	auipc	ra,0x0
 16e:	2c6080e7          	jalr	710(ra) # 430 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 172:	00093583          	ld	a1,0(s2)
 176:	00001517          	auipc	a0,0x1
 17a:	80250513          	addi	a0,a0,-2046 # 978 <malloc+0x12e>
 17e:	00000097          	auipc	ra,0x0
 182:	610080e7          	jalr	1552(ra) # 78e <printf>
      exit(1);
 186:	4505                	li	a0,1
 188:	00000097          	auipc	ra,0x0
 18c:	2a8080e7          	jalr	680(ra) # 430 <exit>

0000000000000190 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 190:	1141                	addi	sp,sp,-16
 192:	e406                	sd	ra,8(sp)
 194:	e022                	sd	s0,0(sp)
 196:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 198:	87aa                	mv	a5,a0
 19a:	0585                	addi	a1,a1,1
 19c:	0785                	addi	a5,a5,1
 19e:	fff5c703          	lbu	a4,-1(a1)
 1a2:	fee78fa3          	sb	a4,-1(a5)
 1a6:	fb75                	bnez	a4,19a <strcpy+0xa>
    ;
  return os;
}
 1a8:	60a2                	ld	ra,8(sp)
 1aa:	6402                	ld	s0,0(sp)
 1ac:	0141                	addi	sp,sp,16
 1ae:	8082                	ret

00000000000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e406                	sd	ra,8(sp)
 1b4:	e022                	sd	s0,0(sp)
 1b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	cb91                	beqz	a5,1d0 <strcmp+0x20>
 1be:	0005c703          	lbu	a4,0(a1)
 1c2:	00f71763          	bne	a4,a5,1d0 <strcmp+0x20>
    p++, q++;
 1c6:	0505                	addi	a0,a0,1
 1c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	fbe5                	bnez	a5,1be <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1d0:	0005c503          	lbu	a0,0(a1)
}
 1d4:	40a7853b          	subw	a0,a5,a0
 1d8:	60a2                	ld	ra,8(sp)
 1da:	6402                	ld	s0,0(sp)
 1dc:	0141                	addi	sp,sp,16
 1de:	8082                	ret

00000000000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e406                	sd	ra,8(sp)
 1e4:	e022                	sd	s0,0(sp)
 1e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	cf99                	beqz	a5,20a <strlen+0x2a>
 1ee:	0505                	addi	a0,a0,1
 1f0:	87aa                	mv	a5,a0
 1f2:	86be                	mv	a3,a5
 1f4:	0785                	addi	a5,a5,1
 1f6:	fff7c703          	lbu	a4,-1(a5)
 1fa:	ff65                	bnez	a4,1f2 <strlen+0x12>
 1fc:	40a6853b          	subw	a0,a3,a0
 200:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 202:	60a2                	ld	ra,8(sp)
 204:	6402                	ld	s0,0(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret
  for(n = 0; s[n]; n++)
 20a:	4501                	li	a0,0
 20c:	bfdd                	j	202 <strlen+0x22>

000000000000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e406                	sd	ra,8(sp)
 212:	e022                	sd	s0,0(sp)
 214:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 216:	ca19                	beqz	a2,22c <memset+0x1e>
 218:	87aa                	mv	a5,a0
 21a:	1602                	slli	a2,a2,0x20
 21c:	9201                	srli	a2,a2,0x20
 21e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 222:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 226:	0785                	addi	a5,a5,1
 228:	fee79de3          	bne	a5,a4,222 <memset+0x14>
  }
  return dst;
}
 22c:	60a2                	ld	ra,8(sp)
 22e:	6402                	ld	s0,0(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret

0000000000000234 <strchr>:

char*
strchr(const char *s, char c)
{
 234:	1141                	addi	sp,sp,-16
 236:	e406                	sd	ra,8(sp)
 238:	e022                	sd	s0,0(sp)
 23a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cf81                	beqz	a5,258 <strchr+0x24>
    if(*s == c)
 242:	00f58763          	beq	a1,a5,250 <strchr+0x1c>
  for(; *s; s++)
 246:	0505                	addi	a0,a0,1
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbfd                	bnez	a5,242 <strchr+0xe>
      return (char*)s;
  return 0;
 24e:	4501                	li	a0,0
}
 250:	60a2                	ld	ra,8(sp)
 252:	6402                	ld	s0,0(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret
  return 0;
 258:	4501                	li	a0,0
 25a:	bfdd                	j	250 <strchr+0x1c>

000000000000025c <gets>:

char*
gets(char *buf, int max)
{
 25c:	7159                	addi	sp,sp,-112
 25e:	f486                	sd	ra,104(sp)
 260:	f0a2                	sd	s0,96(sp)
 262:	eca6                	sd	s1,88(sp)
 264:	e8ca                	sd	s2,80(sp)
 266:	e4ce                	sd	s3,72(sp)
 268:	e0d2                	sd	s4,64(sp)
 26a:	fc56                	sd	s5,56(sp)
 26c:	f85a                	sd	s6,48(sp)
 26e:	f45e                	sd	s7,40(sp)
 270:	f062                	sd	s8,32(sp)
 272:	ec66                	sd	s9,24(sp)
 274:	e86a                	sd	s10,16(sp)
 276:	1880                	addi	s0,sp,112
 278:	8caa                	mv	s9,a0
 27a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	892a                	mv	s2,a0
 27e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 280:	f9f40b13          	addi	s6,s0,-97
 284:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 286:	4ba9                	li	s7,10
 288:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 28a:	8d26                	mv	s10,s1
 28c:	0014899b          	addiw	s3,s1,1
 290:	84ce                	mv	s1,s3
 292:	0349d763          	bge	s3,s4,2c0 <gets+0x64>
    cc = read(0, &c, 1);
 296:	8656                	mv	a2,s5
 298:	85da                	mv	a1,s6
 29a:	4501                	li	a0,0
 29c:	00000097          	auipc	ra,0x0
 2a0:	1ac080e7          	jalr	428(ra) # 448 <read>
    if(cc < 1)
 2a4:	00a05e63          	blez	a0,2c0 <gets+0x64>
    buf[i++] = c;
 2a8:	f9f44783          	lbu	a5,-97(s0)
 2ac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b0:	01778763          	beq	a5,s7,2be <gets+0x62>
 2b4:	0905                	addi	s2,s2,1
 2b6:	fd879ae3          	bne	a5,s8,28a <gets+0x2e>
    buf[i++] = c;
 2ba:	8d4e                	mv	s10,s3
 2bc:	a011                	j	2c0 <gets+0x64>
 2be:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 2c0:	9d66                	add	s10,s10,s9
 2c2:	000d0023          	sb	zero,0(s10)
  return buf;
}
 2c6:	8566                	mv	a0,s9
 2c8:	70a6                	ld	ra,104(sp)
 2ca:	7406                	ld	s0,96(sp)
 2cc:	64e6                	ld	s1,88(sp)
 2ce:	6946                	ld	s2,80(sp)
 2d0:	69a6                	ld	s3,72(sp)
 2d2:	6a06                	ld	s4,64(sp)
 2d4:	7ae2                	ld	s5,56(sp)
 2d6:	7b42                	ld	s6,48(sp)
 2d8:	7ba2                	ld	s7,40(sp)
 2da:	7c02                	ld	s8,32(sp)
 2dc:	6ce2                	ld	s9,24(sp)
 2de:	6d42                	ld	s10,16(sp)
 2e0:	6165                	addi	sp,sp,112
 2e2:	8082                	ret

00000000000002e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e4:	1101                	addi	sp,sp,-32
 2e6:	ec06                	sd	ra,24(sp)
 2e8:	e822                	sd	s0,16(sp)
 2ea:	e04a                	sd	s2,0(sp)
 2ec:	1000                	addi	s0,sp,32
 2ee:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f0:	4581                	li	a1,0
 2f2:	00000097          	auipc	ra,0x0
 2f6:	17e080e7          	jalr	382(ra) # 470 <open>
  if(fd < 0)
 2fa:	02054663          	bltz	a0,326 <stat+0x42>
 2fe:	e426                	sd	s1,8(sp)
 300:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 302:	85ca                	mv	a1,s2
 304:	00000097          	auipc	ra,0x0
 308:	184080e7          	jalr	388(ra) # 488 <fstat>
 30c:	892a                	mv	s2,a0
  close(fd);
 30e:	8526                	mv	a0,s1
 310:	00000097          	auipc	ra,0x0
 314:	148080e7          	jalr	328(ra) # 458 <close>
  return r;
 318:	64a2                	ld	s1,8(sp)
}
 31a:	854a                	mv	a0,s2
 31c:	60e2                	ld	ra,24(sp)
 31e:	6442                	ld	s0,16(sp)
 320:	6902                	ld	s2,0(sp)
 322:	6105                	addi	sp,sp,32
 324:	8082                	ret
    return -1;
 326:	597d                	li	s2,-1
 328:	bfcd                	j	31a <stat+0x36>

000000000000032a <atoi>:

int
atoi(const char *s)
{
 32a:	1141                	addi	sp,sp,-16
 32c:	e406                	sd	ra,8(sp)
 32e:	e022                	sd	s0,0(sp)
 330:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 332:	00054683          	lbu	a3,0(a0)
 336:	fd06879b          	addiw	a5,a3,-48
 33a:	0ff7f793          	zext.b	a5,a5
 33e:	4625                	li	a2,9
 340:	02f66963          	bltu	a2,a5,372 <atoi+0x48>
 344:	872a                	mv	a4,a0
  n = 0;
 346:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 348:	0705                	addi	a4,a4,1
 34a:	0025179b          	slliw	a5,a0,0x2
 34e:	9fa9                	addw	a5,a5,a0
 350:	0017979b          	slliw	a5,a5,0x1
 354:	9fb5                	addw	a5,a5,a3
 356:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35a:	00074683          	lbu	a3,0(a4)
 35e:	fd06879b          	addiw	a5,a3,-48
 362:	0ff7f793          	zext.b	a5,a5
 366:	fef671e3          	bgeu	a2,a5,348 <atoi+0x1e>
  return n;
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
  n = 0;
 372:	4501                	li	a0,0
 374:	bfdd                	j	36a <atoi+0x40>

0000000000000376 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37e:	02b57563          	bgeu	a0,a1,3a8 <memmove+0x32>
    while(n-- > 0)
 382:	00c05f63          	blez	a2,3a0 <memmove+0x2a>
 386:	1602                	slli	a2,a2,0x20
 388:	9201                	srli	a2,a2,0x20
 38a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38e:	872a                	mv	a4,a0
      *dst++ = *src++;
 390:	0585                	addi	a1,a1,1
 392:	0705                	addi	a4,a4,1
 394:	fff5c683          	lbu	a3,-1(a1)
 398:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 39c:	fee79ae3          	bne	a5,a4,390 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3a0:	60a2                	ld	ra,8(sp)
 3a2:	6402                	ld	s0,0(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret
    dst += n;
 3a8:	00c50733          	add	a4,a0,a2
    src += n;
 3ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ae:	fec059e3          	blez	a2,3a0 <memmove+0x2a>
 3b2:	fff6079b          	addiw	a5,a2,-1
 3b6:	1782                	slli	a5,a5,0x20
 3b8:	9381                	srli	a5,a5,0x20
 3ba:	fff7c793          	not	a5,a5
 3be:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3c0:	15fd                	addi	a1,a1,-1
 3c2:	177d                	addi	a4,a4,-1
 3c4:	0005c683          	lbu	a3,0(a1)
 3c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3cc:	fef71ae3          	bne	a4,a5,3c0 <memmove+0x4a>
 3d0:	bfc1                	j	3a0 <memmove+0x2a>

00000000000003d2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e406                	sd	ra,8(sp)
 3d6:	e022                	sd	s0,0(sp)
 3d8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3da:	ca0d                	beqz	a2,40c <memcmp+0x3a>
 3dc:	fff6069b          	addiw	a3,a2,-1
 3e0:	1682                	slli	a3,a3,0x20
 3e2:	9281                	srli	a3,a3,0x20
 3e4:	0685                	addi	a3,a3,1
 3e6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e8:	00054783          	lbu	a5,0(a0)
 3ec:	0005c703          	lbu	a4,0(a1)
 3f0:	00e79863          	bne	a5,a4,400 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 3f4:	0505                	addi	a0,a0,1
    p2++;
 3f6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f8:	fed518e3          	bne	a0,a3,3e8 <memcmp+0x16>
  }
  return 0;
 3fc:	4501                	li	a0,0
 3fe:	a019                	j	404 <memcmp+0x32>
      return *p1 - *p2;
 400:	40e7853b          	subw	a0,a5,a4
}
 404:	60a2                	ld	ra,8(sp)
 406:	6402                	ld	s0,0(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret
  return 0;
 40c:	4501                	li	a0,0
 40e:	bfdd                	j	404 <memcmp+0x32>

0000000000000410 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 410:	1141                	addi	sp,sp,-16
 412:	e406                	sd	ra,8(sp)
 414:	e022                	sd	s0,0(sp)
 416:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 418:	00000097          	auipc	ra,0x0
 41c:	f5e080e7          	jalr	-162(ra) # 376 <memmove>
}
 420:	60a2                	ld	ra,8(sp)
 422:	6402                	ld	s0,0(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 428:	4885                	li	a7,1
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <exit>:
.global exit
exit:
 li a7, SYS_exit
 430:	4889                	li	a7,2
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <wait>:
.global wait
wait:
 li a7, SYS_wait
 438:	488d                	li	a7,3
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 440:	4891                	li	a7,4
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <read>:
.global read
read:
 li a7, SYS_read
 448:	4895                	li	a7,5
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <write>:
.global write
write:
 li a7, SYS_write
 450:	48c1                	li	a7,16
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <close>:
.global close
close:
 li a7, SYS_close
 458:	48d5                	li	a7,21
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <kill>:
.global kill
kill:
 li a7, SYS_kill
 460:	4899                	li	a7,6
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <exec>:
.global exec
exec:
 li a7, SYS_exec
 468:	489d                	li	a7,7
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <open>:
.global open
open:
 li a7, SYS_open
 470:	48bd                	li	a7,15
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 478:	48c5                	li	a7,17
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 480:	48c9                	li	a7,18
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 488:	48a1                	li	a7,8
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <link>:
.global link
link:
 li a7, SYS_link
 490:	48cd                	li	a7,19
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 498:	48d1                	li	a7,20
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4a0:	48a5                	li	a7,9
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a8:	48a9                	li	a7,10
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4b0:	48ad                	li	a7,11
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b8:	48b1                	li	a7,12
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4c0:	48b5                	li	a7,13
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c8:	48b9                	li	a7,14
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 4d0:	48d9                	li	a7,22
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4d8:	1101                	addi	sp,sp,-32
 4da:	ec06                	sd	ra,24(sp)
 4dc:	e822                	sd	s0,16(sp)
 4de:	1000                	addi	s0,sp,32
 4e0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e4:	4605                	li	a2,1
 4e6:	fef40593          	addi	a1,s0,-17
 4ea:	00000097          	auipc	ra,0x0
 4ee:	f66080e7          	jalr	-154(ra) # 450 <write>
}
 4f2:	60e2                	ld	ra,24(sp)
 4f4:	6442                	ld	s0,16(sp)
 4f6:	6105                	addi	sp,sp,32
 4f8:	8082                	ret

00000000000004fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4fa:	7139                	addi	sp,sp,-64
 4fc:	fc06                	sd	ra,56(sp)
 4fe:	f822                	sd	s0,48(sp)
 500:	f426                	sd	s1,40(sp)
 502:	f04a                	sd	s2,32(sp)
 504:	ec4e                	sd	s3,24(sp)
 506:	0080                	addi	s0,sp,64
 508:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50a:	c299                	beqz	a3,510 <printint+0x16>
 50c:	0805c063          	bltz	a1,58c <printint+0x92>
  neg = 0;
 510:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 512:	fc040313          	addi	t1,s0,-64
  neg = 0;
 516:	869a                	mv	a3,t1
  i = 0;
 518:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 51a:	00000817          	auipc	a6,0x0
 51e:	4d680813          	addi	a6,a6,1238 # 9f0 <digits>
 522:	88be                	mv	a7,a5
 524:	0017851b          	addiw	a0,a5,1
 528:	87aa                	mv	a5,a0
 52a:	02c5f73b          	remuw	a4,a1,a2
 52e:	1702                	slli	a4,a4,0x20
 530:	9301                	srli	a4,a4,0x20
 532:	9742                	add	a4,a4,a6
 534:	00074703          	lbu	a4,0(a4)
 538:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 53c:	872e                	mv	a4,a1
 53e:	02c5d5bb          	divuw	a1,a1,a2
 542:	0685                	addi	a3,a3,1
 544:	fcc77fe3          	bgeu	a4,a2,522 <printint+0x28>
  if(neg)
 548:	000e0c63          	beqz	t3,560 <printint+0x66>
    buf[i++] = '-';
 54c:	fd050793          	addi	a5,a0,-48
 550:	00878533          	add	a0,a5,s0
 554:	02d00793          	li	a5,45
 558:	fef50823          	sb	a5,-16(a0)
 55c:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 560:	fff7899b          	addiw	s3,a5,-1
 564:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 568:	fff4c583          	lbu	a1,-1(s1)
 56c:	854a                	mv	a0,s2
 56e:	00000097          	auipc	ra,0x0
 572:	f6a080e7          	jalr	-150(ra) # 4d8 <putc>
  while(--i >= 0)
 576:	39fd                	addiw	s3,s3,-1
 578:	14fd                	addi	s1,s1,-1
 57a:	fe09d7e3          	bgez	s3,568 <printint+0x6e>
}
 57e:	70e2                	ld	ra,56(sp)
 580:	7442                	ld	s0,48(sp)
 582:	74a2                	ld	s1,40(sp)
 584:	7902                	ld	s2,32(sp)
 586:	69e2                	ld	s3,24(sp)
 588:	6121                	addi	sp,sp,64
 58a:	8082                	ret
    x = -xx;
 58c:	40b005bb          	negw	a1,a1
    neg = 1;
 590:	4e05                	li	t3,1
    x = -xx;
 592:	b741                	j	512 <printint+0x18>

0000000000000594 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 594:	715d                	addi	sp,sp,-80
 596:	e486                	sd	ra,72(sp)
 598:	e0a2                	sd	s0,64(sp)
 59a:	f84a                	sd	s2,48(sp)
 59c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 59e:	0005c903          	lbu	s2,0(a1)
 5a2:	1a090a63          	beqz	s2,756 <vprintf+0x1c2>
 5a6:	fc26                	sd	s1,56(sp)
 5a8:	f44e                	sd	s3,40(sp)
 5aa:	f052                	sd	s4,32(sp)
 5ac:	ec56                	sd	s5,24(sp)
 5ae:	e85a                	sd	s6,16(sp)
 5b0:	e45e                	sd	s7,8(sp)
 5b2:	8aaa                	mv	s5,a0
 5b4:	8bb2                	mv	s7,a2
 5b6:	00158493          	addi	s1,a1,1
  state = 0;
 5ba:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5bc:	02500a13          	li	s4,37
 5c0:	4b55                	li	s6,21
 5c2:	a839                	j	5e0 <vprintf+0x4c>
        putc(fd, c);
 5c4:	85ca                	mv	a1,s2
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	f10080e7          	jalr	-240(ra) # 4d8 <putc>
 5d0:	a019                	j	5d6 <vprintf+0x42>
    } else if(state == '%'){
 5d2:	01498d63          	beq	s3,s4,5ec <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5d6:	0485                	addi	s1,s1,1
 5d8:	fff4c903          	lbu	s2,-1(s1)
 5dc:	16090763          	beqz	s2,74a <vprintf+0x1b6>
    if(state == 0){
 5e0:	fe0999e3          	bnez	s3,5d2 <vprintf+0x3e>
      if(c == '%'){
 5e4:	ff4910e3          	bne	s2,s4,5c4 <vprintf+0x30>
        state = '%';
 5e8:	89d2                	mv	s3,s4
 5ea:	b7f5                	j	5d6 <vprintf+0x42>
      if(c == 'd'){
 5ec:	13490463          	beq	s2,s4,714 <vprintf+0x180>
 5f0:	f9d9079b          	addiw	a5,s2,-99
 5f4:	0ff7f793          	zext.b	a5,a5
 5f8:	12fb6763          	bltu	s6,a5,726 <vprintf+0x192>
 5fc:	f9d9079b          	addiw	a5,s2,-99
 600:	0ff7f713          	zext.b	a4,a5
 604:	12eb6163          	bltu	s6,a4,726 <vprintf+0x192>
 608:	00271793          	slli	a5,a4,0x2
 60c:	00000717          	auipc	a4,0x0
 610:	38c70713          	addi	a4,a4,908 # 998 <malloc+0x14e>
 614:	97ba                	add	a5,a5,a4
 616:	439c                	lw	a5,0(a5)
 618:	97ba                	add	a5,a5,a4
 61a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 61c:	008b8913          	addi	s2,s7,8
 620:	4685                	li	a3,1
 622:	4629                	li	a2,10
 624:	000ba583          	lw	a1,0(s7)
 628:	8556                	mv	a0,s5
 62a:	00000097          	auipc	ra,0x0
 62e:	ed0080e7          	jalr	-304(ra) # 4fa <printint>
 632:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 634:	4981                	li	s3,0
 636:	b745                	j	5d6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 638:	008b8913          	addi	s2,s7,8
 63c:	4681                	li	a3,0
 63e:	4629                	li	a2,10
 640:	000ba583          	lw	a1,0(s7)
 644:	8556                	mv	a0,s5
 646:	00000097          	auipc	ra,0x0
 64a:	eb4080e7          	jalr	-332(ra) # 4fa <printint>
 64e:	8bca                	mv	s7,s2
      state = 0;
 650:	4981                	li	s3,0
 652:	b751                	j	5d6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 654:	008b8913          	addi	s2,s7,8
 658:	4681                	li	a3,0
 65a:	4641                	li	a2,16
 65c:	000ba583          	lw	a1,0(s7)
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e98080e7          	jalr	-360(ra) # 4fa <printint>
 66a:	8bca                	mv	s7,s2
      state = 0;
 66c:	4981                	li	s3,0
 66e:	b7a5                	j	5d6 <vprintf+0x42>
 670:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 672:	008b8c13          	addi	s8,s7,8
 676:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 67a:	03000593          	li	a1,48
 67e:	8556                	mv	a0,s5
 680:	00000097          	auipc	ra,0x0
 684:	e58080e7          	jalr	-424(ra) # 4d8 <putc>
  putc(fd, 'x');
 688:	07800593          	li	a1,120
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	e4a080e7          	jalr	-438(ra) # 4d8 <putc>
 696:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 698:	00000b97          	auipc	s7,0x0
 69c:	358b8b93          	addi	s7,s7,856 # 9f0 <digits>
 6a0:	03c9d793          	srli	a5,s3,0x3c
 6a4:	97de                	add	a5,a5,s7
 6a6:	0007c583          	lbu	a1,0(a5)
 6aa:	8556                	mv	a0,s5
 6ac:	00000097          	auipc	ra,0x0
 6b0:	e2c080e7          	jalr	-468(ra) # 4d8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6b4:	0992                	slli	s3,s3,0x4
 6b6:	397d                	addiw	s2,s2,-1
 6b8:	fe0914e3          	bnez	s2,6a0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6bc:	8be2                	mv	s7,s8
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	6c02                	ld	s8,0(sp)
 6c2:	bf11                	j	5d6 <vprintf+0x42>
        s = va_arg(ap, char*);
 6c4:	008b8993          	addi	s3,s7,8
 6c8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6cc:	02090163          	beqz	s2,6ee <vprintf+0x15a>
        while(*s != 0){
 6d0:	00094583          	lbu	a1,0(s2)
 6d4:	c9a5                	beqz	a1,744 <vprintf+0x1b0>
          putc(fd, *s);
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	e00080e7          	jalr	-512(ra) # 4d8 <putc>
          s++;
 6e0:	0905                	addi	s2,s2,1
        while(*s != 0){
 6e2:	00094583          	lbu	a1,0(s2)
 6e6:	f9e5                	bnez	a1,6d6 <vprintf+0x142>
        s = va_arg(ap, char*);
 6e8:	8bce                	mv	s7,s3
      state = 0;
 6ea:	4981                	li	s3,0
 6ec:	b5ed                	j	5d6 <vprintf+0x42>
          s = "(null)";
 6ee:	00000917          	auipc	s2,0x0
 6f2:	2a290913          	addi	s2,s2,674 # 990 <malloc+0x146>
        while(*s != 0){
 6f6:	02800593          	li	a1,40
 6fa:	bff1                	j	6d6 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6fc:	008b8913          	addi	s2,s7,8
 700:	000bc583          	lbu	a1,0(s7)
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	dd2080e7          	jalr	-558(ra) # 4d8 <putc>
 70e:	8bca                	mv	s7,s2
      state = 0;
 710:	4981                	li	s3,0
 712:	b5d1                	j	5d6 <vprintf+0x42>
        putc(fd, c);
 714:	02500593          	li	a1,37
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	dbe080e7          	jalr	-578(ra) # 4d8 <putc>
      state = 0;
 722:	4981                	li	s3,0
 724:	bd4d                	j	5d6 <vprintf+0x42>
        putc(fd, '%');
 726:	02500593          	li	a1,37
 72a:	8556                	mv	a0,s5
 72c:	00000097          	auipc	ra,0x0
 730:	dac080e7          	jalr	-596(ra) # 4d8 <putc>
        putc(fd, c);
 734:	85ca                	mv	a1,s2
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	da0080e7          	jalr	-608(ra) # 4d8 <putc>
      state = 0;
 740:	4981                	li	s3,0
 742:	bd51                	j	5d6 <vprintf+0x42>
        s = va_arg(ap, char*);
 744:	8bce                	mv	s7,s3
      state = 0;
 746:	4981                	li	s3,0
 748:	b579                	j	5d6 <vprintf+0x42>
 74a:	74e2                	ld	s1,56(sp)
 74c:	79a2                	ld	s3,40(sp)
 74e:	7a02                	ld	s4,32(sp)
 750:	6ae2                	ld	s5,24(sp)
 752:	6b42                	ld	s6,16(sp)
 754:	6ba2                	ld	s7,8(sp)
    }
  }
}
 756:	60a6                	ld	ra,72(sp)
 758:	6406                	ld	s0,64(sp)
 75a:	7942                	ld	s2,48(sp)
 75c:	6161                	addi	sp,sp,80
 75e:	8082                	ret

0000000000000760 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 760:	715d                	addi	sp,sp,-80
 762:	ec06                	sd	ra,24(sp)
 764:	e822                	sd	s0,16(sp)
 766:	1000                	addi	s0,sp,32
 768:	e010                	sd	a2,0(s0)
 76a:	e414                	sd	a3,8(s0)
 76c:	e818                	sd	a4,16(s0)
 76e:	ec1c                	sd	a5,24(s0)
 770:	03043023          	sd	a6,32(s0)
 774:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 778:	8622                	mv	a2,s0
 77a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 77e:	00000097          	auipc	ra,0x0
 782:	e16080e7          	jalr	-490(ra) # 594 <vprintf>
}
 786:	60e2                	ld	ra,24(sp)
 788:	6442                	ld	s0,16(sp)
 78a:	6161                	addi	sp,sp,80
 78c:	8082                	ret

000000000000078e <printf>:

void
printf(const char *fmt, ...)
{
 78e:	711d                	addi	sp,sp,-96
 790:	ec06                	sd	ra,24(sp)
 792:	e822                	sd	s0,16(sp)
 794:	1000                	addi	s0,sp,32
 796:	e40c                	sd	a1,8(s0)
 798:	e810                	sd	a2,16(s0)
 79a:	ec14                	sd	a3,24(s0)
 79c:	f018                	sd	a4,32(s0)
 79e:	f41c                	sd	a5,40(s0)
 7a0:	03043823          	sd	a6,48(s0)
 7a4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7a8:	00840613          	addi	a2,s0,8
 7ac:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7b0:	85aa                	mv	a1,a0
 7b2:	4505                	li	a0,1
 7b4:	00000097          	auipc	ra,0x0
 7b8:	de0080e7          	jalr	-544(ra) # 594 <vprintf>
}
 7bc:	60e2                	ld	ra,24(sp)
 7be:	6442                	ld	s0,16(sp)
 7c0:	6125                	addi	sp,sp,96
 7c2:	8082                	ret

00000000000007c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c4:	1141                	addi	sp,sp,-16
 7c6:	e406                	sd	ra,8(sp)
 7c8:	e022                	sd	s0,0(sp)
 7ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7cc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d0:	00000797          	auipc	a5,0x0
 7d4:	6807b783          	ld	a5,1664(a5) # e50 <freep>
 7d8:	a02d                	j	802 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7da:	4618                	lw	a4,8(a2)
 7dc:	9f2d                	addw	a4,a4,a1
 7de:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e2:	6398                	ld	a4,0(a5)
 7e4:	6310                	ld	a2,0(a4)
 7e6:	a83d                	j	824 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7e8:	ff852703          	lw	a4,-8(a0)
 7ec:	9f31                	addw	a4,a4,a2
 7ee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7f0:	ff053683          	ld	a3,-16(a0)
 7f4:	a091                	j	838 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f6:	6398                	ld	a4,0(a5)
 7f8:	00e7e463          	bltu	a5,a4,800 <free+0x3c>
 7fc:	00e6ea63          	bltu	a3,a4,810 <free+0x4c>
{
 800:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 802:	fed7fae3          	bgeu	a5,a3,7f6 <free+0x32>
 806:	6398                	ld	a4,0(a5)
 808:	00e6e463          	bltu	a3,a4,810 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	fee7eae3          	bltu	a5,a4,800 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 810:	ff852583          	lw	a1,-8(a0)
 814:	6390                	ld	a2,0(a5)
 816:	02059813          	slli	a6,a1,0x20
 81a:	01c85713          	srli	a4,a6,0x1c
 81e:	9736                	add	a4,a4,a3
 820:	fae60de3          	beq	a2,a4,7da <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 824:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 828:	4790                	lw	a2,8(a5)
 82a:	02061593          	slli	a1,a2,0x20
 82e:	01c5d713          	srli	a4,a1,0x1c
 832:	973e                	add	a4,a4,a5
 834:	fae68ae3          	beq	a3,a4,7e8 <free+0x24>
    p->s.ptr = bp->s.ptr;
 838:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 83a:	00000717          	auipc	a4,0x0
 83e:	60f73b23          	sd	a5,1558(a4) # e50 <freep>
}
 842:	60a2                	ld	ra,8(sp)
 844:	6402                	ld	s0,0(sp)
 846:	0141                	addi	sp,sp,16
 848:	8082                	ret

000000000000084a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 84a:	7139                	addi	sp,sp,-64
 84c:	fc06                	sd	ra,56(sp)
 84e:	f822                	sd	s0,48(sp)
 850:	f04a                	sd	s2,32(sp)
 852:	ec4e                	sd	s3,24(sp)
 854:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 856:	02051993          	slli	s3,a0,0x20
 85a:	0209d993          	srli	s3,s3,0x20
 85e:	09bd                	addi	s3,s3,15
 860:	0049d993          	srli	s3,s3,0x4
 864:	2985                	addiw	s3,s3,1
 866:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 868:	00000517          	auipc	a0,0x0
 86c:	5e853503          	ld	a0,1512(a0) # e50 <freep>
 870:	c905                	beqz	a0,8a0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 872:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 874:	4798                	lw	a4,8(a5)
 876:	09377a63          	bgeu	a4,s3,90a <malloc+0xc0>
 87a:	f426                	sd	s1,40(sp)
 87c:	e852                	sd	s4,16(sp)
 87e:	e456                	sd	s5,8(sp)
 880:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 882:	8a4e                	mv	s4,s3
 884:	6705                	lui	a4,0x1
 886:	00e9f363          	bgeu	s3,a4,88c <malloc+0x42>
 88a:	6a05                	lui	s4,0x1
 88c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 890:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 894:	00000497          	auipc	s1,0x0
 898:	5bc48493          	addi	s1,s1,1468 # e50 <freep>
  if(p == (char*)-1)
 89c:	5afd                	li	s5,-1
 89e:	a089                	j	8e0 <malloc+0x96>
 8a0:	f426                	sd	s1,40(sp)
 8a2:	e852                	sd	s4,16(sp)
 8a4:	e456                	sd	s5,8(sp)
 8a6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8a8:	00000797          	auipc	a5,0x0
 8ac:	7b078793          	addi	a5,a5,1968 # 1058 <base>
 8b0:	00000717          	auipc	a4,0x0
 8b4:	5af73023          	sd	a5,1440(a4) # e50 <freep>
 8b8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ba:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8be:	b7d1                	j	882 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8c0:	6398                	ld	a4,0(a5)
 8c2:	e118                	sd	a4,0(a0)
 8c4:	a8b9                	j	922 <malloc+0xd8>
  hp->s.size = nu;
 8c6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ca:	0541                	addi	a0,a0,16
 8cc:	00000097          	auipc	ra,0x0
 8d0:	ef8080e7          	jalr	-264(ra) # 7c4 <free>
  return freep;
 8d4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8d6:	c135                	beqz	a0,93a <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8da:	4798                	lw	a4,8(a5)
 8dc:	03277363          	bgeu	a4,s2,902 <malloc+0xb8>
    if(p == freep)
 8e0:	6098                	ld	a4,0(s1)
 8e2:	853e                	mv	a0,a5
 8e4:	fef71ae3          	bne	a4,a5,8d8 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 8e8:	8552                	mv	a0,s4
 8ea:	00000097          	auipc	ra,0x0
 8ee:	bce080e7          	jalr	-1074(ra) # 4b8 <sbrk>
  if(p == (char*)-1)
 8f2:	fd551ae3          	bne	a0,s5,8c6 <malloc+0x7c>
        return 0;
 8f6:	4501                	li	a0,0
 8f8:	74a2                	ld	s1,40(sp)
 8fa:	6a42                	ld	s4,16(sp)
 8fc:	6aa2                	ld	s5,8(sp)
 8fe:	6b02                	ld	s6,0(sp)
 900:	a03d                	j	92e <malloc+0xe4>
 902:	74a2                	ld	s1,40(sp)
 904:	6a42                	ld	s4,16(sp)
 906:	6aa2                	ld	s5,8(sp)
 908:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 90a:	fae90be3          	beq	s2,a4,8c0 <malloc+0x76>
        p->s.size -= nunits;
 90e:	4137073b          	subw	a4,a4,s3
 912:	c798                	sw	a4,8(a5)
        p += p->s.size;
 914:	02071693          	slli	a3,a4,0x20
 918:	01c6d713          	srli	a4,a3,0x1c
 91c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 91e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 922:	00000717          	auipc	a4,0x0
 926:	52a73723          	sd	a0,1326(a4) # e50 <freep>
      return (void*)(p + 1);
 92a:	01078513          	addi	a0,a5,16
  }
}
 92e:	70e2                	ld	ra,56(sp)
 930:	7442                	ld	s0,48(sp)
 932:	7902                	ld	s2,32(sp)
 934:	69e2                	ld	s3,24(sp)
 936:	6121                	addi	sp,sp,64
 938:	8082                	ret
 93a:	74a2                	ld	s1,40(sp)
 93c:	6a42                	ld	s4,16(sp)
 93e:	6aa2                	ld	s5,8(sp)
 940:	6b02                	ld	s6,0(sp)
 942:	b7f5                	j	92e <malloc+0xe4>
