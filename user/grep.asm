
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	e06a                	sd	s10,0(sp)
 134:	1080                	addi	s0,sp,96
 136:	8aaa                	mv	s5,a0
 138:	8cae                	mv	s9,a1
  m = 0;
 13a:	4b01                	li	s6,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13c:	3ff00d13          	li	s10,1023
 140:	00001b97          	auipc	s7,0x1
 144:	eb0b8b93          	addi	s7,s7,-336 # ff0 <buf>
    while((q = strchr(p, '\n')) != 0){
 148:	49a9                	li	s3,10
        write(1, p, q+1 - p);
 14a:	4c05                	li	s8,1
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14c:	a099                	j	192 <grep+0x78>
      p = q+1;
 14e:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 152:	85ce                	mv	a1,s3
 154:	854a                	mv	a0,s2
 156:	00000097          	auipc	ra,0x0
 15a:	200080e7          	jalr	512(ra) # 356 <strchr>
 15e:	84aa                	mv	s1,a0
 160:	c51d                	beqz	a0,18e <grep+0x74>
      *q = 0;
 162:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 166:	85ca                	mv	a1,s2
 168:	8556                	mv	a0,s5
 16a:	00000097          	auipc	ra,0x0
 16e:	f62080e7          	jalr	-158(ra) # cc <match>
 172:	dd71                	beqz	a0,14e <grep+0x34>
        *q = '\n';
 174:	01348023          	sb	s3,0(s1)
        write(1, p, q+1 - p);
 178:	00148613          	addi	a2,s1,1
 17c:	4126063b          	subw	a2,a2,s2
 180:	85ca                	mv	a1,s2
 182:	8562                	mv	a0,s8
 184:	00000097          	auipc	ra,0x0
 188:	3ee080e7          	jalr	1006(ra) # 572 <write>
 18c:	b7c9                	j	14e <grep+0x34>
    if(m > 0){
 18e:	03604663          	bgtz	s6,1ba <grep+0xa0>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 192:	416d063b          	subw	a2,s10,s6
 196:	016b85b3          	add	a1,s7,s6
 19a:	8566                	mv	a0,s9
 19c:	00000097          	auipc	ra,0x0
 1a0:	3ce080e7          	jalr	974(ra) # 56a <read>
 1a4:	02a05a63          	blez	a0,1d8 <grep+0xbe>
    m += n;
 1a8:	00ab0a3b          	addw	s4,s6,a0
 1ac:	8b52                	mv	s6,s4
    buf[m] = '\0';
 1ae:	014b87b3          	add	a5,s7,s4
 1b2:	00078023          	sb	zero,0(a5)
    p = buf;
 1b6:	895e                	mv	s2,s7
    while((q = strchr(p, '\n')) != 0){
 1b8:	bf69                	j	152 <grep+0x38>
      m -= p - buf;
 1ba:	00001517          	auipc	a0,0x1
 1be:	e3650513          	addi	a0,a0,-458 # ff0 <buf>
 1c2:	40a907b3          	sub	a5,s2,a0
 1c6:	40fa063b          	subw	a2,s4,a5
 1ca:	8b32                	mv	s6,a2
      memmove(buf, p, m);
 1cc:	85ca                	mv	a1,s2
 1ce:	00000097          	auipc	ra,0x0
 1d2:	2ca080e7          	jalr	714(ra) # 498 <memmove>
 1d6:	bf75                	j	192 <grep+0x78>
}
 1d8:	60e6                	ld	ra,88(sp)
 1da:	6446                	ld	s0,80(sp)
 1dc:	64a6                	ld	s1,72(sp)
 1de:	6906                	ld	s2,64(sp)
 1e0:	79e2                	ld	s3,56(sp)
 1e2:	7a42                	ld	s4,48(sp)
 1e4:	7aa2                	ld	s5,40(sp)
 1e6:	7b02                	ld	s6,32(sp)
 1e8:	6be2                	ld	s7,24(sp)
 1ea:	6c42                	ld	s8,16(sp)
 1ec:	6ca2                	ld	s9,8(sp)
 1ee:	6d02                	ld	s10,0(sp)
 1f0:	6125                	addi	sp,sp,96
 1f2:	8082                	ret

00000000000001f4 <main>:
{
 1f4:	7179                	addi	sp,sp,-48
 1f6:	f406                	sd	ra,40(sp)
 1f8:	f022                	sd	s0,32(sp)
 1fa:	ec26                	sd	s1,24(sp)
 1fc:	e84a                	sd	s2,16(sp)
 1fe:	e44e                	sd	s3,8(sp)
 200:	e052                	sd	s4,0(sp)
 202:	1800                	addi	s0,sp,48
  if(argc <= 1){
 204:	4785                	li	a5,1
 206:	04a7de63          	bge	a5,a0,262 <main+0x6e>
  pattern = argv[1];
 20a:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 20e:	4789                	li	a5,2
 210:	06a7d763          	bge	a5,a0,27e <main+0x8a>
 214:	01058913          	addi	s2,a1,16
 218:	ffd5099b          	addiw	s3,a0,-3
 21c:	02099793          	slli	a5,s3,0x20
 220:	01d7d993          	srli	s3,a5,0x1d
 224:	05e1                	addi	a1,a1,24
 226:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 228:	4581                	li	a1,0
 22a:	00093503          	ld	a0,0(s2)
 22e:	00000097          	auipc	ra,0x0
 232:	364080e7          	jalr	868(ra) # 592 <open>
 236:	84aa                	mv	s1,a0
 238:	04054e63          	bltz	a0,294 <main+0xa0>
    grep(pattern, fd);
 23c:	85aa                	mv	a1,a0
 23e:	8552                	mv	a0,s4
 240:	00000097          	auipc	ra,0x0
 244:	eda080e7          	jalr	-294(ra) # 11a <grep>
    close(fd);
 248:	8526                	mv	a0,s1
 24a:	00000097          	auipc	ra,0x0
 24e:	330080e7          	jalr	816(ra) # 57a <close>
  for(i = 2; i < argc; i++){
 252:	0921                	addi	s2,s2,8
 254:	fd391ae3          	bne	s2,s3,228 <main+0x34>
  exit(0);
 258:	4501                	li	a0,0
 25a:	00000097          	auipc	ra,0x0
 25e:	2f8080e7          	jalr	760(ra) # 552 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 262:	00001597          	auipc	a1,0x1
 266:	80658593          	addi	a1,a1,-2042 # a68 <malloc+0xfc>
 26a:	4509                	li	a0,2
 26c:	00000097          	auipc	ra,0x0
 270:	616080e7          	jalr	1558(ra) # 882 <fprintf>
    exit(1);
 274:	4505                	li	a0,1
 276:	00000097          	auipc	ra,0x0
 27a:	2dc080e7          	jalr	732(ra) # 552 <exit>
    grep(pattern, 0);
 27e:	4581                	li	a1,0
 280:	8552                	mv	a0,s4
 282:	00000097          	auipc	ra,0x0
 286:	e98080e7          	jalr	-360(ra) # 11a <grep>
    exit(0);
 28a:	4501                	li	a0,0
 28c:	00000097          	auipc	ra,0x0
 290:	2c6080e7          	jalr	710(ra) # 552 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 294:	00093583          	ld	a1,0(s2)
 298:	00000517          	auipc	a0,0x0
 29c:	7f050513          	addi	a0,a0,2032 # a88 <malloc+0x11c>
 2a0:	00000097          	auipc	ra,0x0
 2a4:	610080e7          	jalr	1552(ra) # 8b0 <printf>
      exit(1);
 2a8:	4505                	li	a0,1
 2aa:	00000097          	auipc	ra,0x0
 2ae:	2a8080e7          	jalr	680(ra) # 552 <exit>

00000000000002b2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ba:	87aa                	mv	a5,a0
 2bc:	0585                	addi	a1,a1,1
 2be:	0785                	addi	a5,a5,1
 2c0:	fff5c703          	lbu	a4,-1(a1)
 2c4:	fee78fa3          	sb	a4,-1(a5)
 2c8:	fb75                	bnez	a4,2bc <strcpy+0xa>
    ;
  return os;
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret

00000000000002d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	cb91                	beqz	a5,2f2 <strcmp+0x20>
 2e0:	0005c703          	lbu	a4,0(a1)
 2e4:	00f71763          	bne	a4,a5,2f2 <strcmp+0x20>
    p++, q++;
 2e8:	0505                	addi	a0,a0,1
 2ea:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	fbe5                	bnez	a5,2e0 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2f2:	0005c503          	lbu	a0,0(a1)
}
 2f6:	40a7853b          	subw	a0,a5,a0
 2fa:	60a2                	ld	ra,8(sp)
 2fc:	6402                	ld	s0,0(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret

0000000000000302 <strlen>:

uint
strlen(const char *s)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 30a:	00054783          	lbu	a5,0(a0)
 30e:	cf99                	beqz	a5,32c <strlen+0x2a>
 310:	0505                	addi	a0,a0,1
 312:	87aa                	mv	a5,a0
 314:	86be                	mv	a3,a5
 316:	0785                	addi	a5,a5,1
 318:	fff7c703          	lbu	a4,-1(a5)
 31c:	ff65                	bnez	a4,314 <strlen+0x12>
 31e:	40a6853b          	subw	a0,a3,a0
 322:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret
  for(n = 0; s[n]; n++)
 32c:	4501                	li	a0,0
 32e:	bfdd                	j	324 <strlen+0x22>

0000000000000330 <memset>:

void*
memset(void *dst, int c, uint n)
{
 330:	1141                	addi	sp,sp,-16
 332:	e406                	sd	ra,8(sp)
 334:	e022                	sd	s0,0(sp)
 336:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 338:	ca19                	beqz	a2,34e <memset+0x1e>
 33a:	87aa                	mv	a5,a0
 33c:	1602                	slli	a2,a2,0x20
 33e:	9201                	srli	a2,a2,0x20
 340:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 344:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 348:	0785                	addi	a5,a5,1
 34a:	fee79de3          	bne	a5,a4,344 <memset+0x14>
  }
  return dst;
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <strchr>:

char*
strchr(const char *s, char c)
{
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 35e:	00054783          	lbu	a5,0(a0)
 362:	cf81                	beqz	a5,37a <strchr+0x24>
    if(*s == c)
 364:	00f58763          	beq	a1,a5,372 <strchr+0x1c>
  for(; *s; s++)
 368:	0505                	addi	a0,a0,1
 36a:	00054783          	lbu	a5,0(a0)
 36e:	fbfd                	bnez	a5,364 <strchr+0xe>
      return (char*)s;
  return 0;
 370:	4501                	li	a0,0
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret
  return 0;
 37a:	4501                	li	a0,0
 37c:	bfdd                	j	372 <strchr+0x1c>

000000000000037e <gets>:

char*
gets(char *buf, int max)
{
 37e:	7159                	addi	sp,sp,-112
 380:	f486                	sd	ra,104(sp)
 382:	f0a2                	sd	s0,96(sp)
 384:	eca6                	sd	s1,88(sp)
 386:	e8ca                	sd	s2,80(sp)
 388:	e4ce                	sd	s3,72(sp)
 38a:	e0d2                	sd	s4,64(sp)
 38c:	fc56                	sd	s5,56(sp)
 38e:	f85a                	sd	s6,48(sp)
 390:	f45e                	sd	s7,40(sp)
 392:	f062                	sd	s8,32(sp)
 394:	ec66                	sd	s9,24(sp)
 396:	e86a                	sd	s10,16(sp)
 398:	1880                	addi	s0,sp,112
 39a:	8caa                	mv	s9,a0
 39c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39e:	892a                	mv	s2,a0
 3a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3a2:	f9f40b13          	addi	s6,s0,-97
 3a6:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3a8:	4ba9                	li	s7,10
 3aa:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 3ac:	8d26                	mv	s10,s1
 3ae:	0014899b          	addiw	s3,s1,1
 3b2:	84ce                	mv	s1,s3
 3b4:	0349d763          	bge	s3,s4,3e2 <gets+0x64>
    cc = read(0, &c, 1);
 3b8:	8656                	mv	a2,s5
 3ba:	85da                	mv	a1,s6
 3bc:	4501                	li	a0,0
 3be:	00000097          	auipc	ra,0x0
 3c2:	1ac080e7          	jalr	428(ra) # 56a <read>
    if(cc < 1)
 3c6:	00a05e63          	blez	a0,3e2 <gets+0x64>
    buf[i++] = c;
 3ca:	f9f44783          	lbu	a5,-97(s0)
 3ce:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3d2:	01778763          	beq	a5,s7,3e0 <gets+0x62>
 3d6:	0905                	addi	s2,s2,1
 3d8:	fd879ae3          	bne	a5,s8,3ac <gets+0x2e>
    buf[i++] = c;
 3dc:	8d4e                	mv	s10,s3
 3de:	a011                	j	3e2 <gets+0x64>
 3e0:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 3e2:	9d66                	add	s10,s10,s9
 3e4:	000d0023          	sb	zero,0(s10)
  return buf;
}
 3e8:	8566                	mv	a0,s9
 3ea:	70a6                	ld	ra,104(sp)
 3ec:	7406                	ld	s0,96(sp)
 3ee:	64e6                	ld	s1,88(sp)
 3f0:	6946                	ld	s2,80(sp)
 3f2:	69a6                	ld	s3,72(sp)
 3f4:	6a06                	ld	s4,64(sp)
 3f6:	7ae2                	ld	s5,56(sp)
 3f8:	7b42                	ld	s6,48(sp)
 3fa:	7ba2                	ld	s7,40(sp)
 3fc:	7c02                	ld	s8,32(sp)
 3fe:	6ce2                	ld	s9,24(sp)
 400:	6d42                	ld	s10,16(sp)
 402:	6165                	addi	sp,sp,112
 404:	8082                	ret

0000000000000406 <stat>:

int
stat(const char *n, struct stat *st)
{
 406:	1101                	addi	sp,sp,-32
 408:	ec06                	sd	ra,24(sp)
 40a:	e822                	sd	s0,16(sp)
 40c:	e04a                	sd	s2,0(sp)
 40e:	1000                	addi	s0,sp,32
 410:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 412:	4581                	li	a1,0
 414:	00000097          	auipc	ra,0x0
 418:	17e080e7          	jalr	382(ra) # 592 <open>
  if(fd < 0)
 41c:	02054663          	bltz	a0,448 <stat+0x42>
 420:	e426                	sd	s1,8(sp)
 422:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 424:	85ca                	mv	a1,s2
 426:	00000097          	auipc	ra,0x0
 42a:	184080e7          	jalr	388(ra) # 5aa <fstat>
 42e:	892a                	mv	s2,a0
  close(fd);
 430:	8526                	mv	a0,s1
 432:	00000097          	auipc	ra,0x0
 436:	148080e7          	jalr	328(ra) # 57a <close>
  return r;
 43a:	64a2                	ld	s1,8(sp)
}
 43c:	854a                	mv	a0,s2
 43e:	60e2                	ld	ra,24(sp)
 440:	6442                	ld	s0,16(sp)
 442:	6902                	ld	s2,0(sp)
 444:	6105                	addi	sp,sp,32
 446:	8082                	ret
    return -1;
 448:	597d                	li	s2,-1
 44a:	bfcd                	j	43c <stat+0x36>

000000000000044c <atoi>:

int
atoi(const char *s)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e406                	sd	ra,8(sp)
 450:	e022                	sd	s0,0(sp)
 452:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 454:	00054683          	lbu	a3,0(a0)
 458:	fd06879b          	addiw	a5,a3,-48
 45c:	0ff7f793          	zext.b	a5,a5
 460:	4625                	li	a2,9
 462:	02f66963          	bltu	a2,a5,494 <atoi+0x48>
 466:	872a                	mv	a4,a0
  n = 0;
 468:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 46a:	0705                	addi	a4,a4,1
 46c:	0025179b          	slliw	a5,a0,0x2
 470:	9fa9                	addw	a5,a5,a0
 472:	0017979b          	slliw	a5,a5,0x1
 476:	9fb5                	addw	a5,a5,a3
 478:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 47c:	00074683          	lbu	a3,0(a4)
 480:	fd06879b          	addiw	a5,a3,-48
 484:	0ff7f793          	zext.b	a5,a5
 488:	fef671e3          	bgeu	a2,a5,46a <atoi+0x1e>
  return n;
}
 48c:	60a2                	ld	ra,8(sp)
 48e:	6402                	ld	s0,0(sp)
 490:	0141                	addi	sp,sp,16
 492:	8082                	ret
  n = 0;
 494:	4501                	li	a0,0
 496:	bfdd                	j	48c <atoi+0x40>

0000000000000498 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e406                	sd	ra,8(sp)
 49c:	e022                	sd	s0,0(sp)
 49e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4a0:	02b57563          	bgeu	a0,a1,4ca <memmove+0x32>
    while(n-- > 0)
 4a4:	00c05f63          	blez	a2,4c2 <memmove+0x2a>
 4a8:	1602                	slli	a2,a2,0x20
 4aa:	9201                	srli	a2,a2,0x20
 4ac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4b0:	872a                	mv	a4,a0
      *dst++ = *src++;
 4b2:	0585                	addi	a1,a1,1
 4b4:	0705                	addi	a4,a4,1
 4b6:	fff5c683          	lbu	a3,-1(a1)
 4ba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4be:	fee79ae3          	bne	a5,a4,4b2 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4c2:	60a2                	ld	ra,8(sp)
 4c4:	6402                	ld	s0,0(sp)
 4c6:	0141                	addi	sp,sp,16
 4c8:	8082                	ret
    dst += n;
 4ca:	00c50733          	add	a4,a0,a2
    src += n;
 4ce:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4d0:	fec059e3          	blez	a2,4c2 <memmove+0x2a>
 4d4:	fff6079b          	addiw	a5,a2,-1
 4d8:	1782                	slli	a5,a5,0x20
 4da:	9381                	srli	a5,a5,0x20
 4dc:	fff7c793          	not	a5,a5
 4e0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4e2:	15fd                	addi	a1,a1,-1
 4e4:	177d                	addi	a4,a4,-1
 4e6:	0005c683          	lbu	a3,0(a1)
 4ea:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ee:	fef71ae3          	bne	a4,a5,4e2 <memmove+0x4a>
 4f2:	bfc1                	j	4c2 <memmove+0x2a>

00000000000004f4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e406                	sd	ra,8(sp)
 4f8:	e022                	sd	s0,0(sp)
 4fa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4fc:	ca0d                	beqz	a2,52e <memcmp+0x3a>
 4fe:	fff6069b          	addiw	a3,a2,-1
 502:	1682                	slli	a3,a3,0x20
 504:	9281                	srli	a3,a3,0x20
 506:	0685                	addi	a3,a3,1
 508:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 50a:	00054783          	lbu	a5,0(a0)
 50e:	0005c703          	lbu	a4,0(a1)
 512:	00e79863          	bne	a5,a4,522 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 516:	0505                	addi	a0,a0,1
    p2++;
 518:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 51a:	fed518e3          	bne	a0,a3,50a <memcmp+0x16>
  }
  return 0;
 51e:	4501                	li	a0,0
 520:	a019                	j	526 <memcmp+0x32>
      return *p1 - *p2;
 522:	40e7853b          	subw	a0,a5,a4
}
 526:	60a2                	ld	ra,8(sp)
 528:	6402                	ld	s0,0(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
  return 0;
 52e:	4501                	li	a0,0
 530:	bfdd                	j	526 <memcmp+0x32>

0000000000000532 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 532:	1141                	addi	sp,sp,-16
 534:	e406                	sd	ra,8(sp)
 536:	e022                	sd	s0,0(sp)
 538:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 53a:	00000097          	auipc	ra,0x0
 53e:	f5e080e7          	jalr	-162(ra) # 498 <memmove>
}
 542:	60a2                	ld	ra,8(sp)
 544:	6402                	ld	s0,0(sp)
 546:	0141                	addi	sp,sp,16
 548:	8082                	ret

000000000000054a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 54a:	4885                	li	a7,1
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <exit>:
.global exit
exit:
 li a7, SYS_exit
 552:	4889                	li	a7,2
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <wait>:
.global wait
wait:
 li a7, SYS_wait
 55a:	488d                	li	a7,3
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 562:	4891                	li	a7,4
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <read>:
.global read
read:
 li a7, SYS_read
 56a:	4895                	li	a7,5
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <write>:
.global write
write:
 li a7, SYS_write
 572:	48c1                	li	a7,16
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <close>:
.global close
close:
 li a7, SYS_close
 57a:	48d5                	li	a7,21
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <kill>:
.global kill
kill:
 li a7, SYS_kill
 582:	4899                	li	a7,6
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <exec>:
.global exec
exec:
 li a7, SYS_exec
 58a:	489d                	li	a7,7
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <open>:
.global open
open:
 li a7, SYS_open
 592:	48bd                	li	a7,15
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 59a:	48c5                	li	a7,17
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5a2:	48c9                	li	a7,18
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5aa:	48a1                	li	a7,8
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <link>:
.global link
link:
 li a7, SYS_link
 5b2:	48cd                	li	a7,19
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5ba:	48d1                	li	a7,20
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5c2:	48a5                	li	a7,9
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ca:	48a9                	li	a7,10
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5d2:	48ad                	li	a7,11
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5da:	48b1                	li	a7,12
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5e2:	48b5                	li	a7,13
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ea:	48b9                	li	a7,14
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <trace>:
.global trace
trace:
 li a7, SYS_trace
 5f2:	48d9                	li	a7,22
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5fa:	1101                	addi	sp,sp,-32
 5fc:	ec06                	sd	ra,24(sp)
 5fe:	e822                	sd	s0,16(sp)
 600:	1000                	addi	s0,sp,32
 602:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 606:	4605                	li	a2,1
 608:	fef40593          	addi	a1,s0,-17
 60c:	00000097          	auipc	ra,0x0
 610:	f66080e7          	jalr	-154(ra) # 572 <write>
}
 614:	60e2                	ld	ra,24(sp)
 616:	6442                	ld	s0,16(sp)
 618:	6105                	addi	sp,sp,32
 61a:	8082                	ret

000000000000061c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 61c:	7139                	addi	sp,sp,-64
 61e:	fc06                	sd	ra,56(sp)
 620:	f822                	sd	s0,48(sp)
 622:	f426                	sd	s1,40(sp)
 624:	f04a                	sd	s2,32(sp)
 626:	ec4e                	sd	s3,24(sp)
 628:	0080                	addi	s0,sp,64
 62a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 62c:	c299                	beqz	a3,632 <printint+0x16>
 62e:	0805c063          	bltz	a1,6ae <printint+0x92>
  neg = 0;
 632:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 634:	fc040313          	addi	t1,s0,-64
  neg = 0;
 638:	869a                	mv	a3,t1
  i = 0;
 63a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 63c:	00000817          	auipc	a6,0x0
 640:	4c480813          	addi	a6,a6,1220 # b00 <digits>
 644:	88be                	mv	a7,a5
 646:	0017851b          	addiw	a0,a5,1
 64a:	87aa                	mv	a5,a0
 64c:	02c5f73b          	remuw	a4,a1,a2
 650:	1702                	slli	a4,a4,0x20
 652:	9301                	srli	a4,a4,0x20
 654:	9742                	add	a4,a4,a6
 656:	00074703          	lbu	a4,0(a4)
 65a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 65e:	872e                	mv	a4,a1
 660:	02c5d5bb          	divuw	a1,a1,a2
 664:	0685                	addi	a3,a3,1
 666:	fcc77fe3          	bgeu	a4,a2,644 <printint+0x28>
  if(neg)
 66a:	000e0c63          	beqz	t3,682 <printint+0x66>
    buf[i++] = '-';
 66e:	fd050793          	addi	a5,a0,-48
 672:	00878533          	add	a0,a5,s0
 676:	02d00793          	li	a5,45
 67a:	fef50823          	sb	a5,-16(a0)
 67e:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 682:	fff7899b          	addiw	s3,a5,-1
 686:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 68a:	fff4c583          	lbu	a1,-1(s1)
 68e:	854a                	mv	a0,s2
 690:	00000097          	auipc	ra,0x0
 694:	f6a080e7          	jalr	-150(ra) # 5fa <putc>
  while(--i >= 0)
 698:	39fd                	addiw	s3,s3,-1
 69a:	14fd                	addi	s1,s1,-1
 69c:	fe09d7e3          	bgez	s3,68a <printint+0x6e>
}
 6a0:	70e2                	ld	ra,56(sp)
 6a2:	7442                	ld	s0,48(sp)
 6a4:	74a2                	ld	s1,40(sp)
 6a6:	7902                	ld	s2,32(sp)
 6a8:	69e2                	ld	s3,24(sp)
 6aa:	6121                	addi	sp,sp,64
 6ac:	8082                	ret
    x = -xx;
 6ae:	40b005bb          	negw	a1,a1
    neg = 1;
 6b2:	4e05                	li	t3,1
    x = -xx;
 6b4:	b741                	j	634 <printint+0x18>

00000000000006b6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6b6:	715d                	addi	sp,sp,-80
 6b8:	e486                	sd	ra,72(sp)
 6ba:	e0a2                	sd	s0,64(sp)
 6bc:	f84a                	sd	s2,48(sp)
 6be:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c0:	0005c903          	lbu	s2,0(a1)
 6c4:	1a090a63          	beqz	s2,878 <vprintf+0x1c2>
 6c8:	fc26                	sd	s1,56(sp)
 6ca:	f44e                	sd	s3,40(sp)
 6cc:	f052                	sd	s4,32(sp)
 6ce:	ec56                	sd	s5,24(sp)
 6d0:	e85a                	sd	s6,16(sp)
 6d2:	e45e                	sd	s7,8(sp)
 6d4:	8aaa                	mv	s5,a0
 6d6:	8bb2                	mv	s7,a2
 6d8:	00158493          	addi	s1,a1,1
  state = 0;
 6dc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6de:	02500a13          	li	s4,37
 6e2:	4b55                	li	s6,21
 6e4:	a839                	j	702 <vprintf+0x4c>
        putc(fd, c);
 6e6:	85ca                	mv	a1,s2
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	f10080e7          	jalr	-240(ra) # 5fa <putc>
 6f2:	a019                	j	6f8 <vprintf+0x42>
    } else if(state == '%'){
 6f4:	01498d63          	beq	s3,s4,70e <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 6f8:	0485                	addi	s1,s1,1
 6fa:	fff4c903          	lbu	s2,-1(s1)
 6fe:	16090763          	beqz	s2,86c <vprintf+0x1b6>
    if(state == 0){
 702:	fe0999e3          	bnez	s3,6f4 <vprintf+0x3e>
      if(c == '%'){
 706:	ff4910e3          	bne	s2,s4,6e6 <vprintf+0x30>
        state = '%';
 70a:	89d2                	mv	s3,s4
 70c:	b7f5                	j	6f8 <vprintf+0x42>
      if(c == 'd'){
 70e:	13490463          	beq	s2,s4,836 <vprintf+0x180>
 712:	f9d9079b          	addiw	a5,s2,-99
 716:	0ff7f793          	zext.b	a5,a5
 71a:	12fb6763          	bltu	s6,a5,848 <vprintf+0x192>
 71e:	f9d9079b          	addiw	a5,s2,-99
 722:	0ff7f713          	zext.b	a4,a5
 726:	12eb6163          	bltu	s6,a4,848 <vprintf+0x192>
 72a:	00271793          	slli	a5,a4,0x2
 72e:	00000717          	auipc	a4,0x0
 732:	37a70713          	addi	a4,a4,890 # aa8 <malloc+0x13c>
 736:	97ba                	add	a5,a5,a4
 738:	439c                	lw	a5,0(a5)
 73a:	97ba                	add	a5,a5,a4
 73c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 73e:	008b8913          	addi	s2,s7,8
 742:	4685                	li	a3,1
 744:	4629                	li	a2,10
 746:	000ba583          	lw	a1,0(s7)
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	ed0080e7          	jalr	-304(ra) # 61c <printint>
 754:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 756:	4981                	li	s3,0
 758:	b745                	j	6f8 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75a:	008b8913          	addi	s2,s7,8
 75e:	4681                	li	a3,0
 760:	4629                	li	a2,10
 762:	000ba583          	lw	a1,0(s7)
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	eb4080e7          	jalr	-332(ra) # 61c <printint>
 770:	8bca                	mv	s7,s2
      state = 0;
 772:	4981                	li	s3,0
 774:	b751                	j	6f8 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 776:	008b8913          	addi	s2,s7,8
 77a:	4681                	li	a3,0
 77c:	4641                	li	a2,16
 77e:	000ba583          	lw	a1,0(s7)
 782:	8556                	mv	a0,s5
 784:	00000097          	auipc	ra,0x0
 788:	e98080e7          	jalr	-360(ra) # 61c <printint>
 78c:	8bca                	mv	s7,s2
      state = 0;
 78e:	4981                	li	s3,0
 790:	b7a5                	j	6f8 <vprintf+0x42>
 792:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 794:	008b8c13          	addi	s8,s7,8
 798:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 79c:	03000593          	li	a1,48
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e58080e7          	jalr	-424(ra) # 5fa <putc>
  putc(fd, 'x');
 7aa:	07800593          	li	a1,120
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e4a080e7          	jalr	-438(ra) # 5fa <putc>
 7b8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ba:	00000b97          	auipc	s7,0x0
 7be:	346b8b93          	addi	s7,s7,838 # b00 <digits>
 7c2:	03c9d793          	srli	a5,s3,0x3c
 7c6:	97de                	add	a5,a5,s7
 7c8:	0007c583          	lbu	a1,0(a5)
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	e2c080e7          	jalr	-468(ra) # 5fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d6:	0992                	slli	s3,s3,0x4
 7d8:	397d                	addiw	s2,s2,-1
 7da:	fe0914e3          	bnez	s2,7c2 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 7de:	8be2                	mv	s7,s8
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	6c02                	ld	s8,0(sp)
 7e4:	bf11                	j	6f8 <vprintf+0x42>
        s = va_arg(ap, char*);
 7e6:	008b8993          	addi	s3,s7,8
 7ea:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7ee:	02090163          	beqz	s2,810 <vprintf+0x15a>
        while(*s != 0){
 7f2:	00094583          	lbu	a1,0(s2)
 7f6:	c9a5                	beqz	a1,866 <vprintf+0x1b0>
          putc(fd, *s);
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e00080e7          	jalr	-512(ra) # 5fa <putc>
          s++;
 802:	0905                	addi	s2,s2,1
        while(*s != 0){
 804:	00094583          	lbu	a1,0(s2)
 808:	f9e5                	bnez	a1,7f8 <vprintf+0x142>
        s = va_arg(ap, char*);
 80a:	8bce                	mv	s7,s3
      state = 0;
 80c:	4981                	li	s3,0
 80e:	b5ed                	j	6f8 <vprintf+0x42>
          s = "(null)";
 810:	00000917          	auipc	s2,0x0
 814:	29090913          	addi	s2,s2,656 # aa0 <malloc+0x134>
        while(*s != 0){
 818:	02800593          	li	a1,40
 81c:	bff1                	j	7f8 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 81e:	008b8913          	addi	s2,s7,8
 822:	000bc583          	lbu	a1,0(s7)
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	dd2080e7          	jalr	-558(ra) # 5fa <putc>
 830:	8bca                	mv	s7,s2
      state = 0;
 832:	4981                	li	s3,0
 834:	b5d1                	j	6f8 <vprintf+0x42>
        putc(fd, c);
 836:	02500593          	li	a1,37
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	dbe080e7          	jalr	-578(ra) # 5fa <putc>
      state = 0;
 844:	4981                	li	s3,0
 846:	bd4d                	j	6f8 <vprintf+0x42>
        putc(fd, '%');
 848:	02500593          	li	a1,37
 84c:	8556                	mv	a0,s5
 84e:	00000097          	auipc	ra,0x0
 852:	dac080e7          	jalr	-596(ra) # 5fa <putc>
        putc(fd, c);
 856:	85ca                	mv	a1,s2
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	da0080e7          	jalr	-608(ra) # 5fa <putc>
      state = 0;
 862:	4981                	li	s3,0
 864:	bd51                	j	6f8 <vprintf+0x42>
        s = va_arg(ap, char*);
 866:	8bce                	mv	s7,s3
      state = 0;
 868:	4981                	li	s3,0
 86a:	b579                	j	6f8 <vprintf+0x42>
 86c:	74e2                	ld	s1,56(sp)
 86e:	79a2                	ld	s3,40(sp)
 870:	7a02                	ld	s4,32(sp)
 872:	6ae2                	ld	s5,24(sp)
 874:	6b42                	ld	s6,16(sp)
 876:	6ba2                	ld	s7,8(sp)
    }
  }
}
 878:	60a6                	ld	ra,72(sp)
 87a:	6406                	ld	s0,64(sp)
 87c:	7942                	ld	s2,48(sp)
 87e:	6161                	addi	sp,sp,80
 880:	8082                	ret

0000000000000882 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 882:	715d                	addi	sp,sp,-80
 884:	ec06                	sd	ra,24(sp)
 886:	e822                	sd	s0,16(sp)
 888:	1000                	addi	s0,sp,32
 88a:	e010                	sd	a2,0(s0)
 88c:	e414                	sd	a3,8(s0)
 88e:	e818                	sd	a4,16(s0)
 890:	ec1c                	sd	a5,24(s0)
 892:	03043023          	sd	a6,32(s0)
 896:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89a:	8622                	mv	a2,s0
 89c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a0:	00000097          	auipc	ra,0x0
 8a4:	e16080e7          	jalr	-490(ra) # 6b6 <vprintf>
}
 8a8:	60e2                	ld	ra,24(sp)
 8aa:	6442                	ld	s0,16(sp)
 8ac:	6161                	addi	sp,sp,80
 8ae:	8082                	ret

00000000000008b0 <printf>:

void
printf(const char *fmt, ...)
{
 8b0:	711d                	addi	sp,sp,-96
 8b2:	ec06                	sd	ra,24(sp)
 8b4:	e822                	sd	s0,16(sp)
 8b6:	1000                	addi	s0,sp,32
 8b8:	e40c                	sd	a1,8(s0)
 8ba:	e810                	sd	a2,16(s0)
 8bc:	ec14                	sd	a3,24(s0)
 8be:	f018                	sd	a4,32(s0)
 8c0:	f41c                	sd	a5,40(s0)
 8c2:	03043823          	sd	a6,48(s0)
 8c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	00840613          	addi	a2,s0,8
 8ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d2:	85aa                	mv	a1,a0
 8d4:	4505                	li	a0,1
 8d6:	00000097          	auipc	ra,0x0
 8da:	de0080e7          	jalr	-544(ra) # 6b6 <vprintf>
}
 8de:	60e2                	ld	ra,24(sp)
 8e0:	6442                	ld	s0,16(sp)
 8e2:	6125                	addi	sp,sp,96
 8e4:	8082                	ret

00000000000008e6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e6:	1141                	addi	sp,sp,-16
 8e8:	e406                	sd	ra,8(sp)
 8ea:	e022                	sd	s0,0(sp)
 8ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f2:	00000797          	auipc	a5,0x0
 8f6:	6f67b783          	ld	a5,1782(a5) # fe8 <freep>
 8fa:	a02d                	j	924 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fc:	4618                	lw	a4,8(a2)
 8fe:	9f2d                	addw	a4,a4,a1
 900:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 904:	6398                	ld	a4,0(a5)
 906:	6310                	ld	a2,0(a4)
 908:	a83d                	j	946 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 90a:	ff852703          	lw	a4,-8(a0)
 90e:	9f31                	addw	a4,a4,a2
 910:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 912:	ff053683          	ld	a3,-16(a0)
 916:	a091                	j	95a <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 918:	6398                	ld	a4,0(a5)
 91a:	00e7e463          	bltu	a5,a4,922 <free+0x3c>
 91e:	00e6ea63          	bltu	a3,a4,932 <free+0x4c>
{
 922:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 924:	fed7fae3          	bgeu	a5,a3,918 <free+0x32>
 928:	6398                	ld	a4,0(a5)
 92a:	00e6e463          	bltu	a3,a4,932 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92e:	fee7eae3          	bltu	a5,a4,922 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 932:	ff852583          	lw	a1,-8(a0)
 936:	6390                	ld	a2,0(a5)
 938:	02059813          	slli	a6,a1,0x20
 93c:	01c85713          	srli	a4,a6,0x1c
 940:	9736                	add	a4,a4,a3
 942:	fae60de3          	beq	a2,a4,8fc <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 946:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 94a:	4790                	lw	a2,8(a5)
 94c:	02061593          	slli	a1,a2,0x20
 950:	01c5d713          	srli	a4,a1,0x1c
 954:	973e                	add	a4,a4,a5
 956:	fae68ae3          	beq	a3,a4,90a <free+0x24>
    p->s.ptr = bp->s.ptr;
 95a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 95c:	00000717          	auipc	a4,0x0
 960:	68f73623          	sd	a5,1676(a4) # fe8 <freep>
}
 964:	60a2                	ld	ra,8(sp)
 966:	6402                	ld	s0,0(sp)
 968:	0141                	addi	sp,sp,16
 96a:	8082                	ret

000000000000096c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 96c:	7139                	addi	sp,sp,-64
 96e:	fc06                	sd	ra,56(sp)
 970:	f822                	sd	s0,48(sp)
 972:	f04a                	sd	s2,32(sp)
 974:	ec4e                	sd	s3,24(sp)
 976:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 978:	02051993          	slli	s3,a0,0x20
 97c:	0209d993          	srli	s3,s3,0x20
 980:	09bd                	addi	s3,s3,15
 982:	0049d993          	srli	s3,s3,0x4
 986:	2985                	addiw	s3,s3,1
 988:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 98a:	00000517          	auipc	a0,0x0
 98e:	65e53503          	ld	a0,1630(a0) # fe8 <freep>
 992:	c905                	beqz	a0,9c2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 994:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 996:	4798                	lw	a4,8(a5)
 998:	09377a63          	bgeu	a4,s3,a2c <malloc+0xc0>
 99c:	f426                	sd	s1,40(sp)
 99e:	e852                	sd	s4,16(sp)
 9a0:	e456                	sd	s5,8(sp)
 9a2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9a4:	8a4e                	mv	s4,s3
 9a6:	6705                	lui	a4,0x1
 9a8:	00e9f363          	bgeu	s3,a4,9ae <malloc+0x42>
 9ac:	6a05                	lui	s4,0x1
 9ae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9b2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b6:	00000497          	auipc	s1,0x0
 9ba:	63248493          	addi	s1,s1,1586 # fe8 <freep>
  if(p == (char*)-1)
 9be:	5afd                	li	s5,-1
 9c0:	a089                	j	a02 <malloc+0x96>
 9c2:	f426                	sd	s1,40(sp)
 9c4:	e852                	sd	s4,16(sp)
 9c6:	e456                	sd	s5,8(sp)
 9c8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9ca:	00001797          	auipc	a5,0x1
 9ce:	a2678793          	addi	a5,a5,-1498 # 13f0 <base>
 9d2:	00000717          	auipc	a4,0x0
 9d6:	60f73b23          	sd	a5,1558(a4) # fe8 <freep>
 9da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9e0:	b7d1                	j	9a4 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9e2:	6398                	ld	a4,0(a5)
 9e4:	e118                	sd	a4,0(a0)
 9e6:	a8b9                	j	a44 <malloc+0xd8>
  hp->s.size = nu;
 9e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ec:	0541                	addi	a0,a0,16
 9ee:	00000097          	auipc	ra,0x0
 9f2:	ef8080e7          	jalr	-264(ra) # 8e6 <free>
  return freep;
 9f6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9f8:	c135                	beqz	a0,a5c <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fc:	4798                	lw	a4,8(a5)
 9fe:	03277363          	bgeu	a4,s2,a24 <malloc+0xb8>
    if(p == freep)
 a02:	6098                	ld	a4,0(s1)
 a04:	853e                	mv	a0,a5
 a06:	fef71ae3          	bne	a4,a5,9fa <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a0a:	8552                	mv	a0,s4
 a0c:	00000097          	auipc	ra,0x0
 a10:	bce080e7          	jalr	-1074(ra) # 5da <sbrk>
  if(p == (char*)-1)
 a14:	fd551ae3          	bne	a0,s5,9e8 <malloc+0x7c>
        return 0;
 a18:	4501                	li	a0,0
 a1a:	74a2                	ld	s1,40(sp)
 a1c:	6a42                	ld	s4,16(sp)
 a1e:	6aa2                	ld	s5,8(sp)
 a20:	6b02                	ld	s6,0(sp)
 a22:	a03d                	j	a50 <malloc+0xe4>
 a24:	74a2                	ld	s1,40(sp)
 a26:	6a42                	ld	s4,16(sp)
 a28:	6aa2                	ld	s5,8(sp)
 a2a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a2c:	fae90be3          	beq	s2,a4,9e2 <malloc+0x76>
        p->s.size -= nunits;
 a30:	4137073b          	subw	a4,a4,s3
 a34:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a36:	02071693          	slli	a3,a4,0x20
 a3a:	01c6d713          	srli	a4,a3,0x1c
 a3e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a40:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a44:	00000717          	auipc	a4,0x0
 a48:	5aa73223          	sd	a0,1444(a4) # fe8 <freep>
      return (void*)(p + 1);
 a4c:	01078513          	addi	a0,a5,16
  }
}
 a50:	70e2                	ld	ra,56(sp)
 a52:	7442                	ld	s0,48(sp)
 a54:	7902                	ld	s2,32(sp)
 a56:	69e2                	ld	s3,24(sp)
 a58:	6121                	addi	sp,sp,64
 a5a:	8082                	ret
 a5c:	74a2                	ld	s1,40(sp)
 a5e:	6a42                	ld	s4,16(sp)
 a60:	6aa2                	ld	s5,8(sp)
 a62:	6b02                	ld	s6,0(sp)
 a64:	b7f5                	j	a50 <malloc+0xe4>
