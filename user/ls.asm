
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	00000097          	auipc	ra,0x0
  10:	33c080e7          	jalr	828(ra) # 348 <strlen>
  14:	02051793          	slli	a5,a0,0x20
  18:	9381                	srli	a5,a5,0x20
  1a:	97a6                	add	a5,a5,s1
  1c:	02f00693          	li	a3,47
  20:	0097e963          	bltu	a5,s1,32 <fmtname+0x32>
  24:	0007c703          	lbu	a4,0(a5)
  28:	00d70563          	beq	a4,a3,32 <fmtname+0x32>
  2c:	17fd                	addi	a5,a5,-1
  2e:	fe97fbe3          	bgeu	a5,s1,24 <fmtname+0x24>
    ;
  p++;
  32:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  36:	8526                	mv	a0,s1
  38:	00000097          	auipc	ra,0x0
  3c:	310080e7          	jalr	784(ra) # 348 <strlen>
  40:	47b5                	li	a5,13
  42:	00a7f863          	bgeu	a5,a0,52 <fmtname+0x52>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  46:	8526                	mv	a0,s1
  48:	70a2                	ld	ra,40(sp)
  4a:	7402                	ld	s0,32(sp)
  4c:	64e2                	ld	s1,24(sp)
  4e:	6145                	addi	sp,sp,48
  50:	8082                	ret
  52:	e84a                	sd	s2,16(sp)
  54:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  56:	8526                	mv	a0,s1
  58:	00000097          	auipc	ra,0x0
  5c:	2f0080e7          	jalr	752(ra) # 348 <strlen>
  60:	862a                	mv	a2,a0
  62:	00001997          	auipc	s3,0x1
  66:	fc698993          	addi	s3,s3,-58 # 1028 <buf.0>
  6a:	85a6                	mv	a1,s1
  6c:	854e                	mv	a0,s3
  6e:	00000097          	auipc	ra,0x0
  72:	470080e7          	jalr	1136(ra) # 4de <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  76:	8526                	mv	a0,s1
  78:	00000097          	auipc	ra,0x0
  7c:	2d0080e7          	jalr	720(ra) # 348 <strlen>
  80:	892a                	mv	s2,a0
  82:	8526                	mv	a0,s1
  84:	00000097          	auipc	ra,0x0
  88:	2c4080e7          	jalr	708(ra) # 348 <strlen>
  8c:	1902                	slli	s2,s2,0x20
  8e:	02095913          	srli	s2,s2,0x20
  92:	4639                	li	a2,14
  94:	9e09                	subw	a2,a2,a0
  96:	02000593          	li	a1,32
  9a:	01298533          	add	a0,s3,s2
  9e:	00000097          	auipc	ra,0x0
  a2:	2d8080e7          	jalr	728(ra) # 376 <memset>
  return buf;
  a6:	84ce                	mv	s1,s3
  a8:	6942                	ld	s2,16(sp)
  aa:	69a2                	ld	s3,8(sp)
  ac:	bf69                	j	46 <fmtname+0x46>

00000000000000ae <ls>:

void
ls(char *path)
{
  ae:	d7010113          	addi	sp,sp,-656
  b2:	28113423          	sd	ra,648(sp)
  b6:	28813023          	sd	s0,640(sp)
  ba:	27213823          	sd	s2,624(sp)
  be:	0d00                	addi	s0,sp,656
  c0:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  c2:	4581                	li	a1,0
  c4:	00000097          	auipc	ra,0x0
  c8:	514080e7          	jalr	1300(ra) # 5d8 <open>
  cc:	06054963          	bltz	a0,13e <ls+0x90>
  d0:	26913c23          	sd	s1,632(sp)
  d4:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  d6:	d7840593          	addi	a1,s0,-648
  da:	00000097          	auipc	ra,0x0
  de:	516080e7          	jalr	1302(ra) # 5f0 <fstat>
  e2:	06054963          	bltz	a0,154 <ls+0xa6>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  e6:	d8041783          	lh	a5,-640(s0)
  ea:	4705                	li	a4,1
  ec:	08e78663          	beq	a5,a4,178 <ls+0xca>
  f0:	4709                	li	a4,2
  f2:	02e79663          	bne	a5,a4,11e <ls+0x70>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
  f6:	854a                	mv	a0,s2
  f8:	00000097          	auipc	ra,0x0
  fc:	f08080e7          	jalr	-248(ra) # 0 <fmtname>
 100:	85aa                	mv	a1,a0
 102:	d8843703          	ld	a4,-632(s0)
 106:	d7c42683          	lw	a3,-644(s0)
 10a:	d8041603          	lh	a2,-640(s0)
 10e:	00001517          	auipc	a0,0x1
 112:	9d250513          	addi	a0,a0,-1582 # ae0 <malloc+0x12e>
 116:	00000097          	auipc	ra,0x0
 11a:	7e0080e7          	jalr	2016(ra) # 8f6 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 11e:	8526                	mv	a0,s1
 120:	00000097          	auipc	ra,0x0
 124:	4a0080e7          	jalr	1184(ra) # 5c0 <close>
 128:	27813483          	ld	s1,632(sp)
}
 12c:	28813083          	ld	ra,648(sp)
 130:	28013403          	ld	s0,640(sp)
 134:	27013903          	ld	s2,624(sp)
 138:	29010113          	addi	sp,sp,656
 13c:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 13e:	864a                	mv	a2,s2
 140:	00001597          	auipc	a1,0x1
 144:	97058593          	addi	a1,a1,-1680 # ab0 <malloc+0xfe>
 148:	4509                	li	a0,2
 14a:	00000097          	auipc	ra,0x0
 14e:	77e080e7          	jalr	1918(ra) # 8c8 <fprintf>
    return;
 152:	bfe9                	j	12c <ls+0x7e>
    fprintf(2, "ls: cannot stat %s\n", path);
 154:	864a                	mv	a2,s2
 156:	00001597          	auipc	a1,0x1
 15a:	97258593          	addi	a1,a1,-1678 # ac8 <malloc+0x116>
 15e:	4509                	li	a0,2
 160:	00000097          	auipc	ra,0x0
 164:	768080e7          	jalr	1896(ra) # 8c8 <fprintf>
    close(fd);
 168:	8526                	mv	a0,s1
 16a:	00000097          	auipc	ra,0x0
 16e:	456080e7          	jalr	1110(ra) # 5c0 <close>
    return;
 172:	27813483          	ld	s1,632(sp)
 176:	bf5d                	j	12c <ls+0x7e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 178:	854a                	mv	a0,s2
 17a:	00000097          	auipc	ra,0x0
 17e:	1ce080e7          	jalr	462(ra) # 348 <strlen>
 182:	2541                	addiw	a0,a0,16
 184:	20000793          	li	a5,512
 188:	00a7fb63          	bgeu	a5,a0,19e <ls+0xf0>
      printf("ls: path too long\n");
 18c:	00001517          	auipc	a0,0x1
 190:	96450513          	addi	a0,a0,-1692 # af0 <malloc+0x13e>
 194:	00000097          	auipc	ra,0x0
 198:	762080e7          	jalr	1890(ra) # 8f6 <printf>
      break;
 19c:	b749                	j	11e <ls+0x70>
 19e:	27313423          	sd	s3,616(sp)
 1a2:	27413023          	sd	s4,608(sp)
 1a6:	25513c23          	sd	s5,600(sp)
 1aa:	25613823          	sd	s6,592(sp)
 1ae:	25713423          	sd	s7,584(sp)
 1b2:	25813023          	sd	s8,576(sp)
 1b6:	23913c23          	sd	s9,568(sp)
 1ba:	23a13823          	sd	s10,560(sp)
    strcpy(buf, path);
 1be:	da040993          	addi	s3,s0,-608
 1c2:	85ca                	mv	a1,s2
 1c4:	854e                	mv	a0,s3
 1c6:	00000097          	auipc	ra,0x0
 1ca:	132080e7          	jalr	306(ra) # 2f8 <strcpy>
    p = buf+strlen(buf);
 1ce:	854e                	mv	a0,s3
 1d0:	00000097          	auipc	ra,0x0
 1d4:	178080e7          	jalr	376(ra) # 348 <strlen>
 1d8:	1502                	slli	a0,a0,0x20
 1da:	9101                	srli	a0,a0,0x20
 1dc:	99aa                	add	s3,s3,a0
    *p++ = '/';
 1de:	00198c93          	addi	s9,s3,1
 1e2:	02f00793          	li	a5,47
 1e6:	00f98023          	sb	a5,0(s3)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ea:	d9040a13          	addi	s4,s0,-624
 1ee:	4941                	li	s2,16
      memmove(p, de.name, DIRSIZ);
 1f0:	d9240c13          	addi	s8,s0,-622
 1f4:	4bb9                	li	s7,14
      if(stat(buf, &st) < 0){
 1f6:	d7840b13          	addi	s6,s0,-648
 1fa:	da040a93          	addi	s5,s0,-608
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1fe:	00001d17          	auipc	s10,0x1
 202:	90ad0d13          	addi	s10,s10,-1782 # b08 <malloc+0x156>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 206:	a811                	j	21a <ls+0x16c>
        printf("ls: cannot stat %s\n", buf);
 208:	85d6                	mv	a1,s5
 20a:	00001517          	auipc	a0,0x1
 20e:	8be50513          	addi	a0,a0,-1858 # ac8 <malloc+0x116>
 212:	00000097          	auipc	ra,0x0
 216:	6e4080e7          	jalr	1764(ra) # 8f6 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 21a:	864a                	mv	a2,s2
 21c:	85d2                	mv	a1,s4
 21e:	8526                	mv	a0,s1
 220:	00000097          	auipc	ra,0x0
 224:	390080e7          	jalr	912(ra) # 5b0 <read>
 228:	05251863          	bne	a0,s2,278 <ls+0x1ca>
      if(de.inum == 0)
 22c:	d9045783          	lhu	a5,-624(s0)
 230:	d7ed                	beqz	a5,21a <ls+0x16c>
      memmove(p, de.name, DIRSIZ);
 232:	865e                	mv	a2,s7
 234:	85e2                	mv	a1,s8
 236:	8566                	mv	a0,s9
 238:	00000097          	auipc	ra,0x0
 23c:	2a6080e7          	jalr	678(ra) # 4de <memmove>
      p[DIRSIZ] = 0;
 240:	000987a3          	sb	zero,15(s3)
      if(stat(buf, &st) < 0){
 244:	85da                	mv	a1,s6
 246:	8556                	mv	a0,s5
 248:	00000097          	auipc	ra,0x0
 24c:	204080e7          	jalr	516(ra) # 44c <stat>
 250:	fa054ce3          	bltz	a0,208 <ls+0x15a>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 254:	8556                	mv	a0,s5
 256:	00000097          	auipc	ra,0x0
 25a:	daa080e7          	jalr	-598(ra) # 0 <fmtname>
 25e:	85aa                	mv	a1,a0
 260:	d8843703          	ld	a4,-632(s0)
 264:	d7c42683          	lw	a3,-644(s0)
 268:	d8041603          	lh	a2,-640(s0)
 26c:	856a                	mv	a0,s10
 26e:	00000097          	auipc	ra,0x0
 272:	688080e7          	jalr	1672(ra) # 8f6 <printf>
 276:	b755                	j	21a <ls+0x16c>
 278:	26813983          	ld	s3,616(sp)
 27c:	26013a03          	ld	s4,608(sp)
 280:	25813a83          	ld	s5,600(sp)
 284:	25013b03          	ld	s6,592(sp)
 288:	24813b83          	ld	s7,584(sp)
 28c:	24013c03          	ld	s8,576(sp)
 290:	23813c83          	ld	s9,568(sp)
 294:	23013d03          	ld	s10,560(sp)
 298:	b559                	j	11e <ls+0x70>

000000000000029a <main>:

int
main(int argc, char *argv[])
{
 29a:	1101                	addi	sp,sp,-32
 29c:	ec06                	sd	ra,24(sp)
 29e:	e822                	sd	s0,16(sp)
 2a0:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 2a2:	4785                	li	a5,1
 2a4:	02a7db63          	bge	a5,a0,2da <main+0x40>
 2a8:	e426                	sd	s1,8(sp)
 2aa:	e04a                	sd	s2,0(sp)
 2ac:	00858493          	addi	s1,a1,8
 2b0:	ffe5091b          	addiw	s2,a0,-2
 2b4:	02091793          	slli	a5,s2,0x20
 2b8:	01d7d913          	srli	s2,a5,0x1d
 2bc:	05c1                	addi	a1,a1,16
 2be:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2c0:	6088                	ld	a0,0(s1)
 2c2:	00000097          	auipc	ra,0x0
 2c6:	dec080e7          	jalr	-532(ra) # ae <ls>
  for(i=1; i<argc; i++)
 2ca:	04a1                	addi	s1,s1,8
 2cc:	ff249ae3          	bne	s1,s2,2c0 <main+0x26>
  exit(0);
 2d0:	4501                	li	a0,0
 2d2:	00000097          	auipc	ra,0x0
 2d6:	2c6080e7          	jalr	710(ra) # 598 <exit>
 2da:	e426                	sd	s1,8(sp)
 2dc:	e04a                	sd	s2,0(sp)
    ls(".");
 2de:	00001517          	auipc	a0,0x1
 2e2:	83a50513          	addi	a0,a0,-1990 # b18 <malloc+0x166>
 2e6:	00000097          	auipc	ra,0x0
 2ea:	dc8080e7          	jalr	-568(ra) # ae <ls>
    exit(0);
 2ee:	4501                	li	a0,0
 2f0:	00000097          	auipc	ra,0x0
 2f4:	2a8080e7          	jalr	680(ra) # 598 <exit>

00000000000002f8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e406                	sd	ra,8(sp)
 2fc:	e022                	sd	s0,0(sp)
 2fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 300:	87aa                	mv	a5,a0
 302:	0585                	addi	a1,a1,1
 304:	0785                	addi	a5,a5,1
 306:	fff5c703          	lbu	a4,-1(a1)
 30a:	fee78fa3          	sb	a4,-1(a5)
 30e:	fb75                	bnez	a4,302 <strcpy+0xa>
    ;
  return os;
}
 310:	60a2                	ld	ra,8(sp)
 312:	6402                	ld	s0,0(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret

0000000000000318 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 320:	00054783          	lbu	a5,0(a0)
 324:	cb91                	beqz	a5,338 <strcmp+0x20>
 326:	0005c703          	lbu	a4,0(a1)
 32a:	00f71763          	bne	a4,a5,338 <strcmp+0x20>
    p++, q++;
 32e:	0505                	addi	a0,a0,1
 330:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 332:	00054783          	lbu	a5,0(a0)
 336:	fbe5                	bnez	a5,326 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 338:	0005c503          	lbu	a0,0(a1)
}
 33c:	40a7853b          	subw	a0,a5,a0
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <strlen>:

uint
strlen(const char *s)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 350:	00054783          	lbu	a5,0(a0)
 354:	cf99                	beqz	a5,372 <strlen+0x2a>
 356:	0505                	addi	a0,a0,1
 358:	87aa                	mv	a5,a0
 35a:	86be                	mv	a3,a5
 35c:	0785                	addi	a5,a5,1
 35e:	fff7c703          	lbu	a4,-1(a5)
 362:	ff65                	bnez	a4,35a <strlen+0x12>
 364:	40a6853b          	subw	a0,a3,a0
 368:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
  for(n = 0; s[n]; n++)
 372:	4501                	li	a0,0
 374:	bfdd                	j	36a <strlen+0x22>

0000000000000376 <memset>:

void*
memset(void *dst, int c, uint n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 37e:	ca19                	beqz	a2,394 <memset+0x1e>
 380:	87aa                	mv	a5,a0
 382:	1602                	slli	a2,a2,0x20
 384:	9201                	srli	a2,a2,0x20
 386:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 38a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 38e:	0785                	addi	a5,a5,1
 390:	fee79de3          	bne	a5,a4,38a <memset+0x14>
  }
  return dst;
}
 394:	60a2                	ld	ra,8(sp)
 396:	6402                	ld	s0,0(sp)
 398:	0141                	addi	sp,sp,16
 39a:	8082                	ret

000000000000039c <strchr>:

char*
strchr(const char *s, char c)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3a4:	00054783          	lbu	a5,0(a0)
 3a8:	cf81                	beqz	a5,3c0 <strchr+0x24>
    if(*s == c)
 3aa:	00f58763          	beq	a1,a5,3b8 <strchr+0x1c>
  for(; *s; s++)
 3ae:	0505                	addi	a0,a0,1
 3b0:	00054783          	lbu	a5,0(a0)
 3b4:	fbfd                	bnez	a5,3aa <strchr+0xe>
      return (char*)s;
  return 0;
 3b6:	4501                	li	a0,0
}
 3b8:	60a2                	ld	ra,8(sp)
 3ba:	6402                	ld	s0,0(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret
  return 0;
 3c0:	4501                	li	a0,0
 3c2:	bfdd                	j	3b8 <strchr+0x1c>

00000000000003c4 <gets>:

char*
gets(char *buf, int max)
{
 3c4:	7159                	addi	sp,sp,-112
 3c6:	f486                	sd	ra,104(sp)
 3c8:	f0a2                	sd	s0,96(sp)
 3ca:	eca6                	sd	s1,88(sp)
 3cc:	e8ca                	sd	s2,80(sp)
 3ce:	e4ce                	sd	s3,72(sp)
 3d0:	e0d2                	sd	s4,64(sp)
 3d2:	fc56                	sd	s5,56(sp)
 3d4:	f85a                	sd	s6,48(sp)
 3d6:	f45e                	sd	s7,40(sp)
 3d8:	f062                	sd	s8,32(sp)
 3da:	ec66                	sd	s9,24(sp)
 3dc:	e86a                	sd	s10,16(sp)
 3de:	1880                	addi	s0,sp,112
 3e0:	8caa                	mv	s9,a0
 3e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e4:	892a                	mv	s2,a0
 3e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3e8:	f9f40b13          	addi	s6,s0,-97
 3ec:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3ee:	4ba9                	li	s7,10
 3f0:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 3f2:	8d26                	mv	s10,s1
 3f4:	0014899b          	addiw	s3,s1,1
 3f8:	84ce                	mv	s1,s3
 3fa:	0349d763          	bge	s3,s4,428 <gets+0x64>
    cc = read(0, &c, 1);
 3fe:	8656                	mv	a2,s5
 400:	85da                	mv	a1,s6
 402:	4501                	li	a0,0
 404:	00000097          	auipc	ra,0x0
 408:	1ac080e7          	jalr	428(ra) # 5b0 <read>
    if(cc < 1)
 40c:	00a05e63          	blez	a0,428 <gets+0x64>
    buf[i++] = c;
 410:	f9f44783          	lbu	a5,-97(s0)
 414:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 418:	01778763          	beq	a5,s7,426 <gets+0x62>
 41c:	0905                	addi	s2,s2,1
 41e:	fd879ae3          	bne	a5,s8,3f2 <gets+0x2e>
    buf[i++] = c;
 422:	8d4e                	mv	s10,s3
 424:	a011                	j	428 <gets+0x64>
 426:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 428:	9d66                	add	s10,s10,s9
 42a:	000d0023          	sb	zero,0(s10)
  return buf;
}
 42e:	8566                	mv	a0,s9
 430:	70a6                	ld	ra,104(sp)
 432:	7406                	ld	s0,96(sp)
 434:	64e6                	ld	s1,88(sp)
 436:	6946                	ld	s2,80(sp)
 438:	69a6                	ld	s3,72(sp)
 43a:	6a06                	ld	s4,64(sp)
 43c:	7ae2                	ld	s5,56(sp)
 43e:	7b42                	ld	s6,48(sp)
 440:	7ba2                	ld	s7,40(sp)
 442:	7c02                	ld	s8,32(sp)
 444:	6ce2                	ld	s9,24(sp)
 446:	6d42                	ld	s10,16(sp)
 448:	6165                	addi	sp,sp,112
 44a:	8082                	ret

000000000000044c <stat>:

int
stat(const char *n, struct stat *st)
{
 44c:	1101                	addi	sp,sp,-32
 44e:	ec06                	sd	ra,24(sp)
 450:	e822                	sd	s0,16(sp)
 452:	e04a                	sd	s2,0(sp)
 454:	1000                	addi	s0,sp,32
 456:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 458:	4581                	li	a1,0
 45a:	00000097          	auipc	ra,0x0
 45e:	17e080e7          	jalr	382(ra) # 5d8 <open>
  if(fd < 0)
 462:	02054663          	bltz	a0,48e <stat+0x42>
 466:	e426                	sd	s1,8(sp)
 468:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 46a:	85ca                	mv	a1,s2
 46c:	00000097          	auipc	ra,0x0
 470:	184080e7          	jalr	388(ra) # 5f0 <fstat>
 474:	892a                	mv	s2,a0
  close(fd);
 476:	8526                	mv	a0,s1
 478:	00000097          	auipc	ra,0x0
 47c:	148080e7          	jalr	328(ra) # 5c0 <close>
  return r;
 480:	64a2                	ld	s1,8(sp)
}
 482:	854a                	mv	a0,s2
 484:	60e2                	ld	ra,24(sp)
 486:	6442                	ld	s0,16(sp)
 488:	6902                	ld	s2,0(sp)
 48a:	6105                	addi	sp,sp,32
 48c:	8082                	ret
    return -1;
 48e:	597d                	li	s2,-1
 490:	bfcd                	j	482 <stat+0x36>

0000000000000492 <atoi>:

int
atoi(const char *s)
{
 492:	1141                	addi	sp,sp,-16
 494:	e406                	sd	ra,8(sp)
 496:	e022                	sd	s0,0(sp)
 498:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 49a:	00054683          	lbu	a3,0(a0)
 49e:	fd06879b          	addiw	a5,a3,-48
 4a2:	0ff7f793          	zext.b	a5,a5
 4a6:	4625                	li	a2,9
 4a8:	02f66963          	bltu	a2,a5,4da <atoi+0x48>
 4ac:	872a                	mv	a4,a0
  n = 0;
 4ae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4b0:	0705                	addi	a4,a4,1
 4b2:	0025179b          	slliw	a5,a0,0x2
 4b6:	9fa9                	addw	a5,a5,a0
 4b8:	0017979b          	slliw	a5,a5,0x1
 4bc:	9fb5                	addw	a5,a5,a3
 4be:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4c2:	00074683          	lbu	a3,0(a4)
 4c6:	fd06879b          	addiw	a5,a3,-48
 4ca:	0ff7f793          	zext.b	a5,a5
 4ce:	fef671e3          	bgeu	a2,a5,4b0 <atoi+0x1e>
  return n;
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
  n = 0;
 4da:	4501                	li	a0,0
 4dc:	bfdd                	j	4d2 <atoi+0x40>

00000000000004de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e406                	sd	ra,8(sp)
 4e2:	e022                	sd	s0,0(sp)
 4e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4e6:	02b57563          	bgeu	a0,a1,510 <memmove+0x32>
    while(n-- > 0)
 4ea:	00c05f63          	blez	a2,508 <memmove+0x2a>
 4ee:	1602                	slli	a2,a2,0x20
 4f0:	9201                	srli	a2,a2,0x20
 4f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4f8:	0585                	addi	a1,a1,1
 4fa:	0705                	addi	a4,a4,1
 4fc:	fff5c683          	lbu	a3,-1(a1)
 500:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 504:	fee79ae3          	bne	a5,a4,4f8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 508:	60a2                	ld	ra,8(sp)
 50a:	6402                	ld	s0,0(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret
    dst += n;
 510:	00c50733          	add	a4,a0,a2
    src += n;
 514:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 516:	fec059e3          	blez	a2,508 <memmove+0x2a>
 51a:	fff6079b          	addiw	a5,a2,-1
 51e:	1782                	slli	a5,a5,0x20
 520:	9381                	srli	a5,a5,0x20
 522:	fff7c793          	not	a5,a5
 526:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 528:	15fd                	addi	a1,a1,-1
 52a:	177d                	addi	a4,a4,-1
 52c:	0005c683          	lbu	a3,0(a1)
 530:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 534:	fef71ae3          	bne	a4,a5,528 <memmove+0x4a>
 538:	bfc1                	j	508 <memmove+0x2a>

000000000000053a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 53a:	1141                	addi	sp,sp,-16
 53c:	e406                	sd	ra,8(sp)
 53e:	e022                	sd	s0,0(sp)
 540:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 542:	ca0d                	beqz	a2,574 <memcmp+0x3a>
 544:	fff6069b          	addiw	a3,a2,-1
 548:	1682                	slli	a3,a3,0x20
 54a:	9281                	srli	a3,a3,0x20
 54c:	0685                	addi	a3,a3,1
 54e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 550:	00054783          	lbu	a5,0(a0)
 554:	0005c703          	lbu	a4,0(a1)
 558:	00e79863          	bne	a5,a4,568 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 55c:	0505                	addi	a0,a0,1
    p2++;
 55e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 560:	fed518e3          	bne	a0,a3,550 <memcmp+0x16>
  }
  return 0;
 564:	4501                	li	a0,0
 566:	a019                	j	56c <memcmp+0x32>
      return *p1 - *p2;
 568:	40e7853b          	subw	a0,a5,a4
}
 56c:	60a2                	ld	ra,8(sp)
 56e:	6402                	ld	s0,0(sp)
 570:	0141                	addi	sp,sp,16
 572:	8082                	ret
  return 0;
 574:	4501                	li	a0,0
 576:	bfdd                	j	56c <memcmp+0x32>

0000000000000578 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 578:	1141                	addi	sp,sp,-16
 57a:	e406                	sd	ra,8(sp)
 57c:	e022                	sd	s0,0(sp)
 57e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 580:	00000097          	auipc	ra,0x0
 584:	f5e080e7          	jalr	-162(ra) # 4de <memmove>
}
 588:	60a2                	ld	ra,8(sp)
 58a:	6402                	ld	s0,0(sp)
 58c:	0141                	addi	sp,sp,16
 58e:	8082                	ret

0000000000000590 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 590:	4885                	li	a7,1
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <exit>:
.global exit
exit:
 li a7, SYS_exit
 598:	4889                	li	a7,2
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5a0:	488d                	li	a7,3
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a8:	4891                	li	a7,4
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <read>:
.global read
read:
 li a7, SYS_read
 5b0:	4895                	li	a7,5
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <write>:
.global write
write:
 li a7, SYS_write
 5b8:	48c1                	li	a7,16
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <close>:
.global close
close:
 li a7, SYS_close
 5c0:	48d5                	li	a7,21
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c8:	4899                	li	a7,6
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5d0:	489d                	li	a7,7
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <open>:
.global open
open:
 li a7, SYS_open
 5d8:	48bd                	li	a7,15
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5e0:	48c5                	li	a7,17
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e8:	48c9                	li	a7,18
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5f0:	48a1                	li	a7,8
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <link>:
.global link
link:
 li a7, SYS_link
 5f8:	48cd                	li	a7,19
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 600:	48d1                	li	a7,20
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 608:	48a5                	li	a7,9
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <dup>:
.global dup
dup:
 li a7, SYS_dup
 610:	48a9                	li	a7,10
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 618:	48ad                	li	a7,11
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 620:	48b1                	li	a7,12
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 628:	48b5                	li	a7,13
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 630:	48b9                	li	a7,14
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <trace>:
.global trace
trace:
 li a7, SYS_trace
 638:	48d9                	li	a7,22
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 640:	1101                	addi	sp,sp,-32
 642:	ec06                	sd	ra,24(sp)
 644:	e822                	sd	s0,16(sp)
 646:	1000                	addi	s0,sp,32
 648:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 64c:	4605                	li	a2,1
 64e:	fef40593          	addi	a1,s0,-17
 652:	00000097          	auipc	ra,0x0
 656:	f66080e7          	jalr	-154(ra) # 5b8 <write>
}
 65a:	60e2                	ld	ra,24(sp)
 65c:	6442                	ld	s0,16(sp)
 65e:	6105                	addi	sp,sp,32
 660:	8082                	ret

0000000000000662 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 662:	7139                	addi	sp,sp,-64
 664:	fc06                	sd	ra,56(sp)
 666:	f822                	sd	s0,48(sp)
 668:	f426                	sd	s1,40(sp)
 66a:	f04a                	sd	s2,32(sp)
 66c:	ec4e                	sd	s3,24(sp)
 66e:	0080                	addi	s0,sp,64
 670:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 672:	c299                	beqz	a3,678 <printint+0x16>
 674:	0805c063          	bltz	a1,6f4 <printint+0x92>
  neg = 0;
 678:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 67a:	fc040313          	addi	t1,s0,-64
  neg = 0;
 67e:	869a                	mv	a3,t1
  i = 0;
 680:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 682:	00000817          	auipc	a6,0x0
 686:	4fe80813          	addi	a6,a6,1278 # b80 <digits>
 68a:	88be                	mv	a7,a5
 68c:	0017851b          	addiw	a0,a5,1
 690:	87aa                	mv	a5,a0
 692:	02c5f73b          	remuw	a4,a1,a2
 696:	1702                	slli	a4,a4,0x20
 698:	9301                	srli	a4,a4,0x20
 69a:	9742                	add	a4,a4,a6
 69c:	00074703          	lbu	a4,0(a4)
 6a0:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 6a4:	872e                	mv	a4,a1
 6a6:	02c5d5bb          	divuw	a1,a1,a2
 6aa:	0685                	addi	a3,a3,1
 6ac:	fcc77fe3          	bgeu	a4,a2,68a <printint+0x28>
  if(neg)
 6b0:	000e0c63          	beqz	t3,6c8 <printint+0x66>
    buf[i++] = '-';
 6b4:	fd050793          	addi	a5,a0,-48
 6b8:	00878533          	add	a0,a5,s0
 6bc:	02d00793          	li	a5,45
 6c0:	fef50823          	sb	a5,-16(a0)
 6c4:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 6c8:	fff7899b          	addiw	s3,a5,-1
 6cc:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 6d0:	fff4c583          	lbu	a1,-1(s1)
 6d4:	854a                	mv	a0,s2
 6d6:	00000097          	auipc	ra,0x0
 6da:	f6a080e7          	jalr	-150(ra) # 640 <putc>
  while(--i >= 0)
 6de:	39fd                	addiw	s3,s3,-1
 6e0:	14fd                	addi	s1,s1,-1
 6e2:	fe09d7e3          	bgez	s3,6d0 <printint+0x6e>
}
 6e6:	70e2                	ld	ra,56(sp)
 6e8:	7442                	ld	s0,48(sp)
 6ea:	74a2                	ld	s1,40(sp)
 6ec:	7902                	ld	s2,32(sp)
 6ee:	69e2                	ld	s3,24(sp)
 6f0:	6121                	addi	sp,sp,64
 6f2:	8082                	ret
    x = -xx;
 6f4:	40b005bb          	negw	a1,a1
    neg = 1;
 6f8:	4e05                	li	t3,1
    x = -xx;
 6fa:	b741                	j	67a <printint+0x18>

00000000000006fc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6fc:	715d                	addi	sp,sp,-80
 6fe:	e486                	sd	ra,72(sp)
 700:	e0a2                	sd	s0,64(sp)
 702:	f84a                	sd	s2,48(sp)
 704:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 706:	0005c903          	lbu	s2,0(a1)
 70a:	1a090a63          	beqz	s2,8be <vprintf+0x1c2>
 70e:	fc26                	sd	s1,56(sp)
 710:	f44e                	sd	s3,40(sp)
 712:	f052                	sd	s4,32(sp)
 714:	ec56                	sd	s5,24(sp)
 716:	e85a                	sd	s6,16(sp)
 718:	e45e                	sd	s7,8(sp)
 71a:	8aaa                	mv	s5,a0
 71c:	8bb2                	mv	s7,a2
 71e:	00158493          	addi	s1,a1,1
  state = 0;
 722:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 724:	02500a13          	li	s4,37
 728:	4b55                	li	s6,21
 72a:	a839                	j	748 <vprintf+0x4c>
        putc(fd, c);
 72c:	85ca                	mv	a1,s2
 72e:	8556                	mv	a0,s5
 730:	00000097          	auipc	ra,0x0
 734:	f10080e7          	jalr	-240(ra) # 640 <putc>
 738:	a019                	j	73e <vprintf+0x42>
    } else if(state == '%'){
 73a:	01498d63          	beq	s3,s4,754 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 73e:	0485                	addi	s1,s1,1
 740:	fff4c903          	lbu	s2,-1(s1)
 744:	16090763          	beqz	s2,8b2 <vprintf+0x1b6>
    if(state == 0){
 748:	fe0999e3          	bnez	s3,73a <vprintf+0x3e>
      if(c == '%'){
 74c:	ff4910e3          	bne	s2,s4,72c <vprintf+0x30>
        state = '%';
 750:	89d2                	mv	s3,s4
 752:	b7f5                	j	73e <vprintf+0x42>
      if(c == 'd'){
 754:	13490463          	beq	s2,s4,87c <vprintf+0x180>
 758:	f9d9079b          	addiw	a5,s2,-99
 75c:	0ff7f793          	zext.b	a5,a5
 760:	12fb6763          	bltu	s6,a5,88e <vprintf+0x192>
 764:	f9d9079b          	addiw	a5,s2,-99
 768:	0ff7f713          	zext.b	a4,a5
 76c:	12eb6163          	bltu	s6,a4,88e <vprintf+0x192>
 770:	00271793          	slli	a5,a4,0x2
 774:	00000717          	auipc	a4,0x0
 778:	3b470713          	addi	a4,a4,948 # b28 <malloc+0x176>
 77c:	97ba                	add	a5,a5,a4
 77e:	439c                	lw	a5,0(a5)
 780:	97ba                	add	a5,a5,a4
 782:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 784:	008b8913          	addi	s2,s7,8
 788:	4685                	li	a3,1
 78a:	4629                	li	a2,10
 78c:	000ba583          	lw	a1,0(s7)
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	ed0080e7          	jalr	-304(ra) # 662 <printint>
 79a:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 79c:	4981                	li	s3,0
 79e:	b745                	j	73e <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a0:	008b8913          	addi	s2,s7,8
 7a4:	4681                	li	a3,0
 7a6:	4629                	li	a2,10
 7a8:	000ba583          	lw	a1,0(s7)
 7ac:	8556                	mv	a0,s5
 7ae:	00000097          	auipc	ra,0x0
 7b2:	eb4080e7          	jalr	-332(ra) # 662 <printint>
 7b6:	8bca                	mv	s7,s2
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	b751                	j	73e <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 7bc:	008b8913          	addi	s2,s7,8
 7c0:	4681                	li	a3,0
 7c2:	4641                	li	a2,16
 7c4:	000ba583          	lw	a1,0(s7)
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	e98080e7          	jalr	-360(ra) # 662 <printint>
 7d2:	8bca                	mv	s7,s2
      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b7a5                	j	73e <vprintf+0x42>
 7d8:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7da:	008b8c13          	addi	s8,s7,8
 7de:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e2:	03000593          	li	a1,48
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	e58080e7          	jalr	-424(ra) # 640 <putc>
  putc(fd, 'x');
 7f0:	07800593          	li	a1,120
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	e4a080e7          	jalr	-438(ra) # 640 <putc>
 7fe:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 800:	00000b97          	auipc	s7,0x0
 804:	380b8b93          	addi	s7,s7,896 # b80 <digits>
 808:	03c9d793          	srli	a5,s3,0x3c
 80c:	97de                	add	a5,a5,s7
 80e:	0007c583          	lbu	a1,0(a5)
 812:	8556                	mv	a0,s5
 814:	00000097          	auipc	ra,0x0
 818:	e2c080e7          	jalr	-468(ra) # 640 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 81c:	0992                	slli	s3,s3,0x4
 81e:	397d                	addiw	s2,s2,-1
 820:	fe0914e3          	bnez	s2,808 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 824:	8be2                	mv	s7,s8
      state = 0;
 826:	4981                	li	s3,0
 828:	6c02                	ld	s8,0(sp)
 82a:	bf11                	j	73e <vprintf+0x42>
        s = va_arg(ap, char*);
 82c:	008b8993          	addi	s3,s7,8
 830:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 834:	02090163          	beqz	s2,856 <vprintf+0x15a>
        while(*s != 0){
 838:	00094583          	lbu	a1,0(s2)
 83c:	c9a5                	beqz	a1,8ac <vprintf+0x1b0>
          putc(fd, *s);
 83e:	8556                	mv	a0,s5
 840:	00000097          	auipc	ra,0x0
 844:	e00080e7          	jalr	-512(ra) # 640 <putc>
          s++;
 848:	0905                	addi	s2,s2,1
        while(*s != 0){
 84a:	00094583          	lbu	a1,0(s2)
 84e:	f9e5                	bnez	a1,83e <vprintf+0x142>
        s = va_arg(ap, char*);
 850:	8bce                	mv	s7,s3
      state = 0;
 852:	4981                	li	s3,0
 854:	b5ed                	j	73e <vprintf+0x42>
          s = "(null)";
 856:	00000917          	auipc	s2,0x0
 85a:	2ca90913          	addi	s2,s2,714 # b20 <malloc+0x16e>
        while(*s != 0){
 85e:	02800593          	li	a1,40
 862:	bff1                	j	83e <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 864:	008b8913          	addi	s2,s7,8
 868:	000bc583          	lbu	a1,0(s7)
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	dd2080e7          	jalr	-558(ra) # 640 <putc>
 876:	8bca                	mv	s7,s2
      state = 0;
 878:	4981                	li	s3,0
 87a:	b5d1                	j	73e <vprintf+0x42>
        putc(fd, c);
 87c:	02500593          	li	a1,37
 880:	8556                	mv	a0,s5
 882:	00000097          	auipc	ra,0x0
 886:	dbe080e7          	jalr	-578(ra) # 640 <putc>
      state = 0;
 88a:	4981                	li	s3,0
 88c:	bd4d                	j	73e <vprintf+0x42>
        putc(fd, '%');
 88e:	02500593          	li	a1,37
 892:	8556                	mv	a0,s5
 894:	00000097          	auipc	ra,0x0
 898:	dac080e7          	jalr	-596(ra) # 640 <putc>
        putc(fd, c);
 89c:	85ca                	mv	a1,s2
 89e:	8556                	mv	a0,s5
 8a0:	00000097          	auipc	ra,0x0
 8a4:	da0080e7          	jalr	-608(ra) # 640 <putc>
      state = 0;
 8a8:	4981                	li	s3,0
 8aa:	bd51                	j	73e <vprintf+0x42>
        s = va_arg(ap, char*);
 8ac:	8bce                	mv	s7,s3
      state = 0;
 8ae:	4981                	li	s3,0
 8b0:	b579                	j	73e <vprintf+0x42>
 8b2:	74e2                	ld	s1,56(sp)
 8b4:	79a2                	ld	s3,40(sp)
 8b6:	7a02                	ld	s4,32(sp)
 8b8:	6ae2                	ld	s5,24(sp)
 8ba:	6b42                	ld	s6,16(sp)
 8bc:	6ba2                	ld	s7,8(sp)
    }
  }
}
 8be:	60a6                	ld	ra,72(sp)
 8c0:	6406                	ld	s0,64(sp)
 8c2:	7942                	ld	s2,48(sp)
 8c4:	6161                	addi	sp,sp,80
 8c6:	8082                	ret

00000000000008c8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8c8:	715d                	addi	sp,sp,-80
 8ca:	ec06                	sd	ra,24(sp)
 8cc:	e822                	sd	s0,16(sp)
 8ce:	1000                	addi	s0,sp,32
 8d0:	e010                	sd	a2,0(s0)
 8d2:	e414                	sd	a3,8(s0)
 8d4:	e818                	sd	a4,16(s0)
 8d6:	ec1c                	sd	a5,24(s0)
 8d8:	03043023          	sd	a6,32(s0)
 8dc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e0:	8622                	mv	a2,s0
 8e2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8e6:	00000097          	auipc	ra,0x0
 8ea:	e16080e7          	jalr	-490(ra) # 6fc <vprintf>
}
 8ee:	60e2                	ld	ra,24(sp)
 8f0:	6442                	ld	s0,16(sp)
 8f2:	6161                	addi	sp,sp,80
 8f4:	8082                	ret

00000000000008f6 <printf>:

void
printf(const char *fmt, ...)
{
 8f6:	711d                	addi	sp,sp,-96
 8f8:	ec06                	sd	ra,24(sp)
 8fa:	e822                	sd	s0,16(sp)
 8fc:	1000                	addi	s0,sp,32
 8fe:	e40c                	sd	a1,8(s0)
 900:	e810                	sd	a2,16(s0)
 902:	ec14                	sd	a3,24(s0)
 904:	f018                	sd	a4,32(s0)
 906:	f41c                	sd	a5,40(s0)
 908:	03043823          	sd	a6,48(s0)
 90c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 910:	00840613          	addi	a2,s0,8
 914:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 918:	85aa                	mv	a1,a0
 91a:	4505                	li	a0,1
 91c:	00000097          	auipc	ra,0x0
 920:	de0080e7          	jalr	-544(ra) # 6fc <vprintf>
}
 924:	60e2                	ld	ra,24(sp)
 926:	6442                	ld	s0,16(sp)
 928:	6125                	addi	sp,sp,96
 92a:	8082                	ret

000000000000092c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 92c:	1141                	addi	sp,sp,-16
 92e:	e406                	sd	ra,8(sp)
 930:	e022                	sd	s0,0(sp)
 932:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 934:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 938:	00000797          	auipc	a5,0x0
 93c:	6e87b783          	ld	a5,1768(a5) # 1020 <freep>
 940:	a02d                	j	96a <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 942:	4618                	lw	a4,8(a2)
 944:	9f2d                	addw	a4,a4,a1
 946:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94a:	6398                	ld	a4,0(a5)
 94c:	6310                	ld	a2,0(a4)
 94e:	a83d                	j	98c <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 950:	ff852703          	lw	a4,-8(a0)
 954:	9f31                	addw	a4,a4,a2
 956:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 958:	ff053683          	ld	a3,-16(a0)
 95c:	a091                	j	9a0 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 95e:	6398                	ld	a4,0(a5)
 960:	00e7e463          	bltu	a5,a4,968 <free+0x3c>
 964:	00e6ea63          	bltu	a3,a4,978 <free+0x4c>
{
 968:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96a:	fed7fae3          	bgeu	a5,a3,95e <free+0x32>
 96e:	6398                	ld	a4,0(a5)
 970:	00e6e463          	bltu	a3,a4,978 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 974:	fee7eae3          	bltu	a5,a4,968 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 978:	ff852583          	lw	a1,-8(a0)
 97c:	6390                	ld	a2,0(a5)
 97e:	02059813          	slli	a6,a1,0x20
 982:	01c85713          	srli	a4,a6,0x1c
 986:	9736                	add	a4,a4,a3
 988:	fae60de3          	beq	a2,a4,942 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 98c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 990:	4790                	lw	a2,8(a5)
 992:	02061593          	slli	a1,a2,0x20
 996:	01c5d713          	srli	a4,a1,0x1c
 99a:	973e                	add	a4,a4,a5
 99c:	fae68ae3          	beq	a3,a4,950 <free+0x24>
    p->s.ptr = bp->s.ptr;
 9a0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a2:	00000717          	auipc	a4,0x0
 9a6:	66f73f23          	sd	a5,1662(a4) # 1020 <freep>
}
 9aa:	60a2                	ld	ra,8(sp)
 9ac:	6402                	ld	s0,0(sp)
 9ae:	0141                	addi	sp,sp,16
 9b0:	8082                	ret

00000000000009b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b2:	7139                	addi	sp,sp,-64
 9b4:	fc06                	sd	ra,56(sp)
 9b6:	f822                	sd	s0,48(sp)
 9b8:	f04a                	sd	s2,32(sp)
 9ba:	ec4e                	sd	s3,24(sp)
 9bc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9be:	02051993          	slli	s3,a0,0x20
 9c2:	0209d993          	srli	s3,s3,0x20
 9c6:	09bd                	addi	s3,s3,15
 9c8:	0049d993          	srli	s3,s3,0x4
 9cc:	2985                	addiw	s3,s3,1
 9ce:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 9d0:	00000517          	auipc	a0,0x0
 9d4:	65053503          	ld	a0,1616(a0) # 1020 <freep>
 9d8:	c905                	beqz	a0,a08 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9dc:	4798                	lw	a4,8(a5)
 9de:	09377a63          	bgeu	a4,s3,a72 <malloc+0xc0>
 9e2:	f426                	sd	s1,40(sp)
 9e4:	e852                	sd	s4,16(sp)
 9e6:	e456                	sd	s5,8(sp)
 9e8:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9ea:	8a4e                	mv	s4,s3
 9ec:	6705                	lui	a4,0x1
 9ee:	00e9f363          	bgeu	s3,a4,9f4 <malloc+0x42>
 9f2:	6a05                	lui	s4,0x1
 9f4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9f8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9fc:	00000497          	auipc	s1,0x0
 a00:	62448493          	addi	s1,s1,1572 # 1020 <freep>
  if(p == (char*)-1)
 a04:	5afd                	li	s5,-1
 a06:	a089                	j	a48 <malloc+0x96>
 a08:	f426                	sd	s1,40(sp)
 a0a:	e852                	sd	s4,16(sp)
 a0c:	e456                	sd	s5,8(sp)
 a0e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a10:	00000797          	auipc	a5,0x0
 a14:	62878793          	addi	a5,a5,1576 # 1038 <base>
 a18:	00000717          	auipc	a4,0x0
 a1c:	60f73423          	sd	a5,1544(a4) # 1020 <freep>
 a20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a22:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a26:	b7d1                	j	9ea <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a28:	6398                	ld	a4,0(a5)
 a2a:	e118                	sd	a4,0(a0)
 a2c:	a8b9                	j	a8a <malloc+0xd8>
  hp->s.size = nu;
 a2e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a32:	0541                	addi	a0,a0,16
 a34:	00000097          	auipc	ra,0x0
 a38:	ef8080e7          	jalr	-264(ra) # 92c <free>
  return freep;
 a3c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a3e:	c135                	beqz	a0,aa2 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a40:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a42:	4798                	lw	a4,8(a5)
 a44:	03277363          	bgeu	a4,s2,a6a <malloc+0xb8>
    if(p == freep)
 a48:	6098                	ld	a4,0(s1)
 a4a:	853e                	mv	a0,a5
 a4c:	fef71ae3          	bne	a4,a5,a40 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a50:	8552                	mv	a0,s4
 a52:	00000097          	auipc	ra,0x0
 a56:	bce080e7          	jalr	-1074(ra) # 620 <sbrk>
  if(p == (char*)-1)
 a5a:	fd551ae3          	bne	a0,s5,a2e <malloc+0x7c>
        return 0;
 a5e:	4501                	li	a0,0
 a60:	74a2                	ld	s1,40(sp)
 a62:	6a42                	ld	s4,16(sp)
 a64:	6aa2                	ld	s5,8(sp)
 a66:	6b02                	ld	s6,0(sp)
 a68:	a03d                	j	a96 <malloc+0xe4>
 a6a:	74a2                	ld	s1,40(sp)
 a6c:	6a42                	ld	s4,16(sp)
 a6e:	6aa2                	ld	s5,8(sp)
 a70:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a72:	fae90be3          	beq	s2,a4,a28 <malloc+0x76>
        p->s.size -= nunits;
 a76:	4137073b          	subw	a4,a4,s3
 a7a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a7c:	02071693          	slli	a3,a4,0x20
 a80:	01c6d713          	srli	a4,a3,0x1c
 a84:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a86:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a8a:	00000717          	auipc	a4,0x0
 a8e:	58a73b23          	sd	a0,1430(a4) # 1020 <freep>
      return (void*)(p + 1);
 a92:	01078513          	addi	a0,a5,16
  }
}
 a96:	70e2                	ld	ra,56(sp)
 a98:	7442                	ld	s0,48(sp)
 a9a:	7902                	ld	s2,32(sp)
 a9c:	69e2                	ld	s3,24(sp)
 a9e:	6121                	addi	sp,sp,64
 aa0:	8082                	ret
 aa2:	74a2                	ld	s1,40(sp)
 aa4:	6a42                	ld	s4,16(sp)
 aa6:	6aa2                	ld	s5,8(sp)
 aa8:	6b02                	ld	s6,0(sp)
 aaa:	b7f5                	j	a96 <malloc+0xe4>
