
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	2c013103          	ld	sp,704(sp) # 8000b2c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	011050ef          	jal	80005826 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00029797          	auipc	a5,0x29
    80000034:	21078793          	addi	a5,a5,528 # 80029240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	0000c917          	auipc	s2,0xc
    80000054:	fe090913          	addi	s2,s2,-32 # 8000c030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	218080e7          	jalr	536(ra) # 80006272 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	2b4080e7          	jalr	692(ra) # 80006322 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f7e50513          	addi	a0,a0,-130 # 80008000 <etext>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	c68080e7          	jalr	-920(ra) # 80005cf2 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000009c:	6785                	lui	a5,0x1
    8000009e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a2:	00e504b3          	add	s1,a0,a4
    800000a6:	777d                	lui	a4,0xfffff
    800000a8:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	94be                	add	s1,s1,a5
    800000ac:	0295e463          	bltu	a1,s1,800000d4 <freerange+0x42>
    800000b0:	e84a                	sd	s2,16(sp)
    800000b2:	e44e                	sd	s3,8(sp)
    800000b4:	e052                	sd	s4,0(sp)
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	89be                	mv	s3,a5
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
    800000ce:	6942                	ld	s2,16(sp)
    800000d0:	69a2                	ld	s3,8(sp)
    800000d2:	6a02                	ld	s4,0(sp)
}
    800000d4:	70a2                	ld	ra,40(sp)
    800000d6:	7402                	ld	s0,32(sp)
    800000d8:	64e2                	ld	s1,24(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f2a58593          	addi	a1,a1,-214 # 80008010 <etext+0x10>
    800000ee:	0000c517          	auipc	a0,0xc
    800000f2:	f4250513          	addi	a0,a0,-190 # 8000c030 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	0e8080e7          	jalr	232(ra) # 800061de <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	00029517          	auipc	a0,0x29
    80000106:	13e50513          	addi	a0,a0,318 # 80029240 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	0000c497          	auipc	s1,0xc
    80000128:	f0c48493          	addi	s1,s1,-244 # 8000c030 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	144080e7          	jalr	324(ra) # 80006272 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	0000c517          	auipc	a0,0xc
    80000140:	ef450513          	addi	a0,a0,-268 # 8000c030 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	1dc080e7          	jalr	476(ra) # 80006322 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	0000c517          	auipc	a0,0xc
    8000016c:	ec850513          	addi	a0,a0,-312 # 8000c030 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	1b2080e7          	jalr	434(ra) # 80006322 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	addi	sp,sp,-16
    8000017c:	e406                	sd	ra,8(sp)
    8000017e:	e022                	sd	s0,0(sp)
    80000180:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000182:	ca19                	beqz	a2,80000198 <memset+0x1e>
    80000184:	87aa                	mv	a5,a0
    80000186:	1602                	slli	a2,a2,0x20
    80000188:	9201                	srli	a2,a2,0x20
    8000018a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x14>
  }
  return dst;
}
    80000198:	60a2                	ld	ra,8(sp)
    8000019a:	6402                	ld	s0,0(sp)
    8000019c:	0141                	addi	sp,sp,16
    8000019e:	8082                	ret

00000000800001a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800001a0:	1141                	addi	sp,sp,-16
    800001a2:	e406                	sd	ra,8(sp)
    800001a4:	e022                	sd	s0,0(sp)
    800001a6:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a8:	ca0d                	beqz	a2,800001da <memcmp+0x3a>
    800001aa:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001ae:	1682                	slli	a3,a3,0x20
    800001b0:	9281                	srli	a3,a3,0x20
    800001b2:	0685                	addi	a3,a3,1
    800001b4:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b6:	00054783          	lbu	a5,0(a0)
    800001ba:	0005c703          	lbu	a4,0(a1)
    800001be:	00e79863          	bne	a5,a4,800001ce <memcmp+0x2e>
      return *s1 - *s2;
    s1++, s2++;
    800001c2:	0505                	addi	a0,a0,1
    800001c4:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c6:	fed518e3          	bne	a0,a3,800001b6 <memcmp+0x16>
  }

  return 0;
    800001ca:	4501                	li	a0,0
    800001cc:	a019                	j	800001d2 <memcmp+0x32>
      return *s1 - *s2;
    800001ce:	40e7853b          	subw	a0,a5,a4
}
    800001d2:	60a2                	ld	ra,8(sp)
    800001d4:	6402                	ld	s0,0(sp)
    800001d6:	0141                	addi	sp,sp,16
    800001d8:	8082                	ret
  return 0;
    800001da:	4501                	li	a0,0
    800001dc:	bfdd                	j	800001d2 <memcmp+0x32>

00000000800001de <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001de:	1141                	addi	sp,sp,-16
    800001e0:	e406                	sd	ra,8(sp)
    800001e2:	e022                	sd	s0,0(sp)
    800001e4:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001e6:	c205                	beqz	a2,80000206 <memmove+0x28>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e8:	02a5e363          	bltu	a1,a0,8000020e <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001ec:	1602                	slli	a2,a2,0x20
    800001ee:	9201                	srli	a2,a2,0x20
    800001f0:	00c587b3          	add	a5,a1,a2
{
    800001f4:	872a                	mv	a4,a0
      *d++ = *s++;
    800001f6:	0585                	addi	a1,a1,1
    800001f8:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffd5dc1>
    800001fa:	fff5c683          	lbu	a3,-1(a1)
    800001fe:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000202:	feb79ae3          	bne	a5,a1,800001f6 <memmove+0x18>

  return dst;
}
    80000206:	60a2                	ld	ra,8(sp)
    80000208:	6402                	ld	s0,0(sp)
    8000020a:	0141                	addi	sp,sp,16
    8000020c:	8082                	ret
  if(s < d && s + n > d){
    8000020e:	02061693          	slli	a3,a2,0x20
    80000212:	9281                	srli	a3,a3,0x20
    80000214:	00d58733          	add	a4,a1,a3
    80000218:	fce57ae3          	bgeu	a0,a4,800001ec <memmove+0xe>
    d += n;
    8000021c:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    8000021e:	fff6079b          	addiw	a5,a2,-1
    80000222:	1782                	slli	a5,a5,0x20
    80000224:	9381                	srli	a5,a5,0x20
    80000226:	fff7c793          	not	a5,a5
    8000022a:	97ba                	add	a5,a5,a4
      *--d = *--s;
    8000022c:	177d                	addi	a4,a4,-1
    8000022e:	16fd                	addi	a3,a3,-1
    80000230:	00074603          	lbu	a2,0(a4)
    80000234:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000238:	fee79ae3          	bne	a5,a4,8000022c <memmove+0x4e>
    8000023c:	b7e9                	j	80000206 <memmove+0x28>

000000008000023e <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000023e:	1141                	addi	sp,sp,-16
    80000240:	e406                	sd	ra,8(sp)
    80000242:	e022                	sd	s0,0(sp)
    80000244:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000246:	00000097          	auipc	ra,0x0
    8000024a:	f98080e7          	jalr	-104(ra) # 800001de <memmove>
}
    8000024e:	60a2                	ld	ra,8(sp)
    80000250:	6402                	ld	s0,0(sp)
    80000252:	0141                	addi	sp,sp,16
    80000254:	8082                	ret

0000000080000256 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000256:	1141                	addi	sp,sp,-16
    80000258:	e406                	sd	ra,8(sp)
    8000025a:	e022                	sd	s0,0(sp)
    8000025c:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000025e:	ce11                	beqz	a2,8000027a <strncmp+0x24>
    80000260:	00054783          	lbu	a5,0(a0)
    80000264:	cf89                	beqz	a5,8000027e <strncmp+0x28>
    80000266:	0005c703          	lbu	a4,0(a1)
    8000026a:	00f71a63          	bne	a4,a5,8000027e <strncmp+0x28>
    n--, p++, q++;
    8000026e:	367d                	addiw	a2,a2,-1
    80000270:	0505                	addi	a0,a0,1
    80000272:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000274:	f675                	bnez	a2,80000260 <strncmp+0xa>
  if(n == 0)
    return 0;
    80000276:	4501                	li	a0,0
    80000278:	a801                	j	80000288 <strncmp+0x32>
    8000027a:	4501                	li	a0,0
    8000027c:	a031                	j	80000288 <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    8000027e:	00054503          	lbu	a0,0(a0)
    80000282:	0005c783          	lbu	a5,0(a1)
    80000286:	9d1d                	subw	a0,a0,a5
}
    80000288:	60a2                	ld	ra,8(sp)
    8000028a:	6402                	ld	s0,0(sp)
    8000028c:	0141                	addi	sp,sp,16
    8000028e:	8082                	ret

0000000080000290 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000290:	1141                	addi	sp,sp,-16
    80000292:	e406                	sd	ra,8(sp)
    80000294:	e022                	sd	s0,0(sp)
    80000296:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000298:	87aa                	mv	a5,a0
    8000029a:	86b2                	mv	a3,a2
    8000029c:	367d                	addiw	a2,a2,-1
    8000029e:	02d05563          	blez	a3,800002c8 <strncpy+0x38>
    800002a2:	0785                	addi	a5,a5,1
    800002a4:	0005c703          	lbu	a4,0(a1)
    800002a8:	fee78fa3          	sb	a4,-1(a5)
    800002ac:	0585                	addi	a1,a1,1
    800002ae:	f775                	bnez	a4,8000029a <strncpy+0xa>
    ;
  while(n-- > 0)
    800002b0:	873e                	mv	a4,a5
    800002b2:	00c05b63          	blez	a2,800002c8 <strncpy+0x38>
    800002b6:	9fb5                	addw	a5,a5,a3
    800002b8:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    800002ba:	0705                	addi	a4,a4,1
    800002bc:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002c0:	40e786bb          	subw	a3,a5,a4
    800002c4:	fed04be3          	bgtz	a3,800002ba <strncpy+0x2a>
  return os;
}
    800002c8:	60a2                	ld	ra,8(sp)
    800002ca:	6402                	ld	s0,0(sp)
    800002cc:	0141                	addi	sp,sp,16
    800002ce:	8082                	ret

00000000800002d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002d0:	1141                	addi	sp,sp,-16
    800002d2:	e406                	sd	ra,8(sp)
    800002d4:	e022                	sd	s0,0(sp)
    800002d6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d8:	02c05363          	blez	a2,800002fe <safestrcpy+0x2e>
    800002dc:	fff6069b          	addiw	a3,a2,-1
    800002e0:	1682                	slli	a3,a3,0x20
    800002e2:	9281                	srli	a3,a3,0x20
    800002e4:	96ae                	add	a3,a3,a1
    800002e6:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e8:	00d58963          	beq	a1,a3,800002fa <safestrcpy+0x2a>
    800002ec:	0585                	addi	a1,a1,1
    800002ee:	0785                	addi	a5,a5,1
    800002f0:	fff5c703          	lbu	a4,-1(a1)
    800002f4:	fee78fa3          	sb	a4,-1(a5)
    800002f8:	fb65                	bnez	a4,800002e8 <safestrcpy+0x18>
    ;
  *s = 0;
    800002fa:	00078023          	sb	zero,0(a5)
  return os;
}
    800002fe:	60a2                	ld	ra,8(sp)
    80000300:	6402                	ld	s0,0(sp)
    80000302:	0141                	addi	sp,sp,16
    80000304:	8082                	ret

0000000080000306 <strlen>:

int
strlen(const char *s)
{
    80000306:	1141                	addi	sp,sp,-16
    80000308:	e406                	sd	ra,8(sp)
    8000030a:	e022                	sd	s0,0(sp)
    8000030c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    8000030e:	00054783          	lbu	a5,0(a0)
    80000312:	cf99                	beqz	a5,80000330 <strlen+0x2a>
    80000314:	0505                	addi	a0,a0,1
    80000316:	87aa                	mv	a5,a0
    80000318:	86be                	mv	a3,a5
    8000031a:	0785                	addi	a5,a5,1
    8000031c:	fff7c703          	lbu	a4,-1(a5)
    80000320:	ff65                	bnez	a4,80000318 <strlen+0x12>
    80000322:	40a6853b          	subw	a0,a3,a0
    80000326:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    80000328:	60a2                	ld	ra,8(sp)
    8000032a:	6402                	ld	s0,0(sp)
    8000032c:	0141                	addi	sp,sp,16
    8000032e:	8082                	ret
  for(n = 0; s[n]; n++)
    80000330:	4501                	li	a0,0
    80000332:	bfdd                	j	80000328 <strlen+0x22>

0000000080000334 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000334:	1141                	addi	sp,sp,-16
    80000336:	e406                	sd	ra,8(sp)
    80000338:	e022                	sd	s0,0(sp)
    8000033a:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000033c:	00001097          	auipc	ra,0x1
    80000340:	b32080e7          	jalr	-1230(ra) # 80000e6e <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000344:	0000c717          	auipc	a4,0xc
    80000348:	cbc70713          	addi	a4,a4,-836 # 8000c000 <started>
  if(cpuid() == 0){
    8000034c:	c139                	beqz	a0,80000392 <main+0x5e>
    while(started == 0)
    8000034e:	431c                	lw	a5,0(a4)
    80000350:	2781                	sext.w	a5,a5
    80000352:	dff5                	beqz	a5,8000034e <main+0x1a>
      ;
    __sync_synchronize();
    80000354:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000358:	00001097          	auipc	ra,0x1
    8000035c:	b16080e7          	jalr	-1258(ra) # 80000e6e <cpuid>
    80000360:	85aa                	mv	a1,a0
    80000362:	00008517          	auipc	a0,0x8
    80000366:	cd650513          	addi	a0,a0,-810 # 80008038 <etext+0x38>
    8000036a:	00006097          	auipc	ra,0x6
    8000036e:	9d2080e7          	jalr	-1582(ra) # 80005d3c <printf>
    kvminithart();    // turn on paging
    80000372:	00000097          	auipc	ra,0x0
    80000376:	0d8080e7          	jalr	216(ra) # 8000044a <kvminithart>
    trapinithart();   // install kernel trap vector
    8000037a:	00001097          	auipc	ra,0x1
    8000037e:	786080e7          	jalr	1926(ra) # 80001b00 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000382:	00005097          	auipc	ra,0x5
    80000386:	e72080e7          	jalr	-398(ra) # 800051f4 <plicinithart>
  }

  scheduler();        
    8000038a:	00001097          	auipc	ra,0x1
    8000038e:	038080e7          	jalr	56(ra) # 800013c2 <scheduler>
    consoleinit();
    80000392:	00006097          	auipc	ra,0x6
    80000396:	882080e7          	jalr	-1918(ra) # 80005c14 <consoleinit>
    printfinit();
    8000039a:	00006097          	auipc	ra,0x6
    8000039e:	bac080e7          	jalr	-1108(ra) # 80005f46 <printfinit>
    printf("\n");
    800003a2:	00008517          	auipc	a0,0x8
    800003a6:	c7650513          	addi	a0,a0,-906 # 80008018 <etext+0x18>
    800003aa:	00006097          	auipc	ra,0x6
    800003ae:	992080e7          	jalr	-1646(ra) # 80005d3c <printf>
    printf("xv6 kernel is booting\n");
    800003b2:	00008517          	auipc	a0,0x8
    800003b6:	c6e50513          	addi	a0,a0,-914 # 80008020 <etext+0x20>
    800003ba:	00006097          	auipc	ra,0x6
    800003be:	982080e7          	jalr	-1662(ra) # 80005d3c <printf>
    printf("\n");
    800003c2:	00008517          	auipc	a0,0x8
    800003c6:	c5650513          	addi	a0,a0,-938 # 80008018 <etext+0x18>
    800003ca:	00006097          	auipc	ra,0x6
    800003ce:	972080e7          	jalr	-1678(ra) # 80005d3c <printf>
    kinit();         // physical page allocator
    800003d2:	00000097          	auipc	ra,0x0
    800003d6:	d0c080e7          	jalr	-756(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    800003da:	00000097          	auipc	ra,0x0
    800003de:	326080e7          	jalr	806(ra) # 80000700 <kvminit>
    kvminithart();   // turn on paging
    800003e2:	00000097          	auipc	ra,0x0
    800003e6:	068080e7          	jalr	104(ra) # 8000044a <kvminithart>
    procinit();      // process table
    800003ea:	00001097          	auipc	ra,0x1
    800003ee:	9cc080e7          	jalr	-1588(ra) # 80000db6 <procinit>
    trapinit();      // trap vectors
    800003f2:	00001097          	auipc	ra,0x1
    800003f6:	6e6080e7          	jalr	1766(ra) # 80001ad8 <trapinit>
    trapinithart();  // install kernel trap vector
    800003fa:	00001097          	auipc	ra,0x1
    800003fe:	706080e7          	jalr	1798(ra) # 80001b00 <trapinithart>
    plicinit();      // set up interrupt controller
    80000402:	00005097          	auipc	ra,0x5
    80000406:	dd8080e7          	jalr	-552(ra) # 800051da <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000040a:	00005097          	auipc	ra,0x5
    8000040e:	dea080e7          	jalr	-534(ra) # 800051f4 <plicinithart>
    binit();         // buffer cache
    80000412:	00002097          	auipc	ra,0x2
    80000416:	eb2080e7          	jalr	-334(ra) # 800022c4 <binit>
    iinit();         // inode table
    8000041a:	00002097          	auipc	ra,0x2
    8000041e:	520080e7          	jalr	1312(ra) # 8000293a <iinit>
    fileinit();      // file table
    80000422:	00003097          	auipc	ra,0x3
    80000426:	4ea080e7          	jalr	1258(ra) # 8000390c <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000042a:	00005097          	auipc	ra,0x5
    8000042e:	eea080e7          	jalr	-278(ra) # 80005314 <virtio_disk_init>
    userinit();      // first user process
    80000432:	00001097          	auipc	ra,0x1
    80000436:	d4c080e7          	jalr	-692(ra) # 8000117e <userinit>
    __sync_synchronize();
    8000043a:	0330000f          	fence	rw,rw
    started = 1;
    8000043e:	4785                	li	a5,1
    80000440:	0000c717          	auipc	a4,0xc
    80000444:	bcf72023          	sw	a5,-1088(a4) # 8000c000 <started>
    80000448:	b789                	j	8000038a <main+0x56>

000000008000044a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000044a:	1141                	addi	sp,sp,-16
    8000044c:	e406                	sd	ra,8(sp)
    8000044e:	e022                	sd	s0,0(sp)
    80000450:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000452:	0000c797          	auipc	a5,0xc
    80000456:	bb67b783          	ld	a5,-1098(a5) # 8000c008 <kernel_pagetable>
    8000045a:	83b1                	srli	a5,a5,0xc
    8000045c:	577d                	li	a4,-1
    8000045e:	177e                	slli	a4,a4,0x3f
    80000460:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000462:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000466:	12000073          	sfence.vma
  sfence_vma();
}
    8000046a:	60a2                	ld	ra,8(sp)
    8000046c:	6402                	ld	s0,0(sp)
    8000046e:	0141                	addi	sp,sp,16
    80000470:	8082                	ret

0000000080000472 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000472:	7139                	addi	sp,sp,-64
    80000474:	fc06                	sd	ra,56(sp)
    80000476:	f822                	sd	s0,48(sp)
    80000478:	f426                	sd	s1,40(sp)
    8000047a:	f04a                	sd	s2,32(sp)
    8000047c:	ec4e                	sd	s3,24(sp)
    8000047e:	e852                	sd	s4,16(sp)
    80000480:	e456                	sd	s5,8(sp)
    80000482:	e05a                	sd	s6,0(sp)
    80000484:	0080                	addi	s0,sp,64
    80000486:	84aa                	mv	s1,a0
    80000488:	89ae                	mv	s3,a1
    8000048a:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000048c:	57fd                	li	a5,-1
    8000048e:	83e9                	srli	a5,a5,0x1a
    80000490:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000492:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000494:	04b7e263          	bltu	a5,a1,800004d8 <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    80000498:	0149d933          	srl	s2,s3,s4
    8000049c:	1ff97913          	andi	s2,s2,511
    800004a0:	090e                	slli	s2,s2,0x3
    800004a2:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004a4:	00093483          	ld	s1,0(s2)
    800004a8:	0014f793          	andi	a5,s1,1
    800004ac:	cf95                	beqz	a5,800004e8 <walk+0x76>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004ae:	80a9                	srli	s1,s1,0xa
    800004b0:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    800004b2:	3a5d                	addiw	s4,s4,-9
    800004b4:	ff6a12e3          	bne	s4,s6,80000498 <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    800004b8:	00c9d513          	srli	a0,s3,0xc
    800004bc:	1ff57513          	andi	a0,a0,511
    800004c0:	050e                	slli	a0,a0,0x3
    800004c2:	9526                	add	a0,a0,s1
}
    800004c4:	70e2                	ld	ra,56(sp)
    800004c6:	7442                	ld	s0,48(sp)
    800004c8:	74a2                	ld	s1,40(sp)
    800004ca:	7902                	ld	s2,32(sp)
    800004cc:	69e2                	ld	s3,24(sp)
    800004ce:	6a42                	ld	s4,16(sp)
    800004d0:	6aa2                	ld	s5,8(sp)
    800004d2:	6b02                	ld	s6,0(sp)
    800004d4:	6121                	addi	sp,sp,64
    800004d6:	8082                	ret
    panic("walk");
    800004d8:	00008517          	auipc	a0,0x8
    800004dc:	b7850513          	addi	a0,a0,-1160 # 80008050 <etext+0x50>
    800004e0:	00006097          	auipc	ra,0x6
    800004e4:	812080e7          	jalr	-2030(ra) # 80005cf2 <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800004e8:	020a8663          	beqz	s5,80000514 <walk+0xa2>
    800004ec:	00000097          	auipc	ra,0x0
    800004f0:	c2e080e7          	jalr	-978(ra) # 8000011a <kalloc>
    800004f4:	84aa                	mv	s1,a0
    800004f6:	d579                	beqz	a0,800004c4 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    800004f8:	6605                	lui	a2,0x1
    800004fa:	4581                	li	a1,0
    800004fc:	00000097          	auipc	ra,0x0
    80000500:	c7e080e7          	jalr	-898(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000504:	00c4d793          	srli	a5,s1,0xc
    80000508:	07aa                	slli	a5,a5,0xa
    8000050a:	0017e793          	ori	a5,a5,1
    8000050e:	00f93023          	sd	a5,0(s2)
    80000512:	b745                	j	800004b2 <walk+0x40>
        return 0;
    80000514:	4501                	li	a0,0
    80000516:	b77d                	j	800004c4 <walk+0x52>

0000000080000518 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000518:	57fd                	li	a5,-1
    8000051a:	83e9                	srli	a5,a5,0x1a
    8000051c:	00b7f463          	bgeu	a5,a1,80000524 <walkaddr+0xc>
    return 0;
    80000520:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000522:	8082                	ret
{
    80000524:	1141                	addi	sp,sp,-16
    80000526:	e406                	sd	ra,8(sp)
    80000528:	e022                	sd	s0,0(sp)
    8000052a:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000052c:	4601                	li	a2,0
    8000052e:	00000097          	auipc	ra,0x0
    80000532:	f44080e7          	jalr	-188(ra) # 80000472 <walk>
  if(pte == 0)
    80000536:	c105                	beqz	a0,80000556 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000538:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000053a:	0117f693          	andi	a3,a5,17
    8000053e:	4745                	li	a4,17
    return 0;
    80000540:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000542:	00e68663          	beq	a3,a4,8000054e <walkaddr+0x36>
}
    80000546:	60a2                	ld	ra,8(sp)
    80000548:	6402                	ld	s0,0(sp)
    8000054a:	0141                	addi	sp,sp,16
    8000054c:	8082                	ret
  pa = PTE2PA(*pte);
    8000054e:	83a9                	srli	a5,a5,0xa
    80000550:	00c79513          	slli	a0,a5,0xc
  return pa;
    80000554:	bfcd                	j	80000546 <walkaddr+0x2e>
    return 0;
    80000556:	4501                	li	a0,0
    80000558:	b7fd                	j	80000546 <walkaddr+0x2e>

000000008000055a <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000055a:	715d                	addi	sp,sp,-80
    8000055c:	e486                	sd	ra,72(sp)
    8000055e:	e0a2                	sd	s0,64(sp)
    80000560:	fc26                	sd	s1,56(sp)
    80000562:	f84a                	sd	s2,48(sp)
    80000564:	f44e                	sd	s3,40(sp)
    80000566:	f052                	sd	s4,32(sp)
    80000568:	ec56                	sd	s5,24(sp)
    8000056a:	e85a                	sd	s6,16(sp)
    8000056c:	e45e                	sd	s7,8(sp)
    8000056e:	e062                	sd	s8,0(sp)
    80000570:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000572:	ca21                	beqz	a2,800005c2 <mappages+0x68>
    80000574:	8aaa                	mv	s5,a0
    80000576:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80000578:	777d                	lui	a4,0xfffff
    8000057a:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    8000057e:	fff58993          	addi	s3,a1,-1
    80000582:	99b2                	add	s3,s3,a2
    80000584:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    80000588:	893e                	mv	s2,a5
    8000058a:	40f68a33          	sub	s4,a3,a5
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    8000058e:	4b85                	li	s7,1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000590:	6c05                	lui	s8,0x1
    80000592:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    80000596:	865e                	mv	a2,s7
    80000598:	85ca                	mv	a1,s2
    8000059a:	8556                	mv	a0,s5
    8000059c:	00000097          	auipc	ra,0x0
    800005a0:	ed6080e7          	jalr	-298(ra) # 80000472 <walk>
    800005a4:	cd1d                	beqz	a0,800005e2 <mappages+0x88>
    if(*pte & PTE_V)
    800005a6:	611c                	ld	a5,0(a0)
    800005a8:	8b85                	andi	a5,a5,1
    800005aa:	e785                	bnez	a5,800005d2 <mappages+0x78>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005ac:	80b1                	srli	s1,s1,0xc
    800005ae:	04aa                	slli	s1,s1,0xa
    800005b0:	0164e4b3          	or	s1,s1,s6
    800005b4:	0014e493          	ori	s1,s1,1
    800005b8:	e104                	sd	s1,0(a0)
    if(a == last)
    800005ba:	05390163          	beq	s2,s3,800005fc <mappages+0xa2>
    a += PGSIZE;
    800005be:	9962                	add	s2,s2,s8
    if((pte = walk(pagetable, a, 1)) == 0)
    800005c0:	bfc9                	j	80000592 <mappages+0x38>
    panic("mappages: size");
    800005c2:	00008517          	auipc	a0,0x8
    800005c6:	a9650513          	addi	a0,a0,-1386 # 80008058 <etext+0x58>
    800005ca:	00005097          	auipc	ra,0x5
    800005ce:	728080e7          	jalr	1832(ra) # 80005cf2 <panic>
      panic("mappages: remap");
    800005d2:	00008517          	auipc	a0,0x8
    800005d6:	a9650513          	addi	a0,a0,-1386 # 80008068 <etext+0x68>
    800005da:	00005097          	auipc	ra,0x5
    800005de:	718080e7          	jalr	1816(ra) # 80005cf2 <panic>
      return -1;
    800005e2:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005e4:	60a6                	ld	ra,72(sp)
    800005e6:	6406                	ld	s0,64(sp)
    800005e8:	74e2                	ld	s1,56(sp)
    800005ea:	7942                	ld	s2,48(sp)
    800005ec:	79a2                	ld	s3,40(sp)
    800005ee:	7a02                	ld	s4,32(sp)
    800005f0:	6ae2                	ld	s5,24(sp)
    800005f2:	6b42                	ld	s6,16(sp)
    800005f4:	6ba2                	ld	s7,8(sp)
    800005f6:	6c02                	ld	s8,0(sp)
    800005f8:	6161                	addi	sp,sp,80
    800005fa:	8082                	ret
  return 0;
    800005fc:	4501                	li	a0,0
    800005fe:	b7dd                	j	800005e4 <mappages+0x8a>

0000000080000600 <kvmmap>:
{
    80000600:	1141                	addi	sp,sp,-16
    80000602:	e406                	sd	ra,8(sp)
    80000604:	e022                	sd	s0,0(sp)
    80000606:	0800                	addi	s0,sp,16
    80000608:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000060a:	86b2                	mv	a3,a2
    8000060c:	863e                	mv	a2,a5
    8000060e:	00000097          	auipc	ra,0x0
    80000612:	f4c080e7          	jalr	-180(ra) # 8000055a <mappages>
    80000616:	e509                	bnez	a0,80000620 <kvmmap+0x20>
}
    80000618:	60a2                	ld	ra,8(sp)
    8000061a:	6402                	ld	s0,0(sp)
    8000061c:	0141                	addi	sp,sp,16
    8000061e:	8082                	ret
    panic("kvmmap");
    80000620:	00008517          	auipc	a0,0x8
    80000624:	a5850513          	addi	a0,a0,-1448 # 80008078 <etext+0x78>
    80000628:	00005097          	auipc	ra,0x5
    8000062c:	6ca080e7          	jalr	1738(ra) # 80005cf2 <panic>

0000000080000630 <kvmmake>:
{
    80000630:	1101                	addi	sp,sp,-32
    80000632:	ec06                	sd	ra,24(sp)
    80000634:	e822                	sd	s0,16(sp)
    80000636:	e426                	sd	s1,8(sp)
    80000638:	e04a                	sd	s2,0(sp)
    8000063a:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000063c:	00000097          	auipc	ra,0x0
    80000640:	ade080e7          	jalr	-1314(ra) # 8000011a <kalloc>
    80000644:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000646:	6605                	lui	a2,0x1
    80000648:	4581                	li	a1,0
    8000064a:	00000097          	auipc	ra,0x0
    8000064e:	b30080e7          	jalr	-1232(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000652:	4719                	li	a4,6
    80000654:	6685                	lui	a3,0x1
    80000656:	10000637          	lui	a2,0x10000
    8000065a:	85b2                	mv	a1,a2
    8000065c:	8526                	mv	a0,s1
    8000065e:	00000097          	auipc	ra,0x0
    80000662:	fa2080e7          	jalr	-94(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000666:	4719                	li	a4,6
    80000668:	6685                	lui	a3,0x1
    8000066a:	10001637          	lui	a2,0x10001
    8000066e:	85b2                	mv	a1,a2
    80000670:	8526                	mv	a0,s1
    80000672:	00000097          	auipc	ra,0x0
    80000676:	f8e080e7          	jalr	-114(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    8000067a:	4719                	li	a4,6
    8000067c:	004006b7          	lui	a3,0x400
    80000680:	0c000637          	lui	a2,0xc000
    80000684:	85b2                	mv	a1,a2
    80000686:	8526                	mv	a0,s1
    80000688:	00000097          	auipc	ra,0x0
    8000068c:	f78080e7          	jalr	-136(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000690:	00008917          	auipc	s2,0x8
    80000694:	97090913          	addi	s2,s2,-1680 # 80008000 <etext>
    80000698:	4729                	li	a4,10
    8000069a:	80008697          	auipc	a3,0x80008
    8000069e:	96668693          	addi	a3,a3,-1690 # 8000 <_entry-0x7fff8000>
    800006a2:	4605                	li	a2,1
    800006a4:	067e                	slli	a2,a2,0x1f
    800006a6:	85b2                	mv	a1,a2
    800006a8:	8526                	mv	a0,s1
    800006aa:	00000097          	auipc	ra,0x0
    800006ae:	f56080e7          	jalr	-170(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006b2:	4719                	li	a4,6
    800006b4:	46c5                	li	a3,17
    800006b6:	06ee                	slli	a3,a3,0x1b
    800006b8:	412686b3          	sub	a3,a3,s2
    800006bc:	864a                	mv	a2,s2
    800006be:	85ca                	mv	a1,s2
    800006c0:	8526                	mv	a0,s1
    800006c2:	00000097          	auipc	ra,0x0
    800006c6:	f3e080e7          	jalr	-194(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006ca:	4729                	li	a4,10
    800006cc:	6685                	lui	a3,0x1
    800006ce:	00007617          	auipc	a2,0x7
    800006d2:	93260613          	addi	a2,a2,-1742 # 80007000 <_trampoline>
    800006d6:	040005b7          	lui	a1,0x4000
    800006da:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006dc:	05b2                	slli	a1,a1,0xc
    800006de:	8526                	mv	a0,s1
    800006e0:	00000097          	auipc	ra,0x0
    800006e4:	f20080e7          	jalr	-224(ra) # 80000600 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006e8:	8526                	mv	a0,s1
    800006ea:	00000097          	auipc	ra,0x0
    800006ee:	622080e7          	jalr	1570(ra) # 80000d0c <proc_mapstacks>
}
    800006f2:	8526                	mv	a0,s1
    800006f4:	60e2                	ld	ra,24(sp)
    800006f6:	6442                	ld	s0,16(sp)
    800006f8:	64a2                	ld	s1,8(sp)
    800006fa:	6902                	ld	s2,0(sp)
    800006fc:	6105                	addi	sp,sp,32
    800006fe:	8082                	ret

0000000080000700 <kvminit>:
{
    80000700:	1141                	addi	sp,sp,-16
    80000702:	e406                	sd	ra,8(sp)
    80000704:	e022                	sd	s0,0(sp)
    80000706:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000708:	00000097          	auipc	ra,0x0
    8000070c:	f28080e7          	jalr	-216(ra) # 80000630 <kvmmake>
    80000710:	0000c797          	auipc	a5,0xc
    80000714:	8ea7bc23          	sd	a0,-1800(a5) # 8000c008 <kernel_pagetable>
}
    80000718:	60a2                	ld	ra,8(sp)
    8000071a:	6402                	ld	s0,0(sp)
    8000071c:	0141                	addi	sp,sp,16
    8000071e:	8082                	ret

0000000080000720 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000720:	715d                	addi	sp,sp,-80
    80000722:	e486                	sd	ra,72(sp)
    80000724:	e0a2                	sd	s0,64(sp)
    80000726:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000728:	03459793          	slli	a5,a1,0x34
    8000072c:	e39d                	bnez	a5,80000752 <uvmunmap+0x32>
    8000072e:	f84a                	sd	s2,48(sp)
    80000730:	f44e                	sd	s3,40(sp)
    80000732:	f052                	sd	s4,32(sp)
    80000734:	ec56                	sd	s5,24(sp)
    80000736:	e85a                	sd	s6,16(sp)
    80000738:	e45e                	sd	s7,8(sp)
    8000073a:	8a2a                	mv	s4,a0
    8000073c:	892e                	mv	s2,a1
    8000073e:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000740:	0632                	slli	a2,a2,0xc
    80000742:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000746:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000748:	6b05                	lui	s6,0x1
    8000074a:	0935fb63          	bgeu	a1,s3,800007e0 <uvmunmap+0xc0>
    8000074e:	fc26                	sd	s1,56(sp)
    80000750:	a8a9                	j	800007aa <uvmunmap+0x8a>
    80000752:	fc26                	sd	s1,56(sp)
    80000754:	f84a                	sd	s2,48(sp)
    80000756:	f44e                	sd	s3,40(sp)
    80000758:	f052                	sd	s4,32(sp)
    8000075a:	ec56                	sd	s5,24(sp)
    8000075c:	e85a                	sd	s6,16(sp)
    8000075e:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    80000760:	00008517          	auipc	a0,0x8
    80000764:	92050513          	addi	a0,a0,-1760 # 80008080 <etext+0x80>
    80000768:	00005097          	auipc	ra,0x5
    8000076c:	58a080e7          	jalr	1418(ra) # 80005cf2 <panic>
      panic("uvmunmap: walk");
    80000770:	00008517          	auipc	a0,0x8
    80000774:	92850513          	addi	a0,a0,-1752 # 80008098 <etext+0x98>
    80000778:	00005097          	auipc	ra,0x5
    8000077c:	57a080e7          	jalr	1402(ra) # 80005cf2 <panic>
      panic("uvmunmap: not mapped");
    80000780:	00008517          	auipc	a0,0x8
    80000784:	92850513          	addi	a0,a0,-1752 # 800080a8 <etext+0xa8>
    80000788:	00005097          	auipc	ra,0x5
    8000078c:	56a080e7          	jalr	1386(ra) # 80005cf2 <panic>
      panic("uvmunmap: not a leaf");
    80000790:	00008517          	auipc	a0,0x8
    80000794:	93050513          	addi	a0,a0,-1744 # 800080c0 <etext+0xc0>
    80000798:	00005097          	auipc	ra,0x5
    8000079c:	55a080e7          	jalr	1370(ra) # 80005cf2 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800007a0:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007a4:	995a                	add	s2,s2,s6
    800007a6:	03397c63          	bgeu	s2,s3,800007de <uvmunmap+0xbe>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007aa:	4601                	li	a2,0
    800007ac:	85ca                	mv	a1,s2
    800007ae:	8552                	mv	a0,s4
    800007b0:	00000097          	auipc	ra,0x0
    800007b4:	cc2080e7          	jalr	-830(ra) # 80000472 <walk>
    800007b8:	84aa                	mv	s1,a0
    800007ba:	d95d                	beqz	a0,80000770 <uvmunmap+0x50>
    if((*pte & PTE_V) == 0)
    800007bc:	6108                	ld	a0,0(a0)
    800007be:	00157793          	andi	a5,a0,1
    800007c2:	dfdd                	beqz	a5,80000780 <uvmunmap+0x60>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007c4:	3ff57793          	andi	a5,a0,1023
    800007c8:	fd7784e3          	beq	a5,s7,80000790 <uvmunmap+0x70>
    if(do_free){
    800007cc:	fc0a8ae3          	beqz	s5,800007a0 <uvmunmap+0x80>
      uint64 pa = PTE2PA(*pte);
    800007d0:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800007d2:	0532                	slli	a0,a0,0xc
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	848080e7          	jalr	-1976(ra) # 8000001c <kfree>
    800007dc:	b7d1                	j	800007a0 <uvmunmap+0x80>
    800007de:	74e2                	ld	s1,56(sp)
    800007e0:	7942                	ld	s2,48(sp)
    800007e2:	79a2                	ld	s3,40(sp)
    800007e4:	7a02                	ld	s4,32(sp)
    800007e6:	6ae2                	ld	s5,24(sp)
    800007e8:	6b42                	ld	s6,16(sp)
    800007ea:	6ba2                	ld	s7,8(sp)
  }
}
    800007ec:	60a6                	ld	ra,72(sp)
    800007ee:	6406                	ld	s0,64(sp)
    800007f0:	6161                	addi	sp,sp,80
    800007f2:	8082                	ret

00000000800007f4 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007f4:	1101                	addi	sp,sp,-32
    800007f6:	ec06                	sd	ra,24(sp)
    800007f8:	e822                	sd	s0,16(sp)
    800007fa:	e426                	sd	s1,8(sp)
    800007fc:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007fe:	00000097          	auipc	ra,0x0
    80000802:	91c080e7          	jalr	-1764(ra) # 8000011a <kalloc>
    80000806:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000808:	c519                	beqz	a0,80000816 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000080a:	6605                	lui	a2,0x1
    8000080c:	4581                	li	a1,0
    8000080e:	00000097          	auipc	ra,0x0
    80000812:	96c080e7          	jalr	-1684(ra) # 8000017a <memset>
  return pagetable;
}
    80000816:	8526                	mv	a0,s1
    80000818:	60e2                	ld	ra,24(sp)
    8000081a:	6442                	ld	s0,16(sp)
    8000081c:	64a2                	ld	s1,8(sp)
    8000081e:	6105                	addi	sp,sp,32
    80000820:	8082                	ret

0000000080000822 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80000822:	7179                	addi	sp,sp,-48
    80000824:	f406                	sd	ra,40(sp)
    80000826:	f022                	sd	s0,32(sp)
    80000828:	ec26                	sd	s1,24(sp)
    8000082a:	e84a                	sd	s2,16(sp)
    8000082c:	e44e                	sd	s3,8(sp)
    8000082e:	e052                	sd	s4,0(sp)
    80000830:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000832:	6785                	lui	a5,0x1
    80000834:	04f67863          	bgeu	a2,a5,80000884 <uvminit+0x62>
    80000838:	8a2a                	mv	s4,a0
    8000083a:	89ae                	mv	s3,a1
    8000083c:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    8000083e:	00000097          	auipc	ra,0x0
    80000842:	8dc080e7          	jalr	-1828(ra) # 8000011a <kalloc>
    80000846:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000848:	6605                	lui	a2,0x1
    8000084a:	4581                	li	a1,0
    8000084c:	00000097          	auipc	ra,0x0
    80000850:	92e080e7          	jalr	-1746(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000854:	4779                	li	a4,30
    80000856:	86ca                	mv	a3,s2
    80000858:	6605                	lui	a2,0x1
    8000085a:	4581                	li	a1,0
    8000085c:	8552                	mv	a0,s4
    8000085e:	00000097          	auipc	ra,0x0
    80000862:	cfc080e7          	jalr	-772(ra) # 8000055a <mappages>
  memmove(mem, src, sz);
    80000866:	8626                	mv	a2,s1
    80000868:	85ce                	mv	a1,s3
    8000086a:	854a                	mv	a0,s2
    8000086c:	00000097          	auipc	ra,0x0
    80000870:	972080e7          	jalr	-1678(ra) # 800001de <memmove>
}
    80000874:	70a2                	ld	ra,40(sp)
    80000876:	7402                	ld	s0,32(sp)
    80000878:	64e2                	ld	s1,24(sp)
    8000087a:	6942                	ld	s2,16(sp)
    8000087c:	69a2                	ld	s3,8(sp)
    8000087e:	6a02                	ld	s4,0(sp)
    80000880:	6145                	addi	sp,sp,48
    80000882:	8082                	ret
    panic("inituvm: more than a page");
    80000884:	00008517          	auipc	a0,0x8
    80000888:	85450513          	addi	a0,a0,-1964 # 800080d8 <etext+0xd8>
    8000088c:	00005097          	auipc	ra,0x5
    80000890:	466080e7          	jalr	1126(ra) # 80005cf2 <panic>

0000000080000894 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000894:	1101                	addi	sp,sp,-32
    80000896:	ec06                	sd	ra,24(sp)
    80000898:	e822                	sd	s0,16(sp)
    8000089a:	e426                	sd	s1,8(sp)
    8000089c:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    8000089e:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008a0:	00b67d63          	bgeu	a2,a1,800008ba <uvmdealloc+0x26>
    800008a4:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008a6:	6785                	lui	a5,0x1
    800008a8:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008aa:	00f60733          	add	a4,a2,a5
    800008ae:	76fd                	lui	a3,0xfffff
    800008b0:	8f75                	and	a4,a4,a3
    800008b2:	97ae                	add	a5,a5,a1
    800008b4:	8ff5                	and	a5,a5,a3
    800008b6:	00f76863          	bltu	a4,a5,800008c6 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800008ba:	8526                	mv	a0,s1
    800008bc:	60e2                	ld	ra,24(sp)
    800008be:	6442                	ld	s0,16(sp)
    800008c0:	64a2                	ld	s1,8(sp)
    800008c2:	6105                	addi	sp,sp,32
    800008c4:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008c6:	8f99                	sub	a5,a5,a4
    800008c8:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008ca:	4685                	li	a3,1
    800008cc:	0007861b          	sext.w	a2,a5
    800008d0:	85ba                	mv	a1,a4
    800008d2:	00000097          	auipc	ra,0x0
    800008d6:	e4e080e7          	jalr	-434(ra) # 80000720 <uvmunmap>
    800008da:	b7c5                	j	800008ba <uvmdealloc+0x26>

00000000800008dc <uvmalloc>:
  if(newsz < oldsz)
    800008dc:	0ab66e63          	bltu	a2,a1,80000998 <uvmalloc+0xbc>
{
    800008e0:	715d                	addi	sp,sp,-80
    800008e2:	e486                	sd	ra,72(sp)
    800008e4:	e0a2                	sd	s0,64(sp)
    800008e6:	f052                	sd	s4,32(sp)
    800008e8:	ec56                	sd	s5,24(sp)
    800008ea:	e85a                	sd	s6,16(sp)
    800008ec:	0880                	addi	s0,sp,80
    800008ee:	8b2a                	mv	s6,a0
    800008f0:	8ab2                	mv	s5,a2
  oldsz = PGROUNDUP(oldsz);
    800008f2:	6785                	lui	a5,0x1
    800008f4:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008f6:	95be                	add	a1,a1,a5
    800008f8:	77fd                	lui	a5,0xfffff
    800008fa:	00f5fa33          	and	s4,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008fe:	08ca7f63          	bgeu	s4,a2,8000099c <uvmalloc+0xc0>
    80000902:	fc26                	sd	s1,56(sp)
    80000904:	f84a                	sd	s2,48(sp)
    80000906:	f44e                	sd	s3,40(sp)
    80000908:	e45e                	sd	s7,8(sp)
    8000090a:	8952                	mv	s2,s4
    memset(mem, 0, PGSIZE);
    8000090c:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    8000090e:	4bf9                	li	s7,30
    mem = kalloc();
    80000910:	00000097          	auipc	ra,0x0
    80000914:	80a080e7          	jalr	-2038(ra) # 8000011a <kalloc>
    80000918:	84aa                	mv	s1,a0
    if(mem == 0){
    8000091a:	c915                	beqz	a0,8000094e <uvmalloc+0x72>
    memset(mem, 0, PGSIZE);
    8000091c:	864e                	mv	a2,s3
    8000091e:	4581                	li	a1,0
    80000920:	00000097          	auipc	ra,0x0
    80000924:	85a080e7          	jalr	-1958(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80000928:	875e                	mv	a4,s7
    8000092a:	86a6                	mv	a3,s1
    8000092c:	864e                	mv	a2,s3
    8000092e:	85ca                	mv	a1,s2
    80000930:	855a                	mv	a0,s6
    80000932:	00000097          	auipc	ra,0x0
    80000936:	c28080e7          	jalr	-984(ra) # 8000055a <mappages>
    8000093a:	ed0d                	bnez	a0,80000974 <uvmalloc+0x98>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000093c:	994e                	add	s2,s2,s3
    8000093e:	fd5969e3          	bltu	s2,s5,80000910 <uvmalloc+0x34>
  return newsz;
    80000942:	8556                	mv	a0,s5
    80000944:	74e2                	ld	s1,56(sp)
    80000946:	7942                	ld	s2,48(sp)
    80000948:	79a2                	ld	s3,40(sp)
    8000094a:	6ba2                	ld	s7,8(sp)
    8000094c:	a829                	j	80000966 <uvmalloc+0x8a>
      uvmdealloc(pagetable, a, oldsz);
    8000094e:	8652                	mv	a2,s4
    80000950:	85ca                	mv	a1,s2
    80000952:	855a                	mv	a0,s6
    80000954:	00000097          	auipc	ra,0x0
    80000958:	f40080e7          	jalr	-192(ra) # 80000894 <uvmdealloc>
      return 0;
    8000095c:	4501                	li	a0,0
    8000095e:	74e2                	ld	s1,56(sp)
    80000960:	7942                	ld	s2,48(sp)
    80000962:	79a2                	ld	s3,40(sp)
    80000964:	6ba2                	ld	s7,8(sp)
}
    80000966:	60a6                	ld	ra,72(sp)
    80000968:	6406                	ld	s0,64(sp)
    8000096a:	7a02                	ld	s4,32(sp)
    8000096c:	6ae2                	ld	s5,24(sp)
    8000096e:	6b42                	ld	s6,16(sp)
    80000970:	6161                	addi	sp,sp,80
    80000972:	8082                	ret
      kfree(mem);
    80000974:	8526                	mv	a0,s1
    80000976:	fffff097          	auipc	ra,0xfffff
    8000097a:	6a6080e7          	jalr	1702(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    8000097e:	8652                	mv	a2,s4
    80000980:	85ca                	mv	a1,s2
    80000982:	855a                	mv	a0,s6
    80000984:	00000097          	auipc	ra,0x0
    80000988:	f10080e7          	jalr	-240(ra) # 80000894 <uvmdealloc>
      return 0;
    8000098c:	4501                	li	a0,0
    8000098e:	74e2                	ld	s1,56(sp)
    80000990:	7942                	ld	s2,48(sp)
    80000992:	79a2                	ld	s3,40(sp)
    80000994:	6ba2                	ld	s7,8(sp)
    80000996:	bfc1                	j	80000966 <uvmalloc+0x8a>
    return oldsz;
    80000998:	852e                	mv	a0,a1
}
    8000099a:	8082                	ret
  return newsz;
    8000099c:	8532                	mv	a0,a2
    8000099e:	b7e1                	j	80000966 <uvmalloc+0x8a>

00000000800009a0 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800009a0:	7179                	addi	sp,sp,-48
    800009a2:	f406                	sd	ra,40(sp)
    800009a4:	f022                	sd	s0,32(sp)
    800009a6:	ec26                	sd	s1,24(sp)
    800009a8:	e84a                	sd	s2,16(sp)
    800009aa:	e44e                	sd	s3,8(sp)
    800009ac:	e052                	sd	s4,0(sp)
    800009ae:	1800                	addi	s0,sp,48
    800009b0:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009b2:	84aa                	mv	s1,a0
    800009b4:	6905                	lui	s2,0x1
    800009b6:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009b8:	4985                	li	s3,1
    800009ba:	a829                	j	800009d4 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800009bc:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800009be:	00c79513          	slli	a0,a5,0xc
    800009c2:	00000097          	auipc	ra,0x0
    800009c6:	fde080e7          	jalr	-34(ra) # 800009a0 <freewalk>
      pagetable[i] = 0;
    800009ca:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800009ce:	04a1                	addi	s1,s1,8
    800009d0:	03248163          	beq	s1,s2,800009f2 <freewalk+0x52>
    pte_t pte = pagetable[i];
    800009d4:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009d6:	00f7f713          	andi	a4,a5,15
    800009da:	ff3701e3          	beq	a4,s3,800009bc <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009de:	8b85                	andi	a5,a5,1
    800009e0:	d7fd                	beqz	a5,800009ce <freewalk+0x2e>
      panic("freewalk: leaf");
    800009e2:	00007517          	auipc	a0,0x7
    800009e6:	71650513          	addi	a0,a0,1814 # 800080f8 <etext+0xf8>
    800009ea:	00005097          	auipc	ra,0x5
    800009ee:	308080e7          	jalr	776(ra) # 80005cf2 <panic>
    }
  }
  kfree((void*)pagetable);
    800009f2:	8552                	mv	a0,s4
    800009f4:	fffff097          	auipc	ra,0xfffff
    800009f8:	628080e7          	jalr	1576(ra) # 8000001c <kfree>
}
    800009fc:	70a2                	ld	ra,40(sp)
    800009fe:	7402                	ld	s0,32(sp)
    80000a00:	64e2                	ld	s1,24(sp)
    80000a02:	6942                	ld	s2,16(sp)
    80000a04:	69a2                	ld	s3,8(sp)
    80000a06:	6a02                	ld	s4,0(sp)
    80000a08:	6145                	addi	sp,sp,48
    80000a0a:	8082                	ret

0000000080000a0c <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a0c:	1101                	addi	sp,sp,-32
    80000a0e:	ec06                	sd	ra,24(sp)
    80000a10:	e822                	sd	s0,16(sp)
    80000a12:	e426                	sd	s1,8(sp)
    80000a14:	1000                	addi	s0,sp,32
    80000a16:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a18:	e999                	bnez	a1,80000a2e <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a1a:	8526                	mv	a0,s1
    80000a1c:	00000097          	auipc	ra,0x0
    80000a20:	f84080e7          	jalr	-124(ra) # 800009a0 <freewalk>
}
    80000a24:	60e2                	ld	ra,24(sp)
    80000a26:	6442                	ld	s0,16(sp)
    80000a28:	64a2                	ld	s1,8(sp)
    80000a2a:	6105                	addi	sp,sp,32
    80000a2c:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a2e:	6785                	lui	a5,0x1
    80000a30:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a32:	95be                	add	a1,a1,a5
    80000a34:	4685                	li	a3,1
    80000a36:	00c5d613          	srli	a2,a1,0xc
    80000a3a:	4581                	li	a1,0
    80000a3c:	00000097          	auipc	ra,0x0
    80000a40:	ce4080e7          	jalr	-796(ra) # 80000720 <uvmunmap>
    80000a44:	bfd9                	j	80000a1a <uvmfree+0xe>

0000000080000a46 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a46:	ca69                	beqz	a2,80000b18 <uvmcopy+0xd2>
{
    80000a48:	715d                	addi	sp,sp,-80
    80000a4a:	e486                	sd	ra,72(sp)
    80000a4c:	e0a2                	sd	s0,64(sp)
    80000a4e:	fc26                	sd	s1,56(sp)
    80000a50:	f84a                	sd	s2,48(sp)
    80000a52:	f44e                	sd	s3,40(sp)
    80000a54:	f052                	sd	s4,32(sp)
    80000a56:	ec56                	sd	s5,24(sp)
    80000a58:	e85a                	sd	s6,16(sp)
    80000a5a:	e45e                	sd	s7,8(sp)
    80000a5c:	e062                	sd	s8,0(sp)
    80000a5e:	0880                	addi	s0,sp,80
    80000a60:	8baa                	mv	s7,a0
    80000a62:	8b2e                	mv	s6,a1
    80000a64:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a66:	4981                	li	s3,0
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a68:	6a05                	lui	s4,0x1
    if((pte = walk(old, i, 0)) == 0)
    80000a6a:	4601                	li	a2,0
    80000a6c:	85ce                	mv	a1,s3
    80000a6e:	855e                	mv	a0,s7
    80000a70:	00000097          	auipc	ra,0x0
    80000a74:	a02080e7          	jalr	-1534(ra) # 80000472 <walk>
    80000a78:	c529                	beqz	a0,80000ac2 <uvmcopy+0x7c>
    if((*pte & PTE_V) == 0)
    80000a7a:	6118                	ld	a4,0(a0)
    80000a7c:	00177793          	andi	a5,a4,1
    80000a80:	cba9                	beqz	a5,80000ad2 <uvmcopy+0x8c>
    pa = PTE2PA(*pte);
    80000a82:	00a75593          	srli	a1,a4,0xa
    80000a86:	00c59c13          	slli	s8,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a8a:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a8e:	fffff097          	auipc	ra,0xfffff
    80000a92:	68c080e7          	jalr	1676(ra) # 8000011a <kalloc>
    80000a96:	892a                	mv	s2,a0
    80000a98:	c931                	beqz	a0,80000aec <uvmcopy+0xa6>
    memmove(mem, (char*)pa, PGSIZE);
    80000a9a:	8652                	mv	a2,s4
    80000a9c:	85e2                	mv	a1,s8
    80000a9e:	fffff097          	auipc	ra,0xfffff
    80000aa2:	740080e7          	jalr	1856(ra) # 800001de <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000aa6:	8726                	mv	a4,s1
    80000aa8:	86ca                	mv	a3,s2
    80000aaa:	8652                	mv	a2,s4
    80000aac:	85ce                	mv	a1,s3
    80000aae:	855a                	mv	a0,s6
    80000ab0:	00000097          	auipc	ra,0x0
    80000ab4:	aaa080e7          	jalr	-1366(ra) # 8000055a <mappages>
    80000ab8:	e50d                	bnez	a0,80000ae2 <uvmcopy+0x9c>
  for(i = 0; i < sz; i += PGSIZE){
    80000aba:	99d2                	add	s3,s3,s4
    80000abc:	fb59e7e3          	bltu	s3,s5,80000a6a <uvmcopy+0x24>
    80000ac0:	a081                	j	80000b00 <uvmcopy+0xba>
      panic("uvmcopy: pte should exist");
    80000ac2:	00007517          	auipc	a0,0x7
    80000ac6:	64650513          	addi	a0,a0,1606 # 80008108 <etext+0x108>
    80000aca:	00005097          	auipc	ra,0x5
    80000ace:	228080e7          	jalr	552(ra) # 80005cf2 <panic>
      panic("uvmcopy: page not present");
    80000ad2:	00007517          	auipc	a0,0x7
    80000ad6:	65650513          	addi	a0,a0,1622 # 80008128 <etext+0x128>
    80000ada:	00005097          	auipc	ra,0x5
    80000ade:	218080e7          	jalr	536(ra) # 80005cf2 <panic>
      kfree(mem);
    80000ae2:	854a                	mv	a0,s2
    80000ae4:	fffff097          	auipc	ra,0xfffff
    80000ae8:	538080e7          	jalr	1336(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aec:	4685                	li	a3,1
    80000aee:	00c9d613          	srli	a2,s3,0xc
    80000af2:	4581                	li	a1,0
    80000af4:	855a                	mv	a0,s6
    80000af6:	00000097          	auipc	ra,0x0
    80000afa:	c2a080e7          	jalr	-982(ra) # 80000720 <uvmunmap>
  return -1;
    80000afe:	557d                	li	a0,-1
}
    80000b00:	60a6                	ld	ra,72(sp)
    80000b02:	6406                	ld	s0,64(sp)
    80000b04:	74e2                	ld	s1,56(sp)
    80000b06:	7942                	ld	s2,48(sp)
    80000b08:	79a2                	ld	s3,40(sp)
    80000b0a:	7a02                	ld	s4,32(sp)
    80000b0c:	6ae2                	ld	s5,24(sp)
    80000b0e:	6b42                	ld	s6,16(sp)
    80000b10:	6ba2                	ld	s7,8(sp)
    80000b12:	6c02                	ld	s8,0(sp)
    80000b14:	6161                	addi	sp,sp,80
    80000b16:	8082                	ret
  return 0;
    80000b18:	4501                	li	a0,0
}
    80000b1a:	8082                	ret

0000000080000b1c <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b1c:	1141                	addi	sp,sp,-16
    80000b1e:	e406                	sd	ra,8(sp)
    80000b20:	e022                	sd	s0,0(sp)
    80000b22:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b24:	4601                	li	a2,0
    80000b26:	00000097          	auipc	ra,0x0
    80000b2a:	94c080e7          	jalr	-1716(ra) # 80000472 <walk>
  if(pte == 0)
    80000b2e:	c901                	beqz	a0,80000b3e <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b30:	611c                	ld	a5,0(a0)
    80000b32:	9bbd                	andi	a5,a5,-17
    80000b34:	e11c                	sd	a5,0(a0)
}
    80000b36:	60a2                	ld	ra,8(sp)
    80000b38:	6402                	ld	s0,0(sp)
    80000b3a:	0141                	addi	sp,sp,16
    80000b3c:	8082                	ret
    panic("uvmclear");
    80000b3e:	00007517          	auipc	a0,0x7
    80000b42:	60a50513          	addi	a0,a0,1546 # 80008148 <etext+0x148>
    80000b46:	00005097          	auipc	ra,0x5
    80000b4a:	1ac080e7          	jalr	428(ra) # 80005cf2 <panic>

0000000080000b4e <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b4e:	c6bd                	beqz	a3,80000bbc <copyout+0x6e>
{
    80000b50:	715d                	addi	sp,sp,-80
    80000b52:	e486                	sd	ra,72(sp)
    80000b54:	e0a2                	sd	s0,64(sp)
    80000b56:	fc26                	sd	s1,56(sp)
    80000b58:	f84a                	sd	s2,48(sp)
    80000b5a:	f44e                	sd	s3,40(sp)
    80000b5c:	f052                	sd	s4,32(sp)
    80000b5e:	ec56                	sd	s5,24(sp)
    80000b60:	e85a                	sd	s6,16(sp)
    80000b62:	e45e                	sd	s7,8(sp)
    80000b64:	e062                	sd	s8,0(sp)
    80000b66:	0880                	addi	s0,sp,80
    80000b68:	8b2a                	mv	s6,a0
    80000b6a:	8c2e                	mv	s8,a1
    80000b6c:	8a32                	mv	s4,a2
    80000b6e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b70:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b72:	6a85                	lui	s5,0x1
    80000b74:	a015                	j	80000b98 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b76:	9562                	add	a0,a0,s8
    80000b78:	0004861b          	sext.w	a2,s1
    80000b7c:	85d2                	mv	a1,s4
    80000b7e:	41250533          	sub	a0,a0,s2
    80000b82:	fffff097          	auipc	ra,0xfffff
    80000b86:	65c080e7          	jalr	1628(ra) # 800001de <memmove>

    len -= n;
    80000b8a:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b8e:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b90:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b94:	02098263          	beqz	s3,80000bb8 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b98:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b9c:	85ca                	mv	a1,s2
    80000b9e:	855a                	mv	a0,s6
    80000ba0:	00000097          	auipc	ra,0x0
    80000ba4:	978080e7          	jalr	-1672(ra) # 80000518 <walkaddr>
    if(pa0 == 0)
    80000ba8:	cd01                	beqz	a0,80000bc0 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000baa:	418904b3          	sub	s1,s2,s8
    80000bae:	94d6                	add	s1,s1,s5
    if(n > len)
    80000bb0:	fc99f3e3          	bgeu	s3,s1,80000b76 <copyout+0x28>
    80000bb4:	84ce                	mv	s1,s3
    80000bb6:	b7c1                	j	80000b76 <copyout+0x28>
  }
  return 0;
    80000bb8:	4501                	li	a0,0
    80000bba:	a021                	j	80000bc2 <copyout+0x74>
    80000bbc:	4501                	li	a0,0
}
    80000bbe:	8082                	ret
      return -1;
    80000bc0:	557d                	li	a0,-1
}
    80000bc2:	60a6                	ld	ra,72(sp)
    80000bc4:	6406                	ld	s0,64(sp)
    80000bc6:	74e2                	ld	s1,56(sp)
    80000bc8:	7942                	ld	s2,48(sp)
    80000bca:	79a2                	ld	s3,40(sp)
    80000bcc:	7a02                	ld	s4,32(sp)
    80000bce:	6ae2                	ld	s5,24(sp)
    80000bd0:	6b42                	ld	s6,16(sp)
    80000bd2:	6ba2                	ld	s7,8(sp)
    80000bd4:	6c02                	ld	s8,0(sp)
    80000bd6:	6161                	addi	sp,sp,80
    80000bd8:	8082                	ret

0000000080000bda <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000bda:	caa5                	beqz	a3,80000c4a <copyin+0x70>
{
    80000bdc:	715d                	addi	sp,sp,-80
    80000bde:	e486                	sd	ra,72(sp)
    80000be0:	e0a2                	sd	s0,64(sp)
    80000be2:	fc26                	sd	s1,56(sp)
    80000be4:	f84a                	sd	s2,48(sp)
    80000be6:	f44e                	sd	s3,40(sp)
    80000be8:	f052                	sd	s4,32(sp)
    80000bea:	ec56                	sd	s5,24(sp)
    80000bec:	e85a                	sd	s6,16(sp)
    80000bee:	e45e                	sd	s7,8(sp)
    80000bf0:	e062                	sd	s8,0(sp)
    80000bf2:	0880                	addi	s0,sp,80
    80000bf4:	8b2a                	mv	s6,a0
    80000bf6:	8a2e                	mv	s4,a1
    80000bf8:	8c32                	mv	s8,a2
    80000bfa:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bfc:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bfe:	6a85                	lui	s5,0x1
    80000c00:	a01d                	j	80000c26 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c02:	018505b3          	add	a1,a0,s8
    80000c06:	0004861b          	sext.w	a2,s1
    80000c0a:	412585b3          	sub	a1,a1,s2
    80000c0e:	8552                	mv	a0,s4
    80000c10:	fffff097          	auipc	ra,0xfffff
    80000c14:	5ce080e7          	jalr	1486(ra) # 800001de <memmove>

    len -= n;
    80000c18:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c1c:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c1e:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c22:	02098263          	beqz	s3,80000c46 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c26:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c2a:	85ca                	mv	a1,s2
    80000c2c:	855a                	mv	a0,s6
    80000c2e:	00000097          	auipc	ra,0x0
    80000c32:	8ea080e7          	jalr	-1814(ra) # 80000518 <walkaddr>
    if(pa0 == 0)
    80000c36:	cd01                	beqz	a0,80000c4e <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c38:	418904b3          	sub	s1,s2,s8
    80000c3c:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c3e:	fc99f2e3          	bgeu	s3,s1,80000c02 <copyin+0x28>
    80000c42:	84ce                	mv	s1,s3
    80000c44:	bf7d                	j	80000c02 <copyin+0x28>
  }
  return 0;
    80000c46:	4501                	li	a0,0
    80000c48:	a021                	j	80000c50 <copyin+0x76>
    80000c4a:	4501                	li	a0,0
}
    80000c4c:	8082                	ret
      return -1;
    80000c4e:	557d                	li	a0,-1
}
    80000c50:	60a6                	ld	ra,72(sp)
    80000c52:	6406                	ld	s0,64(sp)
    80000c54:	74e2                	ld	s1,56(sp)
    80000c56:	7942                	ld	s2,48(sp)
    80000c58:	79a2                	ld	s3,40(sp)
    80000c5a:	7a02                	ld	s4,32(sp)
    80000c5c:	6ae2                	ld	s5,24(sp)
    80000c5e:	6b42                	ld	s6,16(sp)
    80000c60:	6ba2                	ld	s7,8(sp)
    80000c62:	6c02                	ld	s8,0(sp)
    80000c64:	6161                	addi	sp,sp,80
    80000c66:	8082                	ret

0000000080000c68 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80000c68:	715d                	addi	sp,sp,-80
    80000c6a:	e486                	sd	ra,72(sp)
    80000c6c:	e0a2                	sd	s0,64(sp)
    80000c6e:	fc26                	sd	s1,56(sp)
    80000c70:	f84a                	sd	s2,48(sp)
    80000c72:	f44e                	sd	s3,40(sp)
    80000c74:	f052                	sd	s4,32(sp)
    80000c76:	ec56                	sd	s5,24(sp)
    80000c78:	e85a                	sd	s6,16(sp)
    80000c7a:	e45e                	sd	s7,8(sp)
    80000c7c:	0880                	addi	s0,sp,80
    80000c7e:	8aaa                	mv	s5,a0
    80000c80:	89ae                	mv	s3,a1
    80000c82:	8bb2                	mv	s7,a2
    80000c84:	84b6                	mv	s1,a3
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    va0 = PGROUNDDOWN(srcva);
    80000c86:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c88:	6a05                	lui	s4,0x1
    80000c8a:	a02d                	j	80000cb4 <copyinstr+0x4c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c8c:	00078023          	sb	zero,0(a5)
    80000c90:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c92:	0017c793          	xori	a5,a5,1
    80000c96:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c9a:	60a6                	ld	ra,72(sp)
    80000c9c:	6406                	ld	s0,64(sp)
    80000c9e:	74e2                	ld	s1,56(sp)
    80000ca0:	7942                	ld	s2,48(sp)
    80000ca2:	79a2                	ld	s3,40(sp)
    80000ca4:	7a02                	ld	s4,32(sp)
    80000ca6:	6ae2                	ld	s5,24(sp)
    80000ca8:	6b42                	ld	s6,16(sp)
    80000caa:	6ba2                	ld	s7,8(sp)
    80000cac:	6161                	addi	sp,sp,80
    80000cae:	8082                	ret
    srcva = va0 + PGSIZE;
    80000cb0:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80000cb4:	c8a1                	beqz	s1,80000d04 <copyinstr+0x9c>
    va0 = PGROUNDDOWN(srcva);
    80000cb6:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80000cba:	85ca                	mv	a1,s2
    80000cbc:	8556                	mv	a0,s5
    80000cbe:	00000097          	auipc	ra,0x0
    80000cc2:	85a080e7          	jalr	-1958(ra) # 80000518 <walkaddr>
    if(pa0 == 0)
    80000cc6:	c129                	beqz	a0,80000d08 <copyinstr+0xa0>
    n = PGSIZE - (srcva - va0);
    80000cc8:	41790633          	sub	a2,s2,s7
    80000ccc:	9652                	add	a2,a2,s4
    if(n > max)
    80000cce:	00c4f363          	bgeu	s1,a2,80000cd4 <copyinstr+0x6c>
    80000cd2:	8626                	mv	a2,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000cd4:	412b8bb3          	sub	s7,s7,s2
    80000cd8:	9baa                	add	s7,s7,a0
    while(n > 0){
    80000cda:	da79                	beqz	a2,80000cb0 <copyinstr+0x48>
    80000cdc:	87ce                	mv	a5,s3
      if(*p == '\0'){
    80000cde:	413b86b3          	sub	a3,s7,s3
    while(n > 0){
    80000ce2:	964e                	add	a2,a2,s3
    80000ce4:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000ce6:	00f68733          	add	a4,a3,a5
    80000cea:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd5dc0>
    80000cee:	df59                	beqz	a4,80000c8c <copyinstr+0x24>
        *dst = *p;
    80000cf0:	00e78023          	sb	a4,0(a5)
      dst++;
    80000cf4:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cf6:	fec797e3          	bne	a5,a2,80000ce4 <copyinstr+0x7c>
    80000cfa:	14fd                	addi	s1,s1,-1
    80000cfc:	94ce                	add	s1,s1,s3
      --max;
    80000cfe:	8c8d                	sub	s1,s1,a1
    80000d00:	89be                	mv	s3,a5
    80000d02:	b77d                	j	80000cb0 <copyinstr+0x48>
    80000d04:	4781                	li	a5,0
    80000d06:	b771                	j	80000c92 <copyinstr+0x2a>
      return -1;
    80000d08:	557d                	li	a0,-1
    80000d0a:	bf41                	j	80000c9a <copyinstr+0x32>

0000000080000d0c <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000d0c:	715d                	addi	sp,sp,-80
    80000d0e:	e486                	sd	ra,72(sp)
    80000d10:	e0a2                	sd	s0,64(sp)
    80000d12:	fc26                	sd	s1,56(sp)
    80000d14:	f84a                	sd	s2,48(sp)
    80000d16:	f44e                	sd	s3,40(sp)
    80000d18:	f052                	sd	s4,32(sp)
    80000d1a:	ec56                	sd	s5,24(sp)
    80000d1c:	e85a                	sd	s6,16(sp)
    80000d1e:	e45e                	sd	s7,8(sp)
    80000d20:	e062                	sd	s8,0(sp)
    80000d22:	0880                	addi	s0,sp,80
    80000d24:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d26:	0000b497          	auipc	s1,0xb
    80000d2a:	75a48493          	addi	s1,s1,1882 # 8000c480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d2e:	8c26                	mv	s8,s1
    80000d30:	e9bd37b7          	lui	a5,0xe9bd3
    80000d34:	7a778793          	addi	a5,a5,1959 # ffffffffe9bd37a7 <end+0xffffffff69baa567>
    80000d38:	d37a7937          	lui	s2,0xd37a7
    80000d3c:	f4e90913          	addi	s2,s2,-178 # ffffffffd37a6f4e <end+0xffffffff5377dd0e>
    80000d40:	1902                	slli	s2,s2,0x20
    80000d42:	993e                	add	s2,s2,a5
    80000d44:	040009b7          	lui	s3,0x4000
    80000d48:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000d4a:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d4c:	4b99                	li	s7,6
    80000d4e:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d50:	00011a97          	auipc	s5,0x11
    80000d54:	330a8a93          	addi	s5,s5,816 # 80012080 <tickslock>
    char *pa = kalloc();
    80000d58:	fffff097          	auipc	ra,0xfffff
    80000d5c:	3c2080e7          	jalr	962(ra) # 8000011a <kalloc>
    80000d60:	862a                	mv	a2,a0
    if(pa == 0)
    80000d62:	c131                	beqz	a0,80000da6 <proc_mapstacks+0x9a>
    uint64 va = KSTACK((int) (p - proc));
    80000d64:	418485b3          	sub	a1,s1,s8
    80000d68:	8591                	srai	a1,a1,0x4
    80000d6a:	032585b3          	mul	a1,a1,s2
    80000d6e:	2585                	addiw	a1,a1,1
    80000d70:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d74:	875e                	mv	a4,s7
    80000d76:	86da                	mv	a3,s6
    80000d78:	40b985b3          	sub	a1,s3,a1
    80000d7c:	8552                	mv	a0,s4
    80000d7e:	00000097          	auipc	ra,0x0
    80000d82:	882080e7          	jalr	-1918(ra) # 80000600 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d86:	17048493          	addi	s1,s1,368
    80000d8a:	fd5497e3          	bne	s1,s5,80000d58 <proc_mapstacks+0x4c>
  }
}
    80000d8e:	60a6                	ld	ra,72(sp)
    80000d90:	6406                	ld	s0,64(sp)
    80000d92:	74e2                	ld	s1,56(sp)
    80000d94:	7942                	ld	s2,48(sp)
    80000d96:	79a2                	ld	s3,40(sp)
    80000d98:	7a02                	ld	s4,32(sp)
    80000d9a:	6ae2                	ld	s5,24(sp)
    80000d9c:	6b42                	ld	s6,16(sp)
    80000d9e:	6ba2                	ld	s7,8(sp)
    80000da0:	6c02                	ld	s8,0(sp)
    80000da2:	6161                	addi	sp,sp,80
    80000da4:	8082                	ret
      panic("kalloc");
    80000da6:	00007517          	auipc	a0,0x7
    80000daa:	3b250513          	addi	a0,a0,946 # 80008158 <etext+0x158>
    80000dae:	00005097          	auipc	ra,0x5
    80000db2:	f44080e7          	jalr	-188(ra) # 80005cf2 <panic>

0000000080000db6 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000db6:	7139                	addi	sp,sp,-64
    80000db8:	fc06                	sd	ra,56(sp)
    80000dba:	f822                	sd	s0,48(sp)
    80000dbc:	f426                	sd	s1,40(sp)
    80000dbe:	f04a                	sd	s2,32(sp)
    80000dc0:	ec4e                	sd	s3,24(sp)
    80000dc2:	e852                	sd	s4,16(sp)
    80000dc4:	e456                	sd	s5,8(sp)
    80000dc6:	e05a                	sd	s6,0(sp)
    80000dc8:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000dca:	00007597          	auipc	a1,0x7
    80000dce:	39658593          	addi	a1,a1,918 # 80008160 <etext+0x160>
    80000dd2:	0000b517          	auipc	a0,0xb
    80000dd6:	27e50513          	addi	a0,a0,638 # 8000c050 <pid_lock>
    80000dda:	00005097          	auipc	ra,0x5
    80000dde:	404080e7          	jalr	1028(ra) # 800061de <initlock>
  initlock(&wait_lock, "wait_lock");
    80000de2:	00007597          	auipc	a1,0x7
    80000de6:	38658593          	addi	a1,a1,902 # 80008168 <etext+0x168>
    80000dea:	0000b517          	auipc	a0,0xb
    80000dee:	27e50513          	addi	a0,a0,638 # 8000c068 <wait_lock>
    80000df2:	00005097          	auipc	ra,0x5
    80000df6:	3ec080e7          	jalr	1004(ra) # 800061de <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dfa:	0000b497          	auipc	s1,0xb
    80000dfe:	68648493          	addi	s1,s1,1670 # 8000c480 <proc>
      initlock(&p->lock, "proc");
    80000e02:	00007b17          	auipc	s6,0x7
    80000e06:	376b0b13          	addi	s6,s6,886 # 80008178 <etext+0x178>
      p->kstack = KSTACK((int) (p - proc));
    80000e0a:	8aa6                	mv	s5,s1
    80000e0c:	e9bd37b7          	lui	a5,0xe9bd3
    80000e10:	7a778793          	addi	a5,a5,1959 # ffffffffe9bd37a7 <end+0xffffffff69baa567>
    80000e14:	d37a7937          	lui	s2,0xd37a7
    80000e18:	f4e90913          	addi	s2,s2,-178 # ffffffffd37a6f4e <end+0xffffffff5377dd0e>
    80000e1c:	1902                	slli	s2,s2,0x20
    80000e1e:	993e                	add	s2,s2,a5
    80000e20:	040009b7          	lui	s3,0x4000
    80000e24:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000e26:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e28:	00011a17          	auipc	s4,0x11
    80000e2c:	258a0a13          	addi	s4,s4,600 # 80012080 <tickslock>
      initlock(&p->lock, "proc");
    80000e30:	85da                	mv	a1,s6
    80000e32:	8526                	mv	a0,s1
    80000e34:	00005097          	auipc	ra,0x5
    80000e38:	3aa080e7          	jalr	938(ra) # 800061de <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000e3c:	415487b3          	sub	a5,s1,s5
    80000e40:	8791                	srai	a5,a5,0x4
    80000e42:	032787b3          	mul	a5,a5,s2
    80000e46:	2785                	addiw	a5,a5,1
    80000e48:	00d7979b          	slliw	a5,a5,0xd
    80000e4c:	40f987b3          	sub	a5,s3,a5
    80000e50:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e52:	17048493          	addi	s1,s1,368
    80000e56:	fd449de3          	bne	s1,s4,80000e30 <procinit+0x7a>
  }
}
    80000e5a:	70e2                	ld	ra,56(sp)
    80000e5c:	7442                	ld	s0,48(sp)
    80000e5e:	74a2                	ld	s1,40(sp)
    80000e60:	7902                	ld	s2,32(sp)
    80000e62:	69e2                	ld	s3,24(sp)
    80000e64:	6a42                	ld	s4,16(sp)
    80000e66:	6aa2                	ld	s5,8(sp)
    80000e68:	6b02                	ld	s6,0(sp)
    80000e6a:	6121                	addi	sp,sp,64
    80000e6c:	8082                	ret

0000000080000e6e <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e6e:	1141                	addi	sp,sp,-16
    80000e70:	e406                	sd	ra,8(sp)
    80000e72:	e022                	sd	s0,0(sp)
    80000e74:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e76:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e78:	2501                	sext.w	a0,a0
    80000e7a:	60a2                	ld	ra,8(sp)
    80000e7c:	6402                	ld	s0,0(sp)
    80000e7e:	0141                	addi	sp,sp,16
    80000e80:	8082                	ret

0000000080000e82 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000e82:	1141                	addi	sp,sp,-16
    80000e84:	e406                	sd	ra,8(sp)
    80000e86:	e022                	sd	s0,0(sp)
    80000e88:	0800                	addi	s0,sp,16
    80000e8a:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e8c:	2781                	sext.w	a5,a5
    80000e8e:	079e                	slli	a5,a5,0x7
  return c;
}
    80000e90:	0000b517          	auipc	a0,0xb
    80000e94:	1f050513          	addi	a0,a0,496 # 8000c080 <cpus>
    80000e98:	953e                	add	a0,a0,a5
    80000e9a:	60a2                	ld	ra,8(sp)
    80000e9c:	6402                	ld	s0,0(sp)
    80000e9e:	0141                	addi	sp,sp,16
    80000ea0:	8082                	ret

0000000080000ea2 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000ea2:	1101                	addi	sp,sp,-32
    80000ea4:	ec06                	sd	ra,24(sp)
    80000ea6:	e822                	sd	s0,16(sp)
    80000ea8:	e426                	sd	s1,8(sp)
    80000eaa:	1000                	addi	s0,sp,32
  push_off();
    80000eac:	00005097          	auipc	ra,0x5
    80000eb0:	37a080e7          	jalr	890(ra) # 80006226 <push_off>
    80000eb4:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000eb6:	2781                	sext.w	a5,a5
    80000eb8:	079e                	slli	a5,a5,0x7
    80000eba:	0000b717          	auipc	a4,0xb
    80000ebe:	19670713          	addi	a4,a4,406 # 8000c050 <pid_lock>
    80000ec2:	97ba                	add	a5,a5,a4
    80000ec4:	7b84                	ld	s1,48(a5)
  pop_off();
    80000ec6:	00005097          	auipc	ra,0x5
    80000eca:	400080e7          	jalr	1024(ra) # 800062c6 <pop_off>
  return p;
}
    80000ece:	8526                	mv	a0,s1
    80000ed0:	60e2                	ld	ra,24(sp)
    80000ed2:	6442                	ld	s0,16(sp)
    80000ed4:	64a2                	ld	s1,8(sp)
    80000ed6:	6105                	addi	sp,sp,32
    80000ed8:	8082                	ret

0000000080000eda <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000eda:	1141                	addi	sp,sp,-16
    80000edc:	e406                	sd	ra,8(sp)
    80000ede:	e022                	sd	s0,0(sp)
    80000ee0:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000ee2:	00000097          	auipc	ra,0x0
    80000ee6:	fc0080e7          	jalr	-64(ra) # 80000ea2 <myproc>
    80000eea:	00005097          	auipc	ra,0x5
    80000eee:	438080e7          	jalr	1080(ra) # 80006322 <release>

  if (first) {
    80000ef2:	0000a797          	auipc	a5,0xa
    80000ef6:	37e7a783          	lw	a5,894(a5) # 8000b270 <first.1>
    80000efa:	eb89                	bnez	a5,80000f0c <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000efc:	00001097          	auipc	ra,0x1
    80000f00:	c20080e7          	jalr	-992(ra) # 80001b1c <usertrapret>
}
    80000f04:	60a2                	ld	ra,8(sp)
    80000f06:	6402                	ld	s0,0(sp)
    80000f08:	0141                	addi	sp,sp,16
    80000f0a:	8082                	ret
    first = 0;
    80000f0c:	0000a797          	auipc	a5,0xa
    80000f10:	3607a223          	sw	zero,868(a5) # 8000b270 <first.1>
    fsinit(ROOTDEV);
    80000f14:	4505                	li	a0,1
    80000f16:	00002097          	auipc	ra,0x2
    80000f1a:	9a4080e7          	jalr	-1628(ra) # 800028ba <fsinit>
    80000f1e:	bff9                	j	80000efc <forkret+0x22>

0000000080000f20 <allocpid>:
allocpid() {
    80000f20:	1101                	addi	sp,sp,-32
    80000f22:	ec06                	sd	ra,24(sp)
    80000f24:	e822                	sd	s0,16(sp)
    80000f26:	e426                	sd	s1,8(sp)
    80000f28:	e04a                	sd	s2,0(sp)
    80000f2a:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000f2c:	0000b917          	auipc	s2,0xb
    80000f30:	12490913          	addi	s2,s2,292 # 8000c050 <pid_lock>
    80000f34:	854a                	mv	a0,s2
    80000f36:	00005097          	auipc	ra,0x5
    80000f3a:	33c080e7          	jalr	828(ra) # 80006272 <acquire>
  pid = nextpid;
    80000f3e:	0000a797          	auipc	a5,0xa
    80000f42:	33678793          	addi	a5,a5,822 # 8000b274 <nextpid>
    80000f46:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000f48:	0014871b          	addiw	a4,s1,1
    80000f4c:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f4e:	854a                	mv	a0,s2
    80000f50:	00005097          	auipc	ra,0x5
    80000f54:	3d2080e7          	jalr	978(ra) # 80006322 <release>
}
    80000f58:	8526                	mv	a0,s1
    80000f5a:	60e2                	ld	ra,24(sp)
    80000f5c:	6442                	ld	s0,16(sp)
    80000f5e:	64a2                	ld	s1,8(sp)
    80000f60:	6902                	ld	s2,0(sp)
    80000f62:	6105                	addi	sp,sp,32
    80000f64:	8082                	ret

0000000080000f66 <proc_pagetable>:
{
    80000f66:	1101                	addi	sp,sp,-32
    80000f68:	ec06                	sd	ra,24(sp)
    80000f6a:	e822                	sd	s0,16(sp)
    80000f6c:	e426                	sd	s1,8(sp)
    80000f6e:	e04a                	sd	s2,0(sp)
    80000f70:	1000                	addi	s0,sp,32
    80000f72:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f74:	00000097          	auipc	ra,0x0
    80000f78:	880080e7          	jalr	-1920(ra) # 800007f4 <uvmcreate>
    80000f7c:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f7e:	c121                	beqz	a0,80000fbe <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f80:	4729                	li	a4,10
    80000f82:	00006697          	auipc	a3,0x6
    80000f86:	07e68693          	addi	a3,a3,126 # 80007000 <_trampoline>
    80000f8a:	6605                	lui	a2,0x1
    80000f8c:	040005b7          	lui	a1,0x4000
    80000f90:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f92:	05b2                	slli	a1,a1,0xc
    80000f94:	fffff097          	auipc	ra,0xfffff
    80000f98:	5c6080e7          	jalr	1478(ra) # 8000055a <mappages>
    80000f9c:	02054863          	bltz	a0,80000fcc <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000fa0:	4719                	li	a4,6
    80000fa2:	05893683          	ld	a3,88(s2)
    80000fa6:	6605                	lui	a2,0x1
    80000fa8:	020005b7          	lui	a1,0x2000
    80000fac:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fae:	05b6                	slli	a1,a1,0xd
    80000fb0:	8526                	mv	a0,s1
    80000fb2:	fffff097          	auipc	ra,0xfffff
    80000fb6:	5a8080e7          	jalr	1448(ra) # 8000055a <mappages>
    80000fba:	02054163          	bltz	a0,80000fdc <proc_pagetable+0x76>
}
    80000fbe:	8526                	mv	a0,s1
    80000fc0:	60e2                	ld	ra,24(sp)
    80000fc2:	6442                	ld	s0,16(sp)
    80000fc4:	64a2                	ld	s1,8(sp)
    80000fc6:	6902                	ld	s2,0(sp)
    80000fc8:	6105                	addi	sp,sp,32
    80000fca:	8082                	ret
    uvmfree(pagetable, 0);
    80000fcc:	4581                	li	a1,0
    80000fce:	8526                	mv	a0,s1
    80000fd0:	00000097          	auipc	ra,0x0
    80000fd4:	a3c080e7          	jalr	-1476(ra) # 80000a0c <uvmfree>
    return 0;
    80000fd8:	4481                	li	s1,0
    80000fda:	b7d5                	j	80000fbe <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fdc:	4681                	li	a3,0
    80000fde:	4605                	li	a2,1
    80000fe0:	040005b7          	lui	a1,0x4000
    80000fe4:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fe6:	05b2                	slli	a1,a1,0xc
    80000fe8:	8526                	mv	a0,s1
    80000fea:	fffff097          	auipc	ra,0xfffff
    80000fee:	736080e7          	jalr	1846(ra) # 80000720 <uvmunmap>
    uvmfree(pagetable, 0);
    80000ff2:	4581                	li	a1,0
    80000ff4:	8526                	mv	a0,s1
    80000ff6:	00000097          	auipc	ra,0x0
    80000ffa:	a16080e7          	jalr	-1514(ra) # 80000a0c <uvmfree>
    return 0;
    80000ffe:	4481                	li	s1,0
    80001000:	bf7d                	j	80000fbe <proc_pagetable+0x58>

0000000080001002 <proc_freepagetable>:
{
    80001002:	1101                	addi	sp,sp,-32
    80001004:	ec06                	sd	ra,24(sp)
    80001006:	e822                	sd	s0,16(sp)
    80001008:	e426                	sd	s1,8(sp)
    8000100a:	e04a                	sd	s2,0(sp)
    8000100c:	1000                	addi	s0,sp,32
    8000100e:	84aa                	mv	s1,a0
    80001010:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001012:	4681                	li	a3,0
    80001014:	4605                	li	a2,1
    80001016:	040005b7          	lui	a1,0x4000
    8000101a:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000101c:	05b2                	slli	a1,a1,0xc
    8000101e:	fffff097          	auipc	ra,0xfffff
    80001022:	702080e7          	jalr	1794(ra) # 80000720 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001026:	4681                	li	a3,0
    80001028:	4605                	li	a2,1
    8000102a:	020005b7          	lui	a1,0x2000
    8000102e:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001030:	05b6                	slli	a1,a1,0xd
    80001032:	8526                	mv	a0,s1
    80001034:	fffff097          	auipc	ra,0xfffff
    80001038:	6ec080e7          	jalr	1772(ra) # 80000720 <uvmunmap>
  uvmfree(pagetable, sz);
    8000103c:	85ca                	mv	a1,s2
    8000103e:	8526                	mv	a0,s1
    80001040:	00000097          	auipc	ra,0x0
    80001044:	9cc080e7          	jalr	-1588(ra) # 80000a0c <uvmfree>
}
    80001048:	60e2                	ld	ra,24(sp)
    8000104a:	6442                	ld	s0,16(sp)
    8000104c:	64a2                	ld	s1,8(sp)
    8000104e:	6902                	ld	s2,0(sp)
    80001050:	6105                	addi	sp,sp,32
    80001052:	8082                	ret

0000000080001054 <freeproc>:
{
    80001054:	1101                	addi	sp,sp,-32
    80001056:	ec06                	sd	ra,24(sp)
    80001058:	e822                	sd	s0,16(sp)
    8000105a:	e426                	sd	s1,8(sp)
    8000105c:	1000                	addi	s0,sp,32
    8000105e:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001060:	6d28                	ld	a0,88(a0)
    80001062:	c509                	beqz	a0,8000106c <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001064:	fffff097          	auipc	ra,0xfffff
    80001068:	fb8080e7          	jalr	-72(ra) # 8000001c <kfree>
  p->trapframe = 0;
    8000106c:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001070:	68a8                	ld	a0,80(s1)
    80001072:	c511                	beqz	a0,8000107e <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001074:	64ac                	ld	a1,72(s1)
    80001076:	00000097          	auipc	ra,0x0
    8000107a:	f8c080e7          	jalr	-116(ra) # 80001002 <proc_freepagetable>
  p->pagetable = 0;
    8000107e:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001082:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001086:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    8000108a:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    8000108e:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001092:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001096:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    8000109a:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    8000109e:	0004ac23          	sw	zero,24(s1)
}
    800010a2:	60e2                	ld	ra,24(sp)
    800010a4:	6442                	ld	s0,16(sp)
    800010a6:	64a2                	ld	s1,8(sp)
    800010a8:	6105                	addi	sp,sp,32
    800010aa:	8082                	ret

00000000800010ac <allocproc>:
{
    800010ac:	1101                	addi	sp,sp,-32
    800010ae:	ec06                	sd	ra,24(sp)
    800010b0:	e822                	sd	s0,16(sp)
    800010b2:	e426                	sd	s1,8(sp)
    800010b4:	e04a                	sd	s2,0(sp)
    800010b6:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800010b8:	0000b497          	auipc	s1,0xb
    800010bc:	3c848493          	addi	s1,s1,968 # 8000c480 <proc>
    800010c0:	00011917          	auipc	s2,0x11
    800010c4:	fc090913          	addi	s2,s2,-64 # 80012080 <tickslock>
    acquire(&p->lock);
    800010c8:	8526                	mv	a0,s1
    800010ca:	00005097          	auipc	ra,0x5
    800010ce:	1a8080e7          	jalr	424(ra) # 80006272 <acquire>
    if(p->state == UNUSED) {
    800010d2:	4c9c                	lw	a5,24(s1)
    800010d4:	cf81                	beqz	a5,800010ec <allocproc+0x40>
      release(&p->lock);
    800010d6:	8526                	mv	a0,s1
    800010d8:	00005097          	auipc	ra,0x5
    800010dc:	24a080e7          	jalr	586(ra) # 80006322 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800010e0:	17048493          	addi	s1,s1,368
    800010e4:	ff2492e3          	bne	s1,s2,800010c8 <allocproc+0x1c>
  return 0;
    800010e8:	4481                	li	s1,0
    800010ea:	a899                	j	80001140 <allocproc+0x94>
  p->pid = allocpid();
    800010ec:	00000097          	auipc	ra,0x0
    800010f0:	e34080e7          	jalr	-460(ra) # 80000f20 <allocpid>
    800010f4:	d888                	sw	a0,48(s1)
  p->state = USED;
    800010f6:	4785                	li	a5,1
    800010f8:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800010fa:	fffff097          	auipc	ra,0xfffff
    800010fe:	020080e7          	jalr	32(ra) # 8000011a <kalloc>
    80001102:	892a                	mv	s2,a0
    80001104:	eca8                	sd	a0,88(s1)
    80001106:	c521                	beqz	a0,8000114e <allocproc+0xa2>
  p->pagetable = proc_pagetable(p);
    80001108:	8526                	mv	a0,s1
    8000110a:	00000097          	auipc	ra,0x0
    8000110e:	e5c080e7          	jalr	-420(ra) # 80000f66 <proc_pagetable>
    80001112:	892a                	mv	s2,a0
    80001114:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001116:	c921                	beqz	a0,80001166 <allocproc+0xba>
  memset(&p->context, 0, sizeof(p->context));
    80001118:	07000613          	li	a2,112
    8000111c:	4581                	li	a1,0
    8000111e:	06048513          	addi	a0,s1,96
    80001122:	fffff097          	auipc	ra,0xfffff
    80001126:	058080e7          	jalr	88(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    8000112a:	00000797          	auipc	a5,0x0
    8000112e:	db078793          	addi	a5,a5,-592 # 80000eda <forkret>
    80001132:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001134:	60bc                	ld	a5,64(s1)
    80001136:	6705                	lui	a4,0x1
    80001138:	97ba                	add	a5,a5,a4
    8000113a:	f4bc                	sd	a5,104(s1)
  p->trace_mask = 0;
    8000113c:	1604a423          	sw	zero,360(s1)
}
    80001140:	8526                	mv	a0,s1
    80001142:	60e2                	ld	ra,24(sp)
    80001144:	6442                	ld	s0,16(sp)
    80001146:	64a2                	ld	s1,8(sp)
    80001148:	6902                	ld	s2,0(sp)
    8000114a:	6105                	addi	sp,sp,32
    8000114c:	8082                	ret
    freeproc(p);
    8000114e:	8526                	mv	a0,s1
    80001150:	00000097          	auipc	ra,0x0
    80001154:	f04080e7          	jalr	-252(ra) # 80001054 <freeproc>
    release(&p->lock);
    80001158:	8526                	mv	a0,s1
    8000115a:	00005097          	auipc	ra,0x5
    8000115e:	1c8080e7          	jalr	456(ra) # 80006322 <release>
    return 0;
    80001162:	84ca                	mv	s1,s2
    80001164:	bff1                	j	80001140 <allocproc+0x94>
    freeproc(p);
    80001166:	8526                	mv	a0,s1
    80001168:	00000097          	auipc	ra,0x0
    8000116c:	eec080e7          	jalr	-276(ra) # 80001054 <freeproc>
    release(&p->lock);
    80001170:	8526                	mv	a0,s1
    80001172:	00005097          	auipc	ra,0x5
    80001176:	1b0080e7          	jalr	432(ra) # 80006322 <release>
    return 0;
    8000117a:	84ca                	mv	s1,s2
    8000117c:	b7d1                	j	80001140 <allocproc+0x94>

000000008000117e <userinit>:
{
    8000117e:	1101                	addi	sp,sp,-32
    80001180:	ec06                	sd	ra,24(sp)
    80001182:	e822                	sd	s0,16(sp)
    80001184:	e426                	sd	s1,8(sp)
    80001186:	1000                	addi	s0,sp,32
  p = allocproc();
    80001188:	00000097          	auipc	ra,0x0
    8000118c:	f24080e7          	jalr	-220(ra) # 800010ac <allocproc>
    80001190:	84aa                	mv	s1,a0
  initproc = p;
    80001192:	0000b797          	auipc	a5,0xb
    80001196:	e6a7bf23          	sd	a0,-386(a5) # 8000c010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    8000119a:	03400613          	li	a2,52
    8000119e:	0000a597          	auipc	a1,0xa
    800011a2:	0e258593          	addi	a1,a1,226 # 8000b280 <initcode>
    800011a6:	6928                	ld	a0,80(a0)
    800011a8:	fffff097          	auipc	ra,0xfffff
    800011ac:	67a080e7          	jalr	1658(ra) # 80000822 <uvminit>
  p->sz = PGSIZE;
    800011b0:	6785                	lui	a5,0x1
    800011b2:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800011b4:	6cb8                	ld	a4,88(s1)
    800011b6:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800011ba:	6cb8                	ld	a4,88(s1)
    800011bc:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800011be:	4641                	li	a2,16
    800011c0:	00007597          	auipc	a1,0x7
    800011c4:	fc058593          	addi	a1,a1,-64 # 80008180 <etext+0x180>
    800011c8:	15848513          	addi	a0,s1,344
    800011cc:	fffff097          	auipc	ra,0xfffff
    800011d0:	104080e7          	jalr	260(ra) # 800002d0 <safestrcpy>
  p->cwd = namei("/");
    800011d4:	00007517          	auipc	a0,0x7
    800011d8:	fbc50513          	addi	a0,a0,-68 # 80008190 <etext+0x190>
    800011dc:	00002097          	auipc	ra,0x2
    800011e0:	13e080e7          	jalr	318(ra) # 8000331a <namei>
    800011e4:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    800011e8:	478d                	li	a5,3
    800011ea:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    800011ec:	8526                	mv	a0,s1
    800011ee:	00005097          	auipc	ra,0x5
    800011f2:	134080e7          	jalr	308(ra) # 80006322 <release>
}
    800011f6:	60e2                	ld	ra,24(sp)
    800011f8:	6442                	ld	s0,16(sp)
    800011fa:	64a2                	ld	s1,8(sp)
    800011fc:	6105                	addi	sp,sp,32
    800011fe:	8082                	ret

0000000080001200 <growproc>:
{
    80001200:	1101                	addi	sp,sp,-32
    80001202:	ec06                	sd	ra,24(sp)
    80001204:	e822                	sd	s0,16(sp)
    80001206:	e426                	sd	s1,8(sp)
    80001208:	e04a                	sd	s2,0(sp)
    8000120a:	1000                	addi	s0,sp,32
    8000120c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000120e:	00000097          	auipc	ra,0x0
    80001212:	c94080e7          	jalr	-876(ra) # 80000ea2 <myproc>
    80001216:	892a                	mv	s2,a0
  sz = p->sz;
    80001218:	652c                	ld	a1,72(a0)
    8000121a:	0005879b          	sext.w	a5,a1
  if(n > 0){
    8000121e:	00904f63          	bgtz	s1,8000123c <growproc+0x3c>
  } else if(n < 0){
    80001222:	0204cd63          	bltz	s1,8000125c <growproc+0x5c>
  p->sz = sz;
    80001226:	1782                	slli	a5,a5,0x20
    80001228:	9381                	srli	a5,a5,0x20
    8000122a:	04f93423          	sd	a5,72(s2)
  return 0;
    8000122e:	4501                	li	a0,0
}
    80001230:	60e2                	ld	ra,24(sp)
    80001232:	6442                	ld	s0,16(sp)
    80001234:	64a2                	ld	s1,8(sp)
    80001236:	6902                	ld	s2,0(sp)
    80001238:	6105                	addi	sp,sp,32
    8000123a:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    8000123c:	00f4863b          	addw	a2,s1,a5
    80001240:	1602                	slli	a2,a2,0x20
    80001242:	9201                	srli	a2,a2,0x20
    80001244:	1582                	slli	a1,a1,0x20
    80001246:	9181                	srli	a1,a1,0x20
    80001248:	6928                	ld	a0,80(a0)
    8000124a:	fffff097          	auipc	ra,0xfffff
    8000124e:	692080e7          	jalr	1682(ra) # 800008dc <uvmalloc>
    80001252:	0005079b          	sext.w	a5,a0
    80001256:	fbe1                	bnez	a5,80001226 <growproc+0x26>
      return -1;
    80001258:	557d                	li	a0,-1
    8000125a:	bfd9                	j	80001230 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000125c:	00f4863b          	addw	a2,s1,a5
    80001260:	1602                	slli	a2,a2,0x20
    80001262:	9201                	srli	a2,a2,0x20
    80001264:	1582                	slli	a1,a1,0x20
    80001266:	9181                	srli	a1,a1,0x20
    80001268:	6928                	ld	a0,80(a0)
    8000126a:	fffff097          	auipc	ra,0xfffff
    8000126e:	62a080e7          	jalr	1578(ra) # 80000894 <uvmdealloc>
    80001272:	0005079b          	sext.w	a5,a0
    80001276:	bf45                	j	80001226 <growproc+0x26>

0000000080001278 <fork>:
{
    80001278:	7139                	addi	sp,sp,-64
    8000127a:	fc06                	sd	ra,56(sp)
    8000127c:	f822                	sd	s0,48(sp)
    8000127e:	f04a                	sd	s2,32(sp)
    80001280:	e456                	sd	s5,8(sp)
    80001282:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001284:	00000097          	auipc	ra,0x0
    80001288:	c1e080e7          	jalr	-994(ra) # 80000ea2 <myproc>
    8000128c:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    8000128e:	00000097          	auipc	ra,0x0
    80001292:	e1e080e7          	jalr	-482(ra) # 800010ac <allocproc>
    80001296:	12050463          	beqz	a0,800013be <fork+0x146>
    8000129a:	ec4e                	sd	s3,24(sp)
    8000129c:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000129e:	048ab603          	ld	a2,72(s5)
    800012a2:	692c                	ld	a1,80(a0)
    800012a4:	050ab503          	ld	a0,80(s5)
    800012a8:	fffff097          	auipc	ra,0xfffff
    800012ac:	79e080e7          	jalr	1950(ra) # 80000a46 <uvmcopy>
    800012b0:	04054a63          	bltz	a0,80001304 <fork+0x8c>
    800012b4:	f426                	sd	s1,40(sp)
    800012b6:	e852                	sd	s4,16(sp)
  np->sz = p->sz;
    800012b8:	048ab783          	ld	a5,72(s5)
    800012bc:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    800012c0:	058ab683          	ld	a3,88(s5)
    800012c4:	87b6                	mv	a5,a3
    800012c6:	0589b703          	ld	a4,88(s3)
    800012ca:	12068693          	addi	a3,a3,288
    800012ce:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    800012d2:	6788                	ld	a0,8(a5)
    800012d4:	6b8c                	ld	a1,16(a5)
    800012d6:	6f90                	ld	a2,24(a5)
    800012d8:	01073023          	sd	a6,0(a4)
    800012dc:	e708                	sd	a0,8(a4)
    800012de:	eb0c                	sd	a1,16(a4)
    800012e0:	ef10                	sd	a2,24(a4)
    800012e2:	02078793          	addi	a5,a5,32
    800012e6:	02070713          	addi	a4,a4,32
    800012ea:	fed792e3          	bne	a5,a3,800012ce <fork+0x56>
  np->trapframe->a0 = 0;
    800012ee:	0589b783          	ld	a5,88(s3)
    800012f2:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    800012f6:	0d0a8493          	addi	s1,s5,208
    800012fa:	0d098913          	addi	s2,s3,208
    800012fe:	150a8a13          	addi	s4,s5,336
    80001302:	a015                	j	80001326 <fork+0xae>
    freeproc(np);
    80001304:	854e                	mv	a0,s3
    80001306:	00000097          	auipc	ra,0x0
    8000130a:	d4e080e7          	jalr	-690(ra) # 80001054 <freeproc>
    release(&np->lock);
    8000130e:	854e                	mv	a0,s3
    80001310:	00005097          	auipc	ra,0x5
    80001314:	012080e7          	jalr	18(ra) # 80006322 <release>
    return -1;
    80001318:	597d                	li	s2,-1
    8000131a:	69e2                	ld	s3,24(sp)
    8000131c:	a851                	j	800013b0 <fork+0x138>
  for(i = 0; i < NOFILE; i++)
    8000131e:	04a1                	addi	s1,s1,8
    80001320:	0921                	addi	s2,s2,8
    80001322:	01448b63          	beq	s1,s4,80001338 <fork+0xc0>
    if(p->ofile[i])
    80001326:	6088                	ld	a0,0(s1)
    80001328:	d97d                	beqz	a0,8000131e <fork+0xa6>
      np->ofile[i] = filedup(p->ofile[i]);
    8000132a:	00002097          	auipc	ra,0x2
    8000132e:	674080e7          	jalr	1652(ra) # 8000399e <filedup>
    80001332:	00a93023          	sd	a0,0(s2)
    80001336:	b7e5                	j	8000131e <fork+0xa6>
  np->cwd = idup(p->cwd);
    80001338:	150ab503          	ld	a0,336(s5)
    8000133c:	00001097          	auipc	ra,0x1
    80001340:	7b4080e7          	jalr	1972(ra) # 80002af0 <idup>
    80001344:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001348:	4641                	li	a2,16
    8000134a:	158a8593          	addi	a1,s5,344
    8000134e:	15898513          	addi	a0,s3,344
    80001352:	fffff097          	auipc	ra,0xfffff
    80001356:	f7e080e7          	jalr	-130(ra) # 800002d0 <safestrcpy>
  pid = np->pid;
    8000135a:	0309a903          	lw	s2,48(s3)
  release(&np->lock);
    8000135e:	854e                	mv	a0,s3
    80001360:	00005097          	auipc	ra,0x5
    80001364:	fc2080e7          	jalr	-62(ra) # 80006322 <release>
  acquire(&wait_lock);
    80001368:	0000b497          	auipc	s1,0xb
    8000136c:	d0048493          	addi	s1,s1,-768 # 8000c068 <wait_lock>
    80001370:	8526                	mv	a0,s1
    80001372:	00005097          	auipc	ra,0x5
    80001376:	f00080e7          	jalr	-256(ra) # 80006272 <acquire>
  np->parent = p;
    8000137a:	0359bc23          	sd	s5,56(s3)
  release(&wait_lock);
    8000137e:	8526                	mv	a0,s1
    80001380:	00005097          	auipc	ra,0x5
    80001384:	fa2080e7          	jalr	-94(ra) # 80006322 <release>
  acquire(&np->lock);
    80001388:	854e                	mv	a0,s3
    8000138a:	00005097          	auipc	ra,0x5
    8000138e:	ee8080e7          	jalr	-280(ra) # 80006272 <acquire>
  np->state = RUNNABLE;
    80001392:	478d                	li	a5,3
    80001394:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001398:	854e                	mv	a0,s3
    8000139a:	00005097          	auipc	ra,0x5
    8000139e:	f88080e7          	jalr	-120(ra) # 80006322 <release>
  np->trace_mask = p->trace_mask;
    800013a2:	168aa783          	lw	a5,360(s5)
    800013a6:	16f9a423          	sw	a5,360(s3)
  return pid;
    800013aa:	74a2                	ld	s1,40(sp)
    800013ac:	69e2                	ld	s3,24(sp)
    800013ae:	6a42                	ld	s4,16(sp)
}
    800013b0:	854a                	mv	a0,s2
    800013b2:	70e2                	ld	ra,56(sp)
    800013b4:	7442                	ld	s0,48(sp)
    800013b6:	7902                	ld	s2,32(sp)
    800013b8:	6aa2                	ld	s5,8(sp)
    800013ba:	6121                	addi	sp,sp,64
    800013bc:	8082                	ret
    return -1;
    800013be:	597d                	li	s2,-1
    800013c0:	bfc5                	j	800013b0 <fork+0x138>

00000000800013c2 <scheduler>:
{
    800013c2:	7139                	addi	sp,sp,-64
    800013c4:	fc06                	sd	ra,56(sp)
    800013c6:	f822                	sd	s0,48(sp)
    800013c8:	f426                	sd	s1,40(sp)
    800013ca:	f04a                	sd	s2,32(sp)
    800013cc:	ec4e                	sd	s3,24(sp)
    800013ce:	e852                	sd	s4,16(sp)
    800013d0:	e456                	sd	s5,8(sp)
    800013d2:	e05a                	sd	s6,0(sp)
    800013d4:	0080                	addi	s0,sp,64
    800013d6:	8792                	mv	a5,tp
  int id = r_tp();
    800013d8:	2781                	sext.w	a5,a5
  c->proc = 0;
    800013da:	00779a93          	slli	s5,a5,0x7
    800013de:	0000b717          	auipc	a4,0xb
    800013e2:	c7270713          	addi	a4,a4,-910 # 8000c050 <pid_lock>
    800013e6:	9756                	add	a4,a4,s5
    800013e8:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800013ec:	0000b717          	auipc	a4,0xb
    800013f0:	c9c70713          	addi	a4,a4,-868 # 8000c088 <cpus+0x8>
    800013f4:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    800013f6:	498d                	li	s3,3
        p->state = RUNNING;
    800013f8:	4b11                	li	s6,4
        c->proc = p;
    800013fa:	079e                	slli	a5,a5,0x7
    800013fc:	0000ba17          	auipc	s4,0xb
    80001400:	c54a0a13          	addi	s4,s4,-940 # 8000c050 <pid_lock>
    80001404:	9a3e                	add	s4,s4,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001406:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000140a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000140e:	10079073          	csrw	sstatus,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001412:	0000b497          	auipc	s1,0xb
    80001416:	06e48493          	addi	s1,s1,110 # 8000c480 <proc>
    8000141a:	00011917          	auipc	s2,0x11
    8000141e:	c6690913          	addi	s2,s2,-922 # 80012080 <tickslock>
    80001422:	a811                	j	80001436 <scheduler+0x74>
      release(&p->lock);
    80001424:	8526                	mv	a0,s1
    80001426:	00005097          	auipc	ra,0x5
    8000142a:	efc080e7          	jalr	-260(ra) # 80006322 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    8000142e:	17048493          	addi	s1,s1,368
    80001432:	fd248ae3          	beq	s1,s2,80001406 <scheduler+0x44>
      acquire(&p->lock);
    80001436:	8526                	mv	a0,s1
    80001438:	00005097          	auipc	ra,0x5
    8000143c:	e3a080e7          	jalr	-454(ra) # 80006272 <acquire>
      if(p->state == RUNNABLE) {
    80001440:	4c9c                	lw	a5,24(s1)
    80001442:	ff3791e3          	bne	a5,s3,80001424 <scheduler+0x62>
        p->state = RUNNING;
    80001446:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    8000144a:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000144e:	06048593          	addi	a1,s1,96
    80001452:	8556                	mv	a0,s5
    80001454:	00000097          	auipc	ra,0x0
    80001458:	61a080e7          	jalr	1562(ra) # 80001a6e <swtch>
        c->proc = 0;
    8000145c:	020a3823          	sd	zero,48(s4)
    80001460:	b7d1                	j	80001424 <scheduler+0x62>

0000000080001462 <sched>:
{
    80001462:	7179                	addi	sp,sp,-48
    80001464:	f406                	sd	ra,40(sp)
    80001466:	f022                	sd	s0,32(sp)
    80001468:	ec26                	sd	s1,24(sp)
    8000146a:	e84a                	sd	s2,16(sp)
    8000146c:	e44e                	sd	s3,8(sp)
    8000146e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001470:	00000097          	auipc	ra,0x0
    80001474:	a32080e7          	jalr	-1486(ra) # 80000ea2 <myproc>
    80001478:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000147a:	00005097          	auipc	ra,0x5
    8000147e:	d7e080e7          	jalr	-642(ra) # 800061f8 <holding>
    80001482:	c93d                	beqz	a0,800014f8 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001484:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001486:	2781                	sext.w	a5,a5
    80001488:	079e                	slli	a5,a5,0x7
    8000148a:	0000b717          	auipc	a4,0xb
    8000148e:	bc670713          	addi	a4,a4,-1082 # 8000c050 <pid_lock>
    80001492:	97ba                	add	a5,a5,a4
    80001494:	0a87a703          	lw	a4,168(a5)
    80001498:	4785                	li	a5,1
    8000149a:	06f71763          	bne	a4,a5,80001508 <sched+0xa6>
  if(p->state == RUNNING)
    8000149e:	4c98                	lw	a4,24(s1)
    800014a0:	4791                	li	a5,4
    800014a2:	06f70b63          	beq	a4,a5,80001518 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800014a6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800014aa:	8b89                	andi	a5,a5,2
  if(intr_get())
    800014ac:	efb5                	bnez	a5,80001528 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    800014ae:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800014b0:	0000b917          	auipc	s2,0xb
    800014b4:	ba090913          	addi	s2,s2,-1120 # 8000c050 <pid_lock>
    800014b8:	2781                	sext.w	a5,a5
    800014ba:	079e                	slli	a5,a5,0x7
    800014bc:	97ca                	add	a5,a5,s2
    800014be:	0ac7a983          	lw	s3,172(a5)
    800014c2:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800014c4:	2781                	sext.w	a5,a5
    800014c6:	079e                	slli	a5,a5,0x7
    800014c8:	0000b597          	auipc	a1,0xb
    800014cc:	bc058593          	addi	a1,a1,-1088 # 8000c088 <cpus+0x8>
    800014d0:	95be                	add	a1,a1,a5
    800014d2:	06048513          	addi	a0,s1,96
    800014d6:	00000097          	auipc	ra,0x0
    800014da:	598080e7          	jalr	1432(ra) # 80001a6e <swtch>
    800014de:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800014e0:	2781                	sext.w	a5,a5
    800014e2:	079e                	slli	a5,a5,0x7
    800014e4:	993e                	add	s2,s2,a5
    800014e6:	0b392623          	sw	s3,172(s2)
}
    800014ea:	70a2                	ld	ra,40(sp)
    800014ec:	7402                	ld	s0,32(sp)
    800014ee:	64e2                	ld	s1,24(sp)
    800014f0:	6942                	ld	s2,16(sp)
    800014f2:	69a2                	ld	s3,8(sp)
    800014f4:	6145                	addi	sp,sp,48
    800014f6:	8082                	ret
    panic("sched p->lock");
    800014f8:	00007517          	auipc	a0,0x7
    800014fc:	ca050513          	addi	a0,a0,-864 # 80008198 <etext+0x198>
    80001500:	00004097          	auipc	ra,0x4
    80001504:	7f2080e7          	jalr	2034(ra) # 80005cf2 <panic>
    panic("sched locks");
    80001508:	00007517          	auipc	a0,0x7
    8000150c:	ca050513          	addi	a0,a0,-864 # 800081a8 <etext+0x1a8>
    80001510:	00004097          	auipc	ra,0x4
    80001514:	7e2080e7          	jalr	2018(ra) # 80005cf2 <panic>
    panic("sched running");
    80001518:	00007517          	auipc	a0,0x7
    8000151c:	ca050513          	addi	a0,a0,-864 # 800081b8 <etext+0x1b8>
    80001520:	00004097          	auipc	ra,0x4
    80001524:	7d2080e7          	jalr	2002(ra) # 80005cf2 <panic>
    panic("sched interruptible");
    80001528:	00007517          	auipc	a0,0x7
    8000152c:	ca050513          	addi	a0,a0,-864 # 800081c8 <etext+0x1c8>
    80001530:	00004097          	auipc	ra,0x4
    80001534:	7c2080e7          	jalr	1986(ra) # 80005cf2 <panic>

0000000080001538 <yield>:
{
    80001538:	1101                	addi	sp,sp,-32
    8000153a:	ec06                	sd	ra,24(sp)
    8000153c:	e822                	sd	s0,16(sp)
    8000153e:	e426                	sd	s1,8(sp)
    80001540:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001542:	00000097          	auipc	ra,0x0
    80001546:	960080e7          	jalr	-1696(ra) # 80000ea2 <myproc>
    8000154a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000154c:	00005097          	auipc	ra,0x5
    80001550:	d26080e7          	jalr	-730(ra) # 80006272 <acquire>
  p->state = RUNNABLE;
    80001554:	478d                	li	a5,3
    80001556:	cc9c                	sw	a5,24(s1)
  sched();
    80001558:	00000097          	auipc	ra,0x0
    8000155c:	f0a080e7          	jalr	-246(ra) # 80001462 <sched>
  release(&p->lock);
    80001560:	8526                	mv	a0,s1
    80001562:	00005097          	auipc	ra,0x5
    80001566:	dc0080e7          	jalr	-576(ra) # 80006322 <release>
}
    8000156a:	60e2                	ld	ra,24(sp)
    8000156c:	6442                	ld	s0,16(sp)
    8000156e:	64a2                	ld	s1,8(sp)
    80001570:	6105                	addi	sp,sp,32
    80001572:	8082                	ret

0000000080001574 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001574:	7179                	addi	sp,sp,-48
    80001576:	f406                	sd	ra,40(sp)
    80001578:	f022                	sd	s0,32(sp)
    8000157a:	ec26                	sd	s1,24(sp)
    8000157c:	e84a                	sd	s2,16(sp)
    8000157e:	e44e                	sd	s3,8(sp)
    80001580:	1800                	addi	s0,sp,48
    80001582:	89aa                	mv	s3,a0
    80001584:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001586:	00000097          	auipc	ra,0x0
    8000158a:	91c080e7          	jalr	-1764(ra) # 80000ea2 <myproc>
    8000158e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001590:	00005097          	auipc	ra,0x5
    80001594:	ce2080e7          	jalr	-798(ra) # 80006272 <acquire>
  release(lk);
    80001598:	854a                	mv	a0,s2
    8000159a:	00005097          	auipc	ra,0x5
    8000159e:	d88080e7          	jalr	-632(ra) # 80006322 <release>

  // Go to sleep.
  p->chan = chan;
    800015a2:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800015a6:	4789                	li	a5,2
    800015a8:	cc9c                	sw	a5,24(s1)

  sched();
    800015aa:	00000097          	auipc	ra,0x0
    800015ae:	eb8080e7          	jalr	-328(ra) # 80001462 <sched>

  // Tidy up.
  p->chan = 0;
    800015b2:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800015b6:	8526                	mv	a0,s1
    800015b8:	00005097          	auipc	ra,0x5
    800015bc:	d6a080e7          	jalr	-662(ra) # 80006322 <release>
  acquire(lk);
    800015c0:	854a                	mv	a0,s2
    800015c2:	00005097          	auipc	ra,0x5
    800015c6:	cb0080e7          	jalr	-848(ra) # 80006272 <acquire>
}
    800015ca:	70a2                	ld	ra,40(sp)
    800015cc:	7402                	ld	s0,32(sp)
    800015ce:	64e2                	ld	s1,24(sp)
    800015d0:	6942                	ld	s2,16(sp)
    800015d2:	69a2                	ld	s3,8(sp)
    800015d4:	6145                	addi	sp,sp,48
    800015d6:	8082                	ret

00000000800015d8 <wait>:
{
    800015d8:	715d                	addi	sp,sp,-80
    800015da:	e486                	sd	ra,72(sp)
    800015dc:	e0a2                	sd	s0,64(sp)
    800015de:	fc26                	sd	s1,56(sp)
    800015e0:	f84a                	sd	s2,48(sp)
    800015e2:	f44e                	sd	s3,40(sp)
    800015e4:	f052                	sd	s4,32(sp)
    800015e6:	ec56                	sd	s5,24(sp)
    800015e8:	e85a                	sd	s6,16(sp)
    800015ea:	e45e                	sd	s7,8(sp)
    800015ec:	0880                	addi	s0,sp,80
    800015ee:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800015f0:	00000097          	auipc	ra,0x0
    800015f4:	8b2080e7          	jalr	-1870(ra) # 80000ea2 <myproc>
    800015f8:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800015fa:	0000b517          	auipc	a0,0xb
    800015fe:	a6e50513          	addi	a0,a0,-1426 # 8000c068 <wait_lock>
    80001602:	00005097          	auipc	ra,0x5
    80001606:	c70080e7          	jalr	-912(ra) # 80006272 <acquire>
        if(np->state == ZOMBIE){
    8000160a:	4a15                	li	s4,5
        havekids = 1;
    8000160c:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    8000160e:	00011997          	auipc	s3,0x11
    80001612:	a7298993          	addi	s3,s3,-1422 # 80012080 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001616:	0000bb97          	auipc	s7,0xb
    8000161a:	a52b8b93          	addi	s7,s7,-1454 # 8000c068 <wait_lock>
    8000161e:	a875                	j	800016da <wait+0x102>
          pid = np->pid;
    80001620:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    80001624:	000b0e63          	beqz	s6,80001640 <wait+0x68>
    80001628:	4691                	li	a3,4
    8000162a:	02c48613          	addi	a2,s1,44
    8000162e:	85da                	mv	a1,s6
    80001630:	05093503          	ld	a0,80(s2)
    80001634:	fffff097          	auipc	ra,0xfffff
    80001638:	51a080e7          	jalr	1306(ra) # 80000b4e <copyout>
    8000163c:	04054063          	bltz	a0,8000167c <wait+0xa4>
          freeproc(np);
    80001640:	8526                	mv	a0,s1
    80001642:	00000097          	auipc	ra,0x0
    80001646:	a12080e7          	jalr	-1518(ra) # 80001054 <freeproc>
          release(&np->lock);
    8000164a:	8526                	mv	a0,s1
    8000164c:	00005097          	auipc	ra,0x5
    80001650:	cd6080e7          	jalr	-810(ra) # 80006322 <release>
          release(&wait_lock);
    80001654:	0000b517          	auipc	a0,0xb
    80001658:	a1450513          	addi	a0,a0,-1516 # 8000c068 <wait_lock>
    8000165c:	00005097          	auipc	ra,0x5
    80001660:	cc6080e7          	jalr	-826(ra) # 80006322 <release>
}
    80001664:	854e                	mv	a0,s3
    80001666:	60a6                	ld	ra,72(sp)
    80001668:	6406                	ld	s0,64(sp)
    8000166a:	74e2                	ld	s1,56(sp)
    8000166c:	7942                	ld	s2,48(sp)
    8000166e:	79a2                	ld	s3,40(sp)
    80001670:	7a02                	ld	s4,32(sp)
    80001672:	6ae2                	ld	s5,24(sp)
    80001674:	6b42                	ld	s6,16(sp)
    80001676:	6ba2                	ld	s7,8(sp)
    80001678:	6161                	addi	sp,sp,80
    8000167a:	8082                	ret
            release(&np->lock);
    8000167c:	8526                	mv	a0,s1
    8000167e:	00005097          	auipc	ra,0x5
    80001682:	ca4080e7          	jalr	-860(ra) # 80006322 <release>
            release(&wait_lock);
    80001686:	0000b517          	auipc	a0,0xb
    8000168a:	9e250513          	addi	a0,a0,-1566 # 8000c068 <wait_lock>
    8000168e:	00005097          	auipc	ra,0x5
    80001692:	c94080e7          	jalr	-876(ra) # 80006322 <release>
            return -1;
    80001696:	59fd                	li	s3,-1
    80001698:	b7f1                	j	80001664 <wait+0x8c>
    for(np = proc; np < &proc[NPROC]; np++){
    8000169a:	17048493          	addi	s1,s1,368
    8000169e:	03348463          	beq	s1,s3,800016c6 <wait+0xee>
      if(np->parent == p){
    800016a2:	7c9c                	ld	a5,56(s1)
    800016a4:	ff279be3          	bne	a5,s2,8000169a <wait+0xc2>
        acquire(&np->lock);
    800016a8:	8526                	mv	a0,s1
    800016aa:	00005097          	auipc	ra,0x5
    800016ae:	bc8080e7          	jalr	-1080(ra) # 80006272 <acquire>
        if(np->state == ZOMBIE){
    800016b2:	4c9c                	lw	a5,24(s1)
    800016b4:	f74786e3          	beq	a5,s4,80001620 <wait+0x48>
        release(&np->lock);
    800016b8:	8526                	mv	a0,s1
    800016ba:	00005097          	auipc	ra,0x5
    800016be:	c68080e7          	jalr	-920(ra) # 80006322 <release>
        havekids = 1;
    800016c2:	8756                	mv	a4,s5
    800016c4:	bfd9                	j	8000169a <wait+0xc2>
    if(!havekids || p->killed){
    800016c6:	c305                	beqz	a4,800016e6 <wait+0x10e>
    800016c8:	02892783          	lw	a5,40(s2)
    800016cc:	ef89                	bnez	a5,800016e6 <wait+0x10e>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800016ce:	85de                	mv	a1,s7
    800016d0:	854a                	mv	a0,s2
    800016d2:	00000097          	auipc	ra,0x0
    800016d6:	ea2080e7          	jalr	-350(ra) # 80001574 <sleep>
    havekids = 0;
    800016da:	4701                	li	a4,0
    for(np = proc; np < &proc[NPROC]; np++){
    800016dc:	0000b497          	auipc	s1,0xb
    800016e0:	da448493          	addi	s1,s1,-604 # 8000c480 <proc>
    800016e4:	bf7d                	j	800016a2 <wait+0xca>
      release(&wait_lock);
    800016e6:	0000b517          	auipc	a0,0xb
    800016ea:	98250513          	addi	a0,a0,-1662 # 8000c068 <wait_lock>
    800016ee:	00005097          	auipc	ra,0x5
    800016f2:	c34080e7          	jalr	-972(ra) # 80006322 <release>
      return -1;
    800016f6:	59fd                	li	s3,-1
    800016f8:	b7b5                	j	80001664 <wait+0x8c>

00000000800016fa <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800016fa:	7139                	addi	sp,sp,-64
    800016fc:	fc06                	sd	ra,56(sp)
    800016fe:	f822                	sd	s0,48(sp)
    80001700:	f426                	sd	s1,40(sp)
    80001702:	f04a                	sd	s2,32(sp)
    80001704:	ec4e                	sd	s3,24(sp)
    80001706:	e852                	sd	s4,16(sp)
    80001708:	e456                	sd	s5,8(sp)
    8000170a:	0080                	addi	s0,sp,64
    8000170c:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    8000170e:	0000b497          	auipc	s1,0xb
    80001712:	d7248493          	addi	s1,s1,-654 # 8000c480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    80001716:	4989                	li	s3,2
        p->state = RUNNABLE;
    80001718:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000171a:	00011917          	auipc	s2,0x11
    8000171e:	96690913          	addi	s2,s2,-1690 # 80012080 <tickslock>
    80001722:	a811                	j	80001736 <wakeup+0x3c>
      }
      release(&p->lock);
    80001724:	8526                	mv	a0,s1
    80001726:	00005097          	auipc	ra,0x5
    8000172a:	bfc080e7          	jalr	-1028(ra) # 80006322 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000172e:	17048493          	addi	s1,s1,368
    80001732:	03248663          	beq	s1,s2,8000175e <wakeup+0x64>
    if(p != myproc()){
    80001736:	fffff097          	auipc	ra,0xfffff
    8000173a:	76c080e7          	jalr	1900(ra) # 80000ea2 <myproc>
    8000173e:	fea488e3          	beq	s1,a0,8000172e <wakeup+0x34>
      acquire(&p->lock);
    80001742:	8526                	mv	a0,s1
    80001744:	00005097          	auipc	ra,0x5
    80001748:	b2e080e7          	jalr	-1234(ra) # 80006272 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    8000174c:	4c9c                	lw	a5,24(s1)
    8000174e:	fd379be3          	bne	a5,s3,80001724 <wakeup+0x2a>
    80001752:	709c                	ld	a5,32(s1)
    80001754:	fd4798e3          	bne	a5,s4,80001724 <wakeup+0x2a>
        p->state = RUNNABLE;
    80001758:	0154ac23          	sw	s5,24(s1)
    8000175c:	b7e1                	j	80001724 <wakeup+0x2a>
    }
  }
}
    8000175e:	70e2                	ld	ra,56(sp)
    80001760:	7442                	ld	s0,48(sp)
    80001762:	74a2                	ld	s1,40(sp)
    80001764:	7902                	ld	s2,32(sp)
    80001766:	69e2                	ld	s3,24(sp)
    80001768:	6a42                	ld	s4,16(sp)
    8000176a:	6aa2                	ld	s5,8(sp)
    8000176c:	6121                	addi	sp,sp,64
    8000176e:	8082                	ret

0000000080001770 <reparent>:
{
    80001770:	7179                	addi	sp,sp,-48
    80001772:	f406                	sd	ra,40(sp)
    80001774:	f022                	sd	s0,32(sp)
    80001776:	ec26                	sd	s1,24(sp)
    80001778:	e84a                	sd	s2,16(sp)
    8000177a:	e44e                	sd	s3,8(sp)
    8000177c:	e052                	sd	s4,0(sp)
    8000177e:	1800                	addi	s0,sp,48
    80001780:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001782:	0000b497          	auipc	s1,0xb
    80001786:	cfe48493          	addi	s1,s1,-770 # 8000c480 <proc>
      pp->parent = initproc;
    8000178a:	0000ba17          	auipc	s4,0xb
    8000178e:	886a0a13          	addi	s4,s4,-1914 # 8000c010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001792:	00011997          	auipc	s3,0x11
    80001796:	8ee98993          	addi	s3,s3,-1810 # 80012080 <tickslock>
    8000179a:	a029                	j	800017a4 <reparent+0x34>
    8000179c:	17048493          	addi	s1,s1,368
    800017a0:	01348d63          	beq	s1,s3,800017ba <reparent+0x4a>
    if(pp->parent == p){
    800017a4:	7c9c                	ld	a5,56(s1)
    800017a6:	ff279be3          	bne	a5,s2,8000179c <reparent+0x2c>
      pp->parent = initproc;
    800017aa:	000a3503          	ld	a0,0(s4)
    800017ae:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	f4a080e7          	jalr	-182(ra) # 800016fa <wakeup>
    800017b8:	b7d5                	j	8000179c <reparent+0x2c>
}
    800017ba:	70a2                	ld	ra,40(sp)
    800017bc:	7402                	ld	s0,32(sp)
    800017be:	64e2                	ld	s1,24(sp)
    800017c0:	6942                	ld	s2,16(sp)
    800017c2:	69a2                	ld	s3,8(sp)
    800017c4:	6a02                	ld	s4,0(sp)
    800017c6:	6145                	addi	sp,sp,48
    800017c8:	8082                	ret

00000000800017ca <exit>:
{
    800017ca:	7179                	addi	sp,sp,-48
    800017cc:	f406                	sd	ra,40(sp)
    800017ce:	f022                	sd	s0,32(sp)
    800017d0:	ec26                	sd	s1,24(sp)
    800017d2:	e84a                	sd	s2,16(sp)
    800017d4:	e44e                	sd	s3,8(sp)
    800017d6:	e052                	sd	s4,0(sp)
    800017d8:	1800                	addi	s0,sp,48
    800017da:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800017dc:	fffff097          	auipc	ra,0xfffff
    800017e0:	6c6080e7          	jalr	1734(ra) # 80000ea2 <myproc>
    800017e4:	89aa                	mv	s3,a0
  if(p == initproc)
    800017e6:	0000b797          	auipc	a5,0xb
    800017ea:	82a7b783          	ld	a5,-2006(a5) # 8000c010 <initproc>
    800017ee:	0d050493          	addi	s1,a0,208
    800017f2:	15050913          	addi	s2,a0,336
    800017f6:	00a79d63          	bne	a5,a0,80001810 <exit+0x46>
    panic("init exiting");
    800017fa:	00007517          	auipc	a0,0x7
    800017fe:	9e650513          	addi	a0,a0,-1562 # 800081e0 <etext+0x1e0>
    80001802:	00004097          	auipc	ra,0x4
    80001806:	4f0080e7          	jalr	1264(ra) # 80005cf2 <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    8000180a:	04a1                	addi	s1,s1,8
    8000180c:	01248b63          	beq	s1,s2,80001822 <exit+0x58>
    if(p->ofile[fd]){
    80001810:	6088                	ld	a0,0(s1)
    80001812:	dd65                	beqz	a0,8000180a <exit+0x40>
      fileclose(f);
    80001814:	00002097          	auipc	ra,0x2
    80001818:	1dc080e7          	jalr	476(ra) # 800039f0 <fileclose>
      p->ofile[fd] = 0;
    8000181c:	0004b023          	sd	zero,0(s1)
    80001820:	b7ed                	j	8000180a <exit+0x40>
  begin_op();
    80001822:	00002097          	auipc	ra,0x2
    80001826:	cfe080e7          	jalr	-770(ra) # 80003520 <begin_op>
  iput(p->cwd);
    8000182a:	1509b503          	ld	a0,336(s3)
    8000182e:	00001097          	auipc	ra,0x1
    80001832:	4be080e7          	jalr	1214(ra) # 80002cec <iput>
  end_op();
    80001836:	00002097          	auipc	ra,0x2
    8000183a:	d64080e7          	jalr	-668(ra) # 8000359a <end_op>
  p->cwd = 0;
    8000183e:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001842:	0000b497          	auipc	s1,0xb
    80001846:	82648493          	addi	s1,s1,-2010 # 8000c068 <wait_lock>
    8000184a:	8526                	mv	a0,s1
    8000184c:	00005097          	auipc	ra,0x5
    80001850:	a26080e7          	jalr	-1498(ra) # 80006272 <acquire>
  reparent(p);
    80001854:	854e                	mv	a0,s3
    80001856:	00000097          	auipc	ra,0x0
    8000185a:	f1a080e7          	jalr	-230(ra) # 80001770 <reparent>
  wakeup(p->parent);
    8000185e:	0389b503          	ld	a0,56(s3)
    80001862:	00000097          	auipc	ra,0x0
    80001866:	e98080e7          	jalr	-360(ra) # 800016fa <wakeup>
  acquire(&p->lock);
    8000186a:	854e                	mv	a0,s3
    8000186c:	00005097          	auipc	ra,0x5
    80001870:	a06080e7          	jalr	-1530(ra) # 80006272 <acquire>
  p->xstate = status;
    80001874:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001878:	4795                	li	a5,5
    8000187a:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    8000187e:	8526                	mv	a0,s1
    80001880:	00005097          	auipc	ra,0x5
    80001884:	aa2080e7          	jalr	-1374(ra) # 80006322 <release>
  sched();
    80001888:	00000097          	auipc	ra,0x0
    8000188c:	bda080e7          	jalr	-1062(ra) # 80001462 <sched>
  panic("zombie exit");
    80001890:	00007517          	auipc	a0,0x7
    80001894:	96050513          	addi	a0,a0,-1696 # 800081f0 <etext+0x1f0>
    80001898:	00004097          	auipc	ra,0x4
    8000189c:	45a080e7          	jalr	1114(ra) # 80005cf2 <panic>

00000000800018a0 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800018a0:	7179                	addi	sp,sp,-48
    800018a2:	f406                	sd	ra,40(sp)
    800018a4:	f022                	sd	s0,32(sp)
    800018a6:	ec26                	sd	s1,24(sp)
    800018a8:	e84a                	sd	s2,16(sp)
    800018aa:	e44e                	sd	s3,8(sp)
    800018ac:	1800                	addi	s0,sp,48
    800018ae:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800018b0:	0000b497          	auipc	s1,0xb
    800018b4:	bd048493          	addi	s1,s1,-1072 # 8000c480 <proc>
    800018b8:	00010997          	auipc	s3,0x10
    800018bc:	7c898993          	addi	s3,s3,1992 # 80012080 <tickslock>
    acquire(&p->lock);
    800018c0:	8526                	mv	a0,s1
    800018c2:	00005097          	auipc	ra,0x5
    800018c6:	9b0080e7          	jalr	-1616(ra) # 80006272 <acquire>
    if(p->pid == pid){
    800018ca:	589c                	lw	a5,48(s1)
    800018cc:	01278d63          	beq	a5,s2,800018e6 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800018d0:	8526                	mv	a0,s1
    800018d2:	00005097          	auipc	ra,0x5
    800018d6:	a50080e7          	jalr	-1456(ra) # 80006322 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800018da:	17048493          	addi	s1,s1,368
    800018de:	ff3491e3          	bne	s1,s3,800018c0 <kill+0x20>
  }
  return -1;
    800018e2:	557d                	li	a0,-1
    800018e4:	a829                	j	800018fe <kill+0x5e>
      p->killed = 1;
    800018e6:	4785                	li	a5,1
    800018e8:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800018ea:	4c98                	lw	a4,24(s1)
    800018ec:	4789                	li	a5,2
    800018ee:	00f70f63          	beq	a4,a5,8000190c <kill+0x6c>
      release(&p->lock);
    800018f2:	8526                	mv	a0,s1
    800018f4:	00005097          	auipc	ra,0x5
    800018f8:	a2e080e7          	jalr	-1490(ra) # 80006322 <release>
      return 0;
    800018fc:	4501                	li	a0,0
}
    800018fe:	70a2                	ld	ra,40(sp)
    80001900:	7402                	ld	s0,32(sp)
    80001902:	64e2                	ld	s1,24(sp)
    80001904:	6942                	ld	s2,16(sp)
    80001906:	69a2                	ld	s3,8(sp)
    80001908:	6145                	addi	sp,sp,48
    8000190a:	8082                	ret
        p->state = RUNNABLE;
    8000190c:	478d                	li	a5,3
    8000190e:	cc9c                	sw	a5,24(s1)
    80001910:	b7cd                	j	800018f2 <kill+0x52>

0000000080001912 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001912:	7179                	addi	sp,sp,-48
    80001914:	f406                	sd	ra,40(sp)
    80001916:	f022                	sd	s0,32(sp)
    80001918:	ec26                	sd	s1,24(sp)
    8000191a:	e84a                	sd	s2,16(sp)
    8000191c:	e44e                	sd	s3,8(sp)
    8000191e:	e052                	sd	s4,0(sp)
    80001920:	1800                	addi	s0,sp,48
    80001922:	84aa                	mv	s1,a0
    80001924:	892e                	mv	s2,a1
    80001926:	89b2                	mv	s3,a2
    80001928:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000192a:	fffff097          	auipc	ra,0xfffff
    8000192e:	578080e7          	jalr	1400(ra) # 80000ea2 <myproc>
  if(user_dst){
    80001932:	c08d                	beqz	s1,80001954 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001934:	86d2                	mv	a3,s4
    80001936:	864e                	mv	a2,s3
    80001938:	85ca                	mv	a1,s2
    8000193a:	6928                	ld	a0,80(a0)
    8000193c:	fffff097          	auipc	ra,0xfffff
    80001940:	212080e7          	jalr	530(ra) # 80000b4e <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001944:	70a2                	ld	ra,40(sp)
    80001946:	7402                	ld	s0,32(sp)
    80001948:	64e2                	ld	s1,24(sp)
    8000194a:	6942                	ld	s2,16(sp)
    8000194c:	69a2                	ld	s3,8(sp)
    8000194e:	6a02                	ld	s4,0(sp)
    80001950:	6145                	addi	sp,sp,48
    80001952:	8082                	ret
    memmove((char *)dst, src, len);
    80001954:	000a061b          	sext.w	a2,s4
    80001958:	85ce                	mv	a1,s3
    8000195a:	854a                	mv	a0,s2
    8000195c:	fffff097          	auipc	ra,0xfffff
    80001960:	882080e7          	jalr	-1918(ra) # 800001de <memmove>
    return 0;
    80001964:	8526                	mv	a0,s1
    80001966:	bff9                	j	80001944 <either_copyout+0x32>

0000000080001968 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001968:	7179                	addi	sp,sp,-48
    8000196a:	f406                	sd	ra,40(sp)
    8000196c:	f022                	sd	s0,32(sp)
    8000196e:	ec26                	sd	s1,24(sp)
    80001970:	e84a                	sd	s2,16(sp)
    80001972:	e44e                	sd	s3,8(sp)
    80001974:	e052                	sd	s4,0(sp)
    80001976:	1800                	addi	s0,sp,48
    80001978:	892a                	mv	s2,a0
    8000197a:	84ae                	mv	s1,a1
    8000197c:	89b2                	mv	s3,a2
    8000197e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001980:	fffff097          	auipc	ra,0xfffff
    80001984:	522080e7          	jalr	1314(ra) # 80000ea2 <myproc>
  if(user_src){
    80001988:	c08d                	beqz	s1,800019aa <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    8000198a:	86d2                	mv	a3,s4
    8000198c:	864e                	mv	a2,s3
    8000198e:	85ca                	mv	a1,s2
    80001990:	6928                	ld	a0,80(a0)
    80001992:	fffff097          	auipc	ra,0xfffff
    80001996:	248080e7          	jalr	584(ra) # 80000bda <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    8000199a:	70a2                	ld	ra,40(sp)
    8000199c:	7402                	ld	s0,32(sp)
    8000199e:	64e2                	ld	s1,24(sp)
    800019a0:	6942                	ld	s2,16(sp)
    800019a2:	69a2                	ld	s3,8(sp)
    800019a4:	6a02                	ld	s4,0(sp)
    800019a6:	6145                	addi	sp,sp,48
    800019a8:	8082                	ret
    memmove(dst, (char*)src, len);
    800019aa:	000a061b          	sext.w	a2,s4
    800019ae:	85ce                	mv	a1,s3
    800019b0:	854a                	mv	a0,s2
    800019b2:	fffff097          	auipc	ra,0xfffff
    800019b6:	82c080e7          	jalr	-2004(ra) # 800001de <memmove>
    return 0;
    800019ba:	8526                	mv	a0,s1
    800019bc:	bff9                	j	8000199a <either_copyin+0x32>

00000000800019be <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800019be:	715d                	addi	sp,sp,-80
    800019c0:	e486                	sd	ra,72(sp)
    800019c2:	e0a2                	sd	s0,64(sp)
    800019c4:	fc26                	sd	s1,56(sp)
    800019c6:	f84a                	sd	s2,48(sp)
    800019c8:	f44e                	sd	s3,40(sp)
    800019ca:	f052                	sd	s4,32(sp)
    800019cc:	ec56                	sd	s5,24(sp)
    800019ce:	e85a                	sd	s6,16(sp)
    800019d0:	e45e                	sd	s7,8(sp)
    800019d2:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800019d4:	00006517          	auipc	a0,0x6
    800019d8:	64450513          	addi	a0,a0,1604 # 80008018 <etext+0x18>
    800019dc:	00004097          	auipc	ra,0x4
    800019e0:	360080e7          	jalr	864(ra) # 80005d3c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800019e4:	0000b497          	auipc	s1,0xb
    800019e8:	bf448493          	addi	s1,s1,-1036 # 8000c5d8 <proc+0x158>
    800019ec:	00010917          	auipc	s2,0x10
    800019f0:	7ec90913          	addi	s2,s2,2028 # 800121d8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019f4:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800019f6:	00007997          	auipc	s3,0x7
    800019fa:	80a98993          	addi	s3,s3,-2038 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    800019fe:	00007a97          	auipc	s5,0x7
    80001a02:	80aa8a93          	addi	s5,s5,-2038 # 80008208 <etext+0x208>
    printf("\n");
    80001a06:	00006a17          	auipc	s4,0x6
    80001a0a:	612a0a13          	addi	s4,s4,1554 # 80008018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a0e:	00007b97          	auipc	s7,0x7
    80001a12:	daab8b93          	addi	s7,s7,-598 # 800087b8 <states.0>
    80001a16:	a00d                	j	80001a38 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a18:	ed86a583          	lw	a1,-296(a3)
    80001a1c:	8556                	mv	a0,s5
    80001a1e:	00004097          	auipc	ra,0x4
    80001a22:	31e080e7          	jalr	798(ra) # 80005d3c <printf>
    printf("\n");
    80001a26:	8552                	mv	a0,s4
    80001a28:	00004097          	auipc	ra,0x4
    80001a2c:	314080e7          	jalr	788(ra) # 80005d3c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a30:	17048493          	addi	s1,s1,368
    80001a34:	03248263          	beq	s1,s2,80001a58 <procdump+0x9a>
    if(p->state == UNUSED)
    80001a38:	86a6                	mv	a3,s1
    80001a3a:	ec04a783          	lw	a5,-320(s1)
    80001a3e:	dbed                	beqz	a5,80001a30 <procdump+0x72>
      state = "???";
    80001a40:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a42:	fcfb6be3          	bltu	s6,a5,80001a18 <procdump+0x5a>
    80001a46:	02079713          	slli	a4,a5,0x20
    80001a4a:	01d75793          	srli	a5,a4,0x1d
    80001a4e:	97de                	add	a5,a5,s7
    80001a50:	6390                	ld	a2,0(a5)
    80001a52:	f279                	bnez	a2,80001a18 <procdump+0x5a>
      state = "???";
    80001a54:	864e                	mv	a2,s3
    80001a56:	b7c9                	j	80001a18 <procdump+0x5a>
  }
}
    80001a58:	60a6                	ld	ra,72(sp)
    80001a5a:	6406                	ld	s0,64(sp)
    80001a5c:	74e2                	ld	s1,56(sp)
    80001a5e:	7942                	ld	s2,48(sp)
    80001a60:	79a2                	ld	s3,40(sp)
    80001a62:	7a02                	ld	s4,32(sp)
    80001a64:	6ae2                	ld	s5,24(sp)
    80001a66:	6b42                	ld	s6,16(sp)
    80001a68:	6ba2                	ld	s7,8(sp)
    80001a6a:	6161                	addi	sp,sp,80
    80001a6c:	8082                	ret

0000000080001a6e <swtch>:
    80001a6e:	00153023          	sd	ra,0(a0)
    80001a72:	00253423          	sd	sp,8(a0)
    80001a76:	e900                	sd	s0,16(a0)
    80001a78:	ed04                	sd	s1,24(a0)
    80001a7a:	03253023          	sd	s2,32(a0)
    80001a7e:	03353423          	sd	s3,40(a0)
    80001a82:	03453823          	sd	s4,48(a0)
    80001a86:	03553c23          	sd	s5,56(a0)
    80001a8a:	05653023          	sd	s6,64(a0)
    80001a8e:	05753423          	sd	s7,72(a0)
    80001a92:	05853823          	sd	s8,80(a0)
    80001a96:	05953c23          	sd	s9,88(a0)
    80001a9a:	07a53023          	sd	s10,96(a0)
    80001a9e:	07b53423          	sd	s11,104(a0)
    80001aa2:	0005b083          	ld	ra,0(a1)
    80001aa6:	0085b103          	ld	sp,8(a1)
    80001aaa:	6980                	ld	s0,16(a1)
    80001aac:	6d84                	ld	s1,24(a1)
    80001aae:	0205b903          	ld	s2,32(a1)
    80001ab2:	0285b983          	ld	s3,40(a1)
    80001ab6:	0305ba03          	ld	s4,48(a1)
    80001aba:	0385ba83          	ld	s5,56(a1)
    80001abe:	0405bb03          	ld	s6,64(a1)
    80001ac2:	0485bb83          	ld	s7,72(a1)
    80001ac6:	0505bc03          	ld	s8,80(a1)
    80001aca:	0585bc83          	ld	s9,88(a1)
    80001ace:	0605bd03          	ld	s10,96(a1)
    80001ad2:	0685bd83          	ld	s11,104(a1)
    80001ad6:	8082                	ret

0000000080001ad8 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001ad8:	1141                	addi	sp,sp,-16
    80001ada:	e406                	sd	ra,8(sp)
    80001adc:	e022                	sd	s0,0(sp)
    80001ade:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001ae0:	00006597          	auipc	a1,0x6
    80001ae4:	76058593          	addi	a1,a1,1888 # 80008240 <etext+0x240>
    80001ae8:	00010517          	auipc	a0,0x10
    80001aec:	59850513          	addi	a0,a0,1432 # 80012080 <tickslock>
    80001af0:	00004097          	auipc	ra,0x4
    80001af4:	6ee080e7          	jalr	1774(ra) # 800061de <initlock>
}
    80001af8:	60a2                	ld	ra,8(sp)
    80001afa:	6402                	ld	s0,0(sp)
    80001afc:	0141                	addi	sp,sp,16
    80001afe:	8082                	ret

0000000080001b00 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001b00:	1141                	addi	sp,sp,-16
    80001b02:	e406                	sd	ra,8(sp)
    80001b04:	e022                	sd	s0,0(sp)
    80001b06:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b08:	00003797          	auipc	a5,0x3
    80001b0c:	61878793          	addi	a5,a5,1560 # 80005120 <kernelvec>
    80001b10:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b14:	60a2                	ld	ra,8(sp)
    80001b16:	6402                	ld	s0,0(sp)
    80001b18:	0141                	addi	sp,sp,16
    80001b1a:	8082                	ret

0000000080001b1c <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b1c:	1141                	addi	sp,sp,-16
    80001b1e:	e406                	sd	ra,8(sp)
    80001b20:	e022                	sd	s0,0(sp)
    80001b22:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001b24:	fffff097          	auipc	ra,0xfffff
    80001b28:	37e080e7          	jalr	894(ra) # 80000ea2 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b2c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001b30:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b32:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001b36:	00005697          	auipc	a3,0x5
    80001b3a:	4ca68693          	addi	a3,a3,1226 # 80007000 <_trampoline>
    80001b3e:	00005717          	auipc	a4,0x5
    80001b42:	4c270713          	addi	a4,a4,1218 # 80007000 <_trampoline>
    80001b46:	8f15                	sub	a4,a4,a3
    80001b48:	040007b7          	lui	a5,0x4000
    80001b4c:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001b4e:	07b2                	slli	a5,a5,0xc
    80001b50:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b52:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001b56:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001b58:	18002673          	csrr	a2,satp
    80001b5c:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001b5e:	6d30                	ld	a2,88(a0)
    80001b60:	6138                	ld	a4,64(a0)
    80001b62:	6585                	lui	a1,0x1
    80001b64:	972e                	add	a4,a4,a1
    80001b66:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001b68:	6d38                	ld	a4,88(a0)
    80001b6a:	00000617          	auipc	a2,0x0
    80001b6e:	14060613          	addi	a2,a2,320 # 80001caa <usertrap>
    80001b72:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001b74:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b76:	8612                	mv	a2,tp
    80001b78:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b7a:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001b7e:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001b82:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b86:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001b8a:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b8c:	6f18                	ld	a4,24(a4)
    80001b8e:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001b92:	692c                	ld	a1,80(a0)
    80001b94:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001b96:	00005717          	auipc	a4,0x5
    80001b9a:	4fa70713          	addi	a4,a4,1274 # 80007090 <userret>
    80001b9e:	8f15                	sub	a4,a4,a3
    80001ba0:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001ba2:	577d                	li	a4,-1
    80001ba4:	177e                	slli	a4,a4,0x3f
    80001ba6:	8dd9                	or	a1,a1,a4
    80001ba8:	02000537          	lui	a0,0x2000
    80001bac:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001bae:	0536                	slli	a0,a0,0xd
    80001bb0:	9782                	jalr	a5
}
    80001bb2:	60a2                	ld	ra,8(sp)
    80001bb4:	6402                	ld	s0,0(sp)
    80001bb6:	0141                	addi	sp,sp,16
    80001bb8:	8082                	ret

0000000080001bba <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001bba:	1101                	addi	sp,sp,-32
    80001bbc:	ec06                	sd	ra,24(sp)
    80001bbe:	e822                	sd	s0,16(sp)
    80001bc0:	e426                	sd	s1,8(sp)
    80001bc2:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001bc4:	00010497          	auipc	s1,0x10
    80001bc8:	4bc48493          	addi	s1,s1,1212 # 80012080 <tickslock>
    80001bcc:	8526                	mv	a0,s1
    80001bce:	00004097          	auipc	ra,0x4
    80001bd2:	6a4080e7          	jalr	1700(ra) # 80006272 <acquire>
  ticks++;
    80001bd6:	0000a517          	auipc	a0,0xa
    80001bda:	44250513          	addi	a0,a0,1090 # 8000c018 <ticks>
    80001bde:	411c                	lw	a5,0(a0)
    80001be0:	2785                	addiw	a5,a5,1
    80001be2:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001be4:	00000097          	auipc	ra,0x0
    80001be8:	b16080e7          	jalr	-1258(ra) # 800016fa <wakeup>
  release(&tickslock);
    80001bec:	8526                	mv	a0,s1
    80001bee:	00004097          	auipc	ra,0x4
    80001bf2:	734080e7          	jalr	1844(ra) # 80006322 <release>
}
    80001bf6:	60e2                	ld	ra,24(sp)
    80001bf8:	6442                	ld	s0,16(sp)
    80001bfa:	64a2                	ld	s1,8(sp)
    80001bfc:	6105                	addi	sp,sp,32
    80001bfe:	8082                	ret

0000000080001c00 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c00:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001c04:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001c06:	0a07d163          	bgez	a5,80001ca8 <devintr+0xa8>
{
    80001c0a:	1101                	addi	sp,sp,-32
    80001c0c:	ec06                	sd	ra,24(sp)
    80001c0e:	e822                	sd	s0,16(sp)
    80001c10:	1000                	addi	s0,sp,32
     (scause & 0xff) == 9){
    80001c12:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001c16:	46a5                	li	a3,9
    80001c18:	00d70c63          	beq	a4,a3,80001c30 <devintr+0x30>
  } else if(scause == 0x8000000000000001L){
    80001c1c:	577d                	li	a4,-1
    80001c1e:	177e                	slli	a4,a4,0x3f
    80001c20:	0705                	addi	a4,a4,1
    return 0;
    80001c22:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001c24:	06e78163          	beq	a5,a4,80001c86 <devintr+0x86>
  }
}
    80001c28:	60e2                	ld	ra,24(sp)
    80001c2a:	6442                	ld	s0,16(sp)
    80001c2c:	6105                	addi	sp,sp,32
    80001c2e:	8082                	ret
    80001c30:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001c32:	00003097          	auipc	ra,0x3
    80001c36:	5fa080e7          	jalr	1530(ra) # 8000522c <plic_claim>
    80001c3a:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001c3c:	47a9                	li	a5,10
    80001c3e:	00f50963          	beq	a0,a5,80001c50 <devintr+0x50>
    } else if(irq == VIRTIO0_IRQ){
    80001c42:	4785                	li	a5,1
    80001c44:	00f50b63          	beq	a0,a5,80001c5a <devintr+0x5a>
    return 1;
    80001c48:	4505                	li	a0,1
    } else if(irq){
    80001c4a:	ec89                	bnez	s1,80001c64 <devintr+0x64>
    80001c4c:	64a2                	ld	s1,8(sp)
    80001c4e:	bfe9                	j	80001c28 <devintr+0x28>
      uartintr();
    80001c50:	00004097          	auipc	ra,0x4
    80001c54:	53e080e7          	jalr	1342(ra) # 8000618e <uartintr>
    if(irq)
    80001c58:	a839                	j	80001c76 <devintr+0x76>
      virtio_disk_intr();
    80001c5a:	00004097          	auipc	ra,0x4
    80001c5e:	a8c080e7          	jalr	-1396(ra) # 800056e6 <virtio_disk_intr>
    if(irq)
    80001c62:	a811                	j	80001c76 <devintr+0x76>
      printf("unexpected interrupt irq=%d\n", irq);
    80001c64:	85a6                	mv	a1,s1
    80001c66:	00006517          	auipc	a0,0x6
    80001c6a:	5e250513          	addi	a0,a0,1506 # 80008248 <etext+0x248>
    80001c6e:	00004097          	auipc	ra,0x4
    80001c72:	0ce080e7          	jalr	206(ra) # 80005d3c <printf>
      plic_complete(irq);
    80001c76:	8526                	mv	a0,s1
    80001c78:	00003097          	auipc	ra,0x3
    80001c7c:	5d8080e7          	jalr	1496(ra) # 80005250 <plic_complete>
    return 1;
    80001c80:	4505                	li	a0,1
    80001c82:	64a2                	ld	s1,8(sp)
    80001c84:	b755                	j	80001c28 <devintr+0x28>
    if(cpuid() == 0){
    80001c86:	fffff097          	auipc	ra,0xfffff
    80001c8a:	1e8080e7          	jalr	488(ra) # 80000e6e <cpuid>
    80001c8e:	c901                	beqz	a0,80001c9e <devintr+0x9e>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001c90:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001c94:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001c96:	14479073          	csrw	sip,a5
    return 2;
    80001c9a:	4509                	li	a0,2
    80001c9c:	b771                	j	80001c28 <devintr+0x28>
      clockintr();
    80001c9e:	00000097          	auipc	ra,0x0
    80001ca2:	f1c080e7          	jalr	-228(ra) # 80001bba <clockintr>
    80001ca6:	b7ed                	j	80001c90 <devintr+0x90>
}
    80001ca8:	8082                	ret

0000000080001caa <usertrap>:
{
    80001caa:	1101                	addi	sp,sp,-32
    80001cac:	ec06                	sd	ra,24(sp)
    80001cae:	e822                	sd	s0,16(sp)
    80001cb0:	e426                	sd	s1,8(sp)
    80001cb2:	e04a                	sd	s2,0(sp)
    80001cb4:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cb6:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001cba:	1007f793          	andi	a5,a5,256
    80001cbe:	e3ad                	bnez	a5,80001d20 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001cc0:	00003797          	auipc	a5,0x3
    80001cc4:	46078793          	addi	a5,a5,1120 # 80005120 <kernelvec>
    80001cc8:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001ccc:	fffff097          	auipc	ra,0xfffff
    80001cd0:	1d6080e7          	jalr	470(ra) # 80000ea2 <myproc>
    80001cd4:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001cd6:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001cd8:	14102773          	csrr	a4,sepc
    80001cdc:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cde:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001ce2:	47a1                	li	a5,8
    80001ce4:	04f71c63          	bne	a4,a5,80001d3c <usertrap+0x92>
    if(p->killed)
    80001ce8:	551c                	lw	a5,40(a0)
    80001cea:	e3b9                	bnez	a5,80001d30 <usertrap+0x86>
    p->trapframe->epc += 4;
    80001cec:	6cb8                	ld	a4,88(s1)
    80001cee:	6f1c                	ld	a5,24(a4)
    80001cf0:	0791                	addi	a5,a5,4
    80001cf2:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cf4:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001cf8:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001cfc:	10079073          	csrw	sstatus,a5
    syscall();
    80001d00:	00000097          	auipc	ra,0x0
    80001d04:	2e0080e7          	jalr	736(ra) # 80001fe0 <syscall>
  if(p->killed)
    80001d08:	549c                	lw	a5,40(s1)
    80001d0a:	ebc1                	bnez	a5,80001d9a <usertrap+0xf0>
  usertrapret();
    80001d0c:	00000097          	auipc	ra,0x0
    80001d10:	e10080e7          	jalr	-496(ra) # 80001b1c <usertrapret>
}
    80001d14:	60e2                	ld	ra,24(sp)
    80001d16:	6442                	ld	s0,16(sp)
    80001d18:	64a2                	ld	s1,8(sp)
    80001d1a:	6902                	ld	s2,0(sp)
    80001d1c:	6105                	addi	sp,sp,32
    80001d1e:	8082                	ret
    panic("usertrap: not from user mode");
    80001d20:	00006517          	auipc	a0,0x6
    80001d24:	54850513          	addi	a0,a0,1352 # 80008268 <etext+0x268>
    80001d28:	00004097          	auipc	ra,0x4
    80001d2c:	fca080e7          	jalr	-54(ra) # 80005cf2 <panic>
      exit(-1);
    80001d30:	557d                	li	a0,-1
    80001d32:	00000097          	auipc	ra,0x0
    80001d36:	a98080e7          	jalr	-1384(ra) # 800017ca <exit>
    80001d3a:	bf4d                	j	80001cec <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80001d3c:	00000097          	auipc	ra,0x0
    80001d40:	ec4080e7          	jalr	-316(ra) # 80001c00 <devintr>
    80001d44:	892a                	mv	s2,a0
    80001d46:	c501                	beqz	a0,80001d4e <usertrap+0xa4>
  if(p->killed)
    80001d48:	549c                	lw	a5,40(s1)
    80001d4a:	c3a1                	beqz	a5,80001d8a <usertrap+0xe0>
    80001d4c:	a815                	j	80001d80 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d4e:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001d52:	5890                	lw	a2,48(s1)
    80001d54:	00006517          	auipc	a0,0x6
    80001d58:	53450513          	addi	a0,a0,1332 # 80008288 <etext+0x288>
    80001d5c:	00004097          	auipc	ra,0x4
    80001d60:	fe0080e7          	jalr	-32(ra) # 80005d3c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d64:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001d68:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001d6c:	00006517          	auipc	a0,0x6
    80001d70:	54c50513          	addi	a0,a0,1356 # 800082b8 <etext+0x2b8>
    80001d74:	00004097          	auipc	ra,0x4
    80001d78:	fc8080e7          	jalr	-56(ra) # 80005d3c <printf>
    p->killed = 1;
    80001d7c:	4785                	li	a5,1
    80001d7e:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001d80:	557d                	li	a0,-1
    80001d82:	00000097          	auipc	ra,0x0
    80001d86:	a48080e7          	jalr	-1464(ra) # 800017ca <exit>
  if(which_dev == 2)
    80001d8a:	4789                	li	a5,2
    80001d8c:	f8f910e3          	bne	s2,a5,80001d0c <usertrap+0x62>
    yield();
    80001d90:	fffff097          	auipc	ra,0xfffff
    80001d94:	7a8080e7          	jalr	1960(ra) # 80001538 <yield>
    80001d98:	bf95                	j	80001d0c <usertrap+0x62>
  int which_dev = 0;
    80001d9a:	4901                	li	s2,0
    80001d9c:	b7d5                	j	80001d80 <usertrap+0xd6>

0000000080001d9e <kerneltrap>:
{
    80001d9e:	7179                	addi	sp,sp,-48
    80001da0:	f406                	sd	ra,40(sp)
    80001da2:	f022                	sd	s0,32(sp)
    80001da4:	ec26                	sd	s1,24(sp)
    80001da6:	e84a                	sd	s2,16(sp)
    80001da8:	e44e                	sd	s3,8(sp)
    80001daa:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dac:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001db0:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001db4:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001db8:	1004f793          	andi	a5,s1,256
    80001dbc:	cb85                	beqz	a5,80001dec <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dbe:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001dc2:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001dc4:	ef85                	bnez	a5,80001dfc <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001dc6:	00000097          	auipc	ra,0x0
    80001dca:	e3a080e7          	jalr	-454(ra) # 80001c00 <devintr>
    80001dce:	cd1d                	beqz	a0,80001e0c <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001dd0:	4789                	li	a5,2
    80001dd2:	06f50a63          	beq	a0,a5,80001e46 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001dd6:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dda:	10049073          	csrw	sstatus,s1
}
    80001dde:	70a2                	ld	ra,40(sp)
    80001de0:	7402                	ld	s0,32(sp)
    80001de2:	64e2                	ld	s1,24(sp)
    80001de4:	6942                	ld	s2,16(sp)
    80001de6:	69a2                	ld	s3,8(sp)
    80001de8:	6145                	addi	sp,sp,48
    80001dea:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001dec:	00006517          	auipc	a0,0x6
    80001df0:	4ec50513          	addi	a0,a0,1260 # 800082d8 <etext+0x2d8>
    80001df4:	00004097          	auipc	ra,0x4
    80001df8:	efe080e7          	jalr	-258(ra) # 80005cf2 <panic>
    panic("kerneltrap: interrupts enabled");
    80001dfc:	00006517          	auipc	a0,0x6
    80001e00:	50450513          	addi	a0,a0,1284 # 80008300 <etext+0x300>
    80001e04:	00004097          	auipc	ra,0x4
    80001e08:	eee080e7          	jalr	-274(ra) # 80005cf2 <panic>
    printf("scause %p\n", scause);
    80001e0c:	85ce                	mv	a1,s3
    80001e0e:	00006517          	auipc	a0,0x6
    80001e12:	51250513          	addi	a0,a0,1298 # 80008320 <etext+0x320>
    80001e16:	00004097          	auipc	ra,0x4
    80001e1a:	f26080e7          	jalr	-218(ra) # 80005d3c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e1e:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e22:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e26:	00006517          	auipc	a0,0x6
    80001e2a:	50a50513          	addi	a0,a0,1290 # 80008330 <etext+0x330>
    80001e2e:	00004097          	auipc	ra,0x4
    80001e32:	f0e080e7          	jalr	-242(ra) # 80005d3c <printf>
    panic("kerneltrap");
    80001e36:	00006517          	auipc	a0,0x6
    80001e3a:	51250513          	addi	a0,a0,1298 # 80008348 <etext+0x348>
    80001e3e:	00004097          	auipc	ra,0x4
    80001e42:	eb4080e7          	jalr	-332(ra) # 80005cf2 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e46:	fffff097          	auipc	ra,0xfffff
    80001e4a:	05c080e7          	jalr	92(ra) # 80000ea2 <myproc>
    80001e4e:	d541                	beqz	a0,80001dd6 <kerneltrap+0x38>
    80001e50:	fffff097          	auipc	ra,0xfffff
    80001e54:	052080e7          	jalr	82(ra) # 80000ea2 <myproc>
    80001e58:	4d18                	lw	a4,24(a0)
    80001e5a:	4791                	li	a5,4
    80001e5c:	f6f71de3          	bne	a4,a5,80001dd6 <kerneltrap+0x38>
    yield();
    80001e60:	fffff097          	auipc	ra,0xfffff
    80001e64:	6d8080e7          	jalr	1752(ra) # 80001538 <yield>
    80001e68:	b7bd                	j	80001dd6 <kerneltrap+0x38>

0000000080001e6a <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001e6a:	1101                	addi	sp,sp,-32
    80001e6c:	ec06                	sd	ra,24(sp)
    80001e6e:	e822                	sd	s0,16(sp)
    80001e70:	e426                	sd	s1,8(sp)
    80001e72:	1000                	addi	s0,sp,32
    80001e74:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e76:	fffff097          	auipc	ra,0xfffff
    80001e7a:	02c080e7          	jalr	44(ra) # 80000ea2 <myproc>
  switch (n) {
    80001e7e:	4795                	li	a5,5
    80001e80:	0497e163          	bltu	a5,s1,80001ec2 <argraw+0x58>
    80001e84:	048a                	slli	s1,s1,0x2
    80001e86:	00007717          	auipc	a4,0x7
    80001e8a:	96270713          	addi	a4,a4,-1694 # 800087e8 <states.0+0x30>
    80001e8e:	94ba                	add	s1,s1,a4
    80001e90:	409c                	lw	a5,0(s1)
    80001e92:	97ba                	add	a5,a5,a4
    80001e94:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001e96:	6d3c                	ld	a5,88(a0)
    80001e98:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001e9a:	60e2                	ld	ra,24(sp)
    80001e9c:	6442                	ld	s0,16(sp)
    80001e9e:	64a2                	ld	s1,8(sp)
    80001ea0:	6105                	addi	sp,sp,32
    80001ea2:	8082                	ret
    return p->trapframe->a1;
    80001ea4:	6d3c                	ld	a5,88(a0)
    80001ea6:	7fa8                	ld	a0,120(a5)
    80001ea8:	bfcd                	j	80001e9a <argraw+0x30>
    return p->trapframe->a2;
    80001eaa:	6d3c                	ld	a5,88(a0)
    80001eac:	63c8                	ld	a0,128(a5)
    80001eae:	b7f5                	j	80001e9a <argraw+0x30>
    return p->trapframe->a3;
    80001eb0:	6d3c                	ld	a5,88(a0)
    80001eb2:	67c8                	ld	a0,136(a5)
    80001eb4:	b7dd                	j	80001e9a <argraw+0x30>
    return p->trapframe->a4;
    80001eb6:	6d3c                	ld	a5,88(a0)
    80001eb8:	6bc8                	ld	a0,144(a5)
    80001eba:	b7c5                	j	80001e9a <argraw+0x30>
    return p->trapframe->a5;
    80001ebc:	6d3c                	ld	a5,88(a0)
    80001ebe:	6fc8                	ld	a0,152(a5)
    80001ec0:	bfe9                	j	80001e9a <argraw+0x30>
  panic("argraw");
    80001ec2:	00006517          	auipc	a0,0x6
    80001ec6:	49650513          	addi	a0,a0,1174 # 80008358 <etext+0x358>
    80001eca:	00004097          	auipc	ra,0x4
    80001ece:	e28080e7          	jalr	-472(ra) # 80005cf2 <panic>

0000000080001ed2 <fetchaddr>:
{
    80001ed2:	1101                	addi	sp,sp,-32
    80001ed4:	ec06                	sd	ra,24(sp)
    80001ed6:	e822                	sd	s0,16(sp)
    80001ed8:	e426                	sd	s1,8(sp)
    80001eda:	e04a                	sd	s2,0(sp)
    80001edc:	1000                	addi	s0,sp,32
    80001ede:	84aa                	mv	s1,a0
    80001ee0:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001ee2:	fffff097          	auipc	ra,0xfffff
    80001ee6:	fc0080e7          	jalr	-64(ra) # 80000ea2 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001eea:	653c                	ld	a5,72(a0)
    80001eec:	02f4f863          	bgeu	s1,a5,80001f1c <fetchaddr+0x4a>
    80001ef0:	00848713          	addi	a4,s1,8
    80001ef4:	02e7e663          	bltu	a5,a4,80001f20 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001ef8:	46a1                	li	a3,8
    80001efa:	8626                	mv	a2,s1
    80001efc:	85ca                	mv	a1,s2
    80001efe:	6928                	ld	a0,80(a0)
    80001f00:	fffff097          	auipc	ra,0xfffff
    80001f04:	cda080e7          	jalr	-806(ra) # 80000bda <copyin>
    80001f08:	00a03533          	snez	a0,a0
    80001f0c:	40a0053b          	negw	a0,a0
}
    80001f10:	60e2                	ld	ra,24(sp)
    80001f12:	6442                	ld	s0,16(sp)
    80001f14:	64a2                	ld	s1,8(sp)
    80001f16:	6902                	ld	s2,0(sp)
    80001f18:	6105                	addi	sp,sp,32
    80001f1a:	8082                	ret
    return -1;
    80001f1c:	557d                	li	a0,-1
    80001f1e:	bfcd                	j	80001f10 <fetchaddr+0x3e>
    80001f20:	557d                	li	a0,-1
    80001f22:	b7fd                	j	80001f10 <fetchaddr+0x3e>

0000000080001f24 <fetchstr>:
{
    80001f24:	7179                	addi	sp,sp,-48
    80001f26:	f406                	sd	ra,40(sp)
    80001f28:	f022                	sd	s0,32(sp)
    80001f2a:	ec26                	sd	s1,24(sp)
    80001f2c:	e84a                	sd	s2,16(sp)
    80001f2e:	e44e                	sd	s3,8(sp)
    80001f30:	1800                	addi	s0,sp,48
    80001f32:	892a                	mv	s2,a0
    80001f34:	84ae                	mv	s1,a1
    80001f36:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001f38:	fffff097          	auipc	ra,0xfffff
    80001f3c:	f6a080e7          	jalr	-150(ra) # 80000ea2 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80001f40:	86ce                	mv	a3,s3
    80001f42:	864a                	mv	a2,s2
    80001f44:	85a6                	mv	a1,s1
    80001f46:	6928                	ld	a0,80(a0)
    80001f48:	fffff097          	auipc	ra,0xfffff
    80001f4c:	d20080e7          	jalr	-736(ra) # 80000c68 <copyinstr>
  if(err < 0)
    80001f50:	00054763          	bltz	a0,80001f5e <fetchstr+0x3a>
  return strlen(buf);
    80001f54:	8526                	mv	a0,s1
    80001f56:	ffffe097          	auipc	ra,0xffffe
    80001f5a:	3b0080e7          	jalr	944(ra) # 80000306 <strlen>
}
    80001f5e:	70a2                	ld	ra,40(sp)
    80001f60:	7402                	ld	s0,32(sp)
    80001f62:	64e2                	ld	s1,24(sp)
    80001f64:	6942                	ld	s2,16(sp)
    80001f66:	69a2                	ld	s3,8(sp)
    80001f68:	6145                	addi	sp,sp,48
    80001f6a:	8082                	ret

0000000080001f6c <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80001f6c:	1101                	addi	sp,sp,-32
    80001f6e:	ec06                	sd	ra,24(sp)
    80001f70:	e822                	sd	s0,16(sp)
    80001f72:	e426                	sd	s1,8(sp)
    80001f74:	1000                	addi	s0,sp,32
    80001f76:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f78:	00000097          	auipc	ra,0x0
    80001f7c:	ef2080e7          	jalr	-270(ra) # 80001e6a <argraw>
    80001f80:	c088                	sw	a0,0(s1)
  return 0;
}
    80001f82:	4501                	li	a0,0
    80001f84:	60e2                	ld	ra,24(sp)
    80001f86:	6442                	ld	s0,16(sp)
    80001f88:	64a2                	ld	s1,8(sp)
    80001f8a:	6105                	addi	sp,sp,32
    80001f8c:	8082                	ret

0000000080001f8e <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80001f8e:	1101                	addi	sp,sp,-32
    80001f90:	ec06                	sd	ra,24(sp)
    80001f92:	e822                	sd	s0,16(sp)
    80001f94:	e426                	sd	s1,8(sp)
    80001f96:	1000                	addi	s0,sp,32
    80001f98:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f9a:	00000097          	auipc	ra,0x0
    80001f9e:	ed0080e7          	jalr	-304(ra) # 80001e6a <argraw>
    80001fa2:	e088                	sd	a0,0(s1)
  return 0;
}
    80001fa4:	4501                	li	a0,0
    80001fa6:	60e2                	ld	ra,24(sp)
    80001fa8:	6442                	ld	s0,16(sp)
    80001faa:	64a2                	ld	s1,8(sp)
    80001fac:	6105                	addi	sp,sp,32
    80001fae:	8082                	ret

0000000080001fb0 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001fb0:	1101                	addi	sp,sp,-32
    80001fb2:	ec06                	sd	ra,24(sp)
    80001fb4:	e822                	sd	s0,16(sp)
    80001fb6:	e426                	sd	s1,8(sp)
    80001fb8:	e04a                	sd	s2,0(sp)
    80001fba:	1000                	addi	s0,sp,32
    80001fbc:	84ae                	mv	s1,a1
    80001fbe:	8932                	mv	s2,a2
  *ip = argraw(n);
    80001fc0:	00000097          	auipc	ra,0x0
    80001fc4:	eaa080e7          	jalr	-342(ra) # 80001e6a <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80001fc8:	864a                	mv	a2,s2
    80001fca:	85a6                	mv	a1,s1
    80001fcc:	00000097          	auipc	ra,0x0
    80001fd0:	f58080e7          	jalr	-168(ra) # 80001f24 <fetchstr>
}
    80001fd4:	60e2                	ld	ra,24(sp)
    80001fd6:	6442                	ld	s0,16(sp)
    80001fd8:	64a2                	ld	s1,8(sp)
    80001fda:	6902                	ld	s2,0(sp)
    80001fdc:	6105                	addi	sp,sp,32
    80001fde:	8082                	ret

0000000080001fe0 <syscall>:
[SYS_close]   "close",
[SYS_trace]   "trace",
};
void
syscall(void)
{
    80001fe0:	7179                	addi	sp,sp,-48
    80001fe2:	f406                	sd	ra,40(sp)
    80001fe4:	f022                	sd	s0,32(sp)
    80001fe6:	ec26                	sd	s1,24(sp)
    80001fe8:	e84a                	sd	s2,16(sp)
    80001fea:	e44e                	sd	s3,8(sp)
    80001fec:	1800                	addi	s0,sp,48
  int num;
  struct proc *p = myproc();
    80001fee:	fffff097          	auipc	ra,0xfffff
    80001ff2:	eb4080e7          	jalr	-332(ra) # 80000ea2 <myproc>
    80001ff6:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001ff8:	05853903          	ld	s2,88(a0)
    80001ffc:	0a893783          	ld	a5,168(s2)
    80002000:	0007899b          	sext.w	s3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002004:	37fd                	addiw	a5,a5,-1
    80002006:	4755                	li	a4,21
    80002008:	04f76763          	bltu	a4,a5,80002056 <syscall+0x76>
    8000200c:	00399713          	slli	a4,s3,0x3
    80002010:	00006797          	auipc	a5,0x6
    80002014:	7f078793          	addi	a5,a5,2032 # 80008800 <syscalls>
    80002018:	97ba                	add	a5,a5,a4
    8000201a:	639c                	ld	a5,0(a5)
    8000201c:	cf8d                	beqz	a5,80002056 <syscall+0x76>
    p->trapframe->a0 = syscalls[num]();
    8000201e:	9782                	jalr	a5
    80002020:	06a93823          	sd	a0,112(s2)

     // 如果当前进程启用了trace跟踪，则按照题设要求打印信息
      if ((p->trace_mask>> num) & 1) {				
    80002024:	1684a783          	lw	a5,360(s1)
    80002028:	4137d7bb          	sraw	a5,a5,s3
    8000202c:	8b85                	andi	a5,a5,1
    8000202e:	c3b9                	beqz	a5,80002074 <syscall+0x94>
          printf("%d: syscall %s -> %d\n",p->pid, syscalls_name[num], p->trapframe->a0); 
    80002030:	6cb8                	ld	a4,88(s1)
    80002032:	098e                	slli	s3,s3,0x3
    80002034:	00006797          	auipc	a5,0x6
    80002038:	7cc78793          	addi	a5,a5,1996 # 80008800 <syscalls>
    8000203c:	97ce                	add	a5,a5,s3
    8000203e:	7b34                	ld	a3,112(a4)
    80002040:	7fd0                	ld	a2,184(a5)
    80002042:	588c                	lw	a1,48(s1)
    80002044:	00006517          	auipc	a0,0x6
    80002048:	31c50513          	addi	a0,a0,796 # 80008360 <etext+0x360>
    8000204c:	00004097          	auipc	ra,0x4
    80002050:	cf0080e7          	jalr	-784(ra) # 80005d3c <printf>
    80002054:	a005                	j	80002074 <syscall+0x94>
      }
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002056:	86ce                	mv	a3,s3
    80002058:	15848613          	addi	a2,s1,344
    8000205c:	588c                	lw	a1,48(s1)
    8000205e:	00006517          	auipc	a0,0x6
    80002062:	31a50513          	addi	a0,a0,794 # 80008378 <etext+0x378>
    80002066:	00004097          	auipc	ra,0x4
    8000206a:	cd6080e7          	jalr	-810(ra) # 80005d3c <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000206e:	6cbc                	ld	a5,88(s1)
    80002070:	577d                	li	a4,-1
    80002072:	fbb8                	sd	a4,112(a5)
  }
}
    80002074:	70a2                	ld	ra,40(sp)
    80002076:	7402                	ld	s0,32(sp)
    80002078:	64e2                	ld	s1,24(sp)
    8000207a:	6942                	ld	s2,16(sp)
    8000207c:	69a2                	ld	s3,8(sp)
    8000207e:	6145                	addi	sp,sp,48
    80002080:	8082                	ret

0000000080002082 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002082:	1101                	addi	sp,sp,-32
    80002084:	ec06                	sd	ra,24(sp)
    80002086:	e822                	sd	s0,16(sp)
    80002088:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    8000208a:	fec40593          	addi	a1,s0,-20
    8000208e:	4501                	li	a0,0
    80002090:	00000097          	auipc	ra,0x0
    80002094:	edc080e7          	jalr	-292(ra) # 80001f6c <argint>
    return -1;
    80002098:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000209a:	00054963          	bltz	a0,800020ac <sys_exit+0x2a>
  exit(n);
    8000209e:	fec42503          	lw	a0,-20(s0)
    800020a2:	fffff097          	auipc	ra,0xfffff
    800020a6:	728080e7          	jalr	1832(ra) # 800017ca <exit>
  return 0;  // not reached
    800020aa:	4781                	li	a5,0
}
    800020ac:	853e                	mv	a0,a5
    800020ae:	60e2                	ld	ra,24(sp)
    800020b0:	6442                	ld	s0,16(sp)
    800020b2:	6105                	addi	sp,sp,32
    800020b4:	8082                	ret

00000000800020b6 <sys_getpid>:

uint64
sys_getpid(void)
{
    800020b6:	1141                	addi	sp,sp,-16
    800020b8:	e406                	sd	ra,8(sp)
    800020ba:	e022                	sd	s0,0(sp)
    800020bc:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800020be:	fffff097          	auipc	ra,0xfffff
    800020c2:	de4080e7          	jalr	-540(ra) # 80000ea2 <myproc>
}
    800020c6:	5908                	lw	a0,48(a0)
    800020c8:	60a2                	ld	ra,8(sp)
    800020ca:	6402                	ld	s0,0(sp)
    800020cc:	0141                	addi	sp,sp,16
    800020ce:	8082                	ret

00000000800020d0 <sys_fork>:

uint64
sys_fork(void)
{
    800020d0:	1141                	addi	sp,sp,-16
    800020d2:	e406                	sd	ra,8(sp)
    800020d4:	e022                	sd	s0,0(sp)
    800020d6:	0800                	addi	s0,sp,16
  return fork();
    800020d8:	fffff097          	auipc	ra,0xfffff
    800020dc:	1a0080e7          	jalr	416(ra) # 80001278 <fork>
}
    800020e0:	60a2                	ld	ra,8(sp)
    800020e2:	6402                	ld	s0,0(sp)
    800020e4:	0141                	addi	sp,sp,16
    800020e6:	8082                	ret

00000000800020e8 <sys_wait>:

uint64
sys_wait(void)
{
    800020e8:	1101                	addi	sp,sp,-32
    800020ea:	ec06                	sd	ra,24(sp)
    800020ec:	e822                	sd	s0,16(sp)
    800020ee:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    800020f0:	fe840593          	addi	a1,s0,-24
    800020f4:	4501                	li	a0,0
    800020f6:	00000097          	auipc	ra,0x0
    800020fa:	e98080e7          	jalr	-360(ra) # 80001f8e <argaddr>
    800020fe:	87aa                	mv	a5,a0
    return -1;
    80002100:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002102:	0007c863          	bltz	a5,80002112 <sys_wait+0x2a>
  return wait(p);
    80002106:	fe843503          	ld	a0,-24(s0)
    8000210a:	fffff097          	auipc	ra,0xfffff
    8000210e:	4ce080e7          	jalr	1230(ra) # 800015d8 <wait>
}
    80002112:	60e2                	ld	ra,24(sp)
    80002114:	6442                	ld	s0,16(sp)
    80002116:	6105                	addi	sp,sp,32
    80002118:	8082                	ret

000000008000211a <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000211a:	7179                	addi	sp,sp,-48
    8000211c:	f406                	sd	ra,40(sp)
    8000211e:	f022                	sd	s0,32(sp)
    80002120:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002122:	fdc40593          	addi	a1,s0,-36
    80002126:	4501                	li	a0,0
    80002128:	00000097          	auipc	ra,0x0
    8000212c:	e44080e7          	jalr	-444(ra) # 80001f6c <argint>
    80002130:	87aa                	mv	a5,a0
    return -1;
    80002132:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002134:	0207c263          	bltz	a5,80002158 <sys_sbrk+0x3e>
    80002138:	ec26                	sd	s1,24(sp)
  addr = myproc()->sz;
    8000213a:	fffff097          	auipc	ra,0xfffff
    8000213e:	d68080e7          	jalr	-664(ra) # 80000ea2 <myproc>
    80002142:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002144:	fdc42503          	lw	a0,-36(s0)
    80002148:	fffff097          	auipc	ra,0xfffff
    8000214c:	0b8080e7          	jalr	184(ra) # 80001200 <growproc>
    80002150:	00054863          	bltz	a0,80002160 <sys_sbrk+0x46>
    return -1;
  return addr;
    80002154:	8526                	mv	a0,s1
    80002156:	64e2                	ld	s1,24(sp)
}
    80002158:	70a2                	ld	ra,40(sp)
    8000215a:	7402                	ld	s0,32(sp)
    8000215c:	6145                	addi	sp,sp,48
    8000215e:	8082                	ret
    return -1;
    80002160:	557d                	li	a0,-1
    80002162:	64e2                	ld	s1,24(sp)
    80002164:	bfd5                	j	80002158 <sys_sbrk+0x3e>

0000000080002166 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002166:	7139                	addi	sp,sp,-64
    80002168:	fc06                	sd	ra,56(sp)
    8000216a:	f822                	sd	s0,48(sp)
    8000216c:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    8000216e:	fcc40593          	addi	a1,s0,-52
    80002172:	4501                	li	a0,0
    80002174:	00000097          	auipc	ra,0x0
    80002178:	df8080e7          	jalr	-520(ra) # 80001f6c <argint>
    return -1;
    8000217c:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000217e:	06054b63          	bltz	a0,800021f4 <sys_sleep+0x8e>
    80002182:	f04a                	sd	s2,32(sp)
  acquire(&tickslock);
    80002184:	00010517          	auipc	a0,0x10
    80002188:	efc50513          	addi	a0,a0,-260 # 80012080 <tickslock>
    8000218c:	00004097          	auipc	ra,0x4
    80002190:	0e6080e7          	jalr	230(ra) # 80006272 <acquire>
  ticks0 = ticks;
    80002194:	0000a917          	auipc	s2,0xa
    80002198:	e8492903          	lw	s2,-380(s2) # 8000c018 <ticks>
  while(ticks - ticks0 < n){
    8000219c:	fcc42783          	lw	a5,-52(s0)
    800021a0:	c3a1                	beqz	a5,800021e0 <sys_sleep+0x7a>
    800021a2:	f426                	sd	s1,40(sp)
    800021a4:	ec4e                	sd	s3,24(sp)
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800021a6:	00010997          	auipc	s3,0x10
    800021aa:	eda98993          	addi	s3,s3,-294 # 80012080 <tickslock>
    800021ae:	0000a497          	auipc	s1,0xa
    800021b2:	e6a48493          	addi	s1,s1,-406 # 8000c018 <ticks>
    if(myproc()->killed){
    800021b6:	fffff097          	auipc	ra,0xfffff
    800021ba:	cec080e7          	jalr	-788(ra) # 80000ea2 <myproc>
    800021be:	551c                	lw	a5,40(a0)
    800021c0:	ef9d                	bnez	a5,800021fe <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    800021c2:	85ce                	mv	a1,s3
    800021c4:	8526                	mv	a0,s1
    800021c6:	fffff097          	auipc	ra,0xfffff
    800021ca:	3ae080e7          	jalr	942(ra) # 80001574 <sleep>
  while(ticks - ticks0 < n){
    800021ce:	409c                	lw	a5,0(s1)
    800021d0:	412787bb          	subw	a5,a5,s2
    800021d4:	fcc42703          	lw	a4,-52(s0)
    800021d8:	fce7efe3          	bltu	a5,a4,800021b6 <sys_sleep+0x50>
    800021dc:	74a2                	ld	s1,40(sp)
    800021de:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    800021e0:	00010517          	auipc	a0,0x10
    800021e4:	ea050513          	addi	a0,a0,-352 # 80012080 <tickslock>
    800021e8:	00004097          	auipc	ra,0x4
    800021ec:	13a080e7          	jalr	314(ra) # 80006322 <release>
  return 0;
    800021f0:	4781                	li	a5,0
    800021f2:	7902                	ld	s2,32(sp)
}
    800021f4:	853e                	mv	a0,a5
    800021f6:	70e2                	ld	ra,56(sp)
    800021f8:	7442                	ld	s0,48(sp)
    800021fa:	6121                	addi	sp,sp,64
    800021fc:	8082                	ret
      release(&tickslock);
    800021fe:	00010517          	auipc	a0,0x10
    80002202:	e8250513          	addi	a0,a0,-382 # 80012080 <tickslock>
    80002206:	00004097          	auipc	ra,0x4
    8000220a:	11c080e7          	jalr	284(ra) # 80006322 <release>
      return -1;
    8000220e:	57fd                	li	a5,-1
    80002210:	74a2                	ld	s1,40(sp)
    80002212:	7902                	ld	s2,32(sp)
    80002214:	69e2                	ld	s3,24(sp)
    80002216:	bff9                	j	800021f4 <sys_sleep+0x8e>

0000000080002218 <sys_kill>:

uint64
sys_kill(void)
{
    80002218:	1101                	addi	sp,sp,-32
    8000221a:	ec06                	sd	ra,24(sp)
    8000221c:	e822                	sd	s0,16(sp)
    8000221e:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002220:	fec40593          	addi	a1,s0,-20
    80002224:	4501                	li	a0,0
    80002226:	00000097          	auipc	ra,0x0
    8000222a:	d46080e7          	jalr	-698(ra) # 80001f6c <argint>
    8000222e:	87aa                	mv	a5,a0
    return -1;
    80002230:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002232:	0007c863          	bltz	a5,80002242 <sys_kill+0x2a>
  return kill(pid);
    80002236:	fec42503          	lw	a0,-20(s0)
    8000223a:	fffff097          	auipc	ra,0xfffff
    8000223e:	666080e7          	jalr	1638(ra) # 800018a0 <kill>
}
    80002242:	60e2                	ld	ra,24(sp)
    80002244:	6442                	ld	s0,16(sp)
    80002246:	6105                	addi	sp,sp,32
    80002248:	8082                	ret

000000008000224a <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000224a:	1101                	addi	sp,sp,-32
    8000224c:	ec06                	sd	ra,24(sp)
    8000224e:	e822                	sd	s0,16(sp)
    80002250:	e426                	sd	s1,8(sp)
    80002252:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002254:	00010517          	auipc	a0,0x10
    80002258:	e2c50513          	addi	a0,a0,-468 # 80012080 <tickslock>
    8000225c:	00004097          	auipc	ra,0x4
    80002260:	016080e7          	jalr	22(ra) # 80006272 <acquire>
  xticks = ticks;
    80002264:	0000a497          	auipc	s1,0xa
    80002268:	db44a483          	lw	s1,-588(s1) # 8000c018 <ticks>
  release(&tickslock);
    8000226c:	00010517          	auipc	a0,0x10
    80002270:	e1450513          	addi	a0,a0,-492 # 80012080 <tickslock>
    80002274:	00004097          	auipc	ra,0x4
    80002278:	0ae080e7          	jalr	174(ra) # 80006322 <release>
  return xticks;
}
    8000227c:	02049513          	slli	a0,s1,0x20
    80002280:	9101                	srli	a0,a0,0x20
    80002282:	60e2                	ld	ra,24(sp)
    80002284:	6442                	ld	s0,16(sp)
    80002286:	64a2                	ld	s1,8(sp)
    80002288:	6105                	addi	sp,sp,32
    8000228a:	8082                	ret

000000008000228c <sys_trace>:
// kernel/sysproc.c
// 当前进程的系统调用跟踪掩码
uint64
sys_trace(void)
{
    8000228c:	1101                	addi	sp,sp,-32
    8000228e:	ec06                	sd	ra,24(sp)
    80002290:	e822                	sd	s0,16(sp)
    80002292:	1000                	addi	s0,sp,32
    int mask;

    if(argint(0, &mask) < 0)                // 获取用户程序传入的数据
    80002294:	fec40593          	addi	a1,s0,-20
    80002298:	4501                	li	a0,0
    8000229a:	00000097          	auipc	ra,0x0
    8000229e:	cd2080e7          	jalr	-814(ra) # 80001f6c <argint>
        return -1;
    800022a2:	57fd                	li	a5,-1
    if(argint(0, &mask) < 0)                // 获取用户程序传入的数据
    800022a4:	00054b63          	bltz	a0,800022ba <sys_trace+0x2e>

    myproc()->trace_mask= mask;    // 设置调用进程的kama_syscall_trace掩码mask
    800022a8:	fffff097          	auipc	ra,0xfffff
    800022ac:	bfa080e7          	jalr	-1030(ra) # 80000ea2 <myproc>
    800022b0:	fec42783          	lw	a5,-20(s0)
    800022b4:	16f52423          	sw	a5,360(a0)
    return 0;
    800022b8:	4781                	li	a5,0
}
    800022ba:	853e                	mv	a0,a5
    800022bc:	60e2                	ld	ra,24(sp)
    800022be:	6442                	ld	s0,16(sp)
    800022c0:	6105                	addi	sp,sp,32
    800022c2:	8082                	ret

00000000800022c4 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800022c4:	7179                	addi	sp,sp,-48
    800022c6:	f406                	sd	ra,40(sp)
    800022c8:	f022                	sd	s0,32(sp)
    800022ca:	ec26                	sd	s1,24(sp)
    800022cc:	e84a                	sd	s2,16(sp)
    800022ce:	e44e                	sd	s3,8(sp)
    800022d0:	e052                	sd	s4,0(sp)
    800022d2:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800022d4:	00006597          	auipc	a1,0x6
    800022d8:	16c58593          	addi	a1,a1,364 # 80008440 <etext+0x440>
    800022dc:	00010517          	auipc	a0,0x10
    800022e0:	dbc50513          	addi	a0,a0,-580 # 80012098 <bcache>
    800022e4:	00004097          	auipc	ra,0x4
    800022e8:	efa080e7          	jalr	-262(ra) # 800061de <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800022ec:	00018797          	auipc	a5,0x18
    800022f0:	dac78793          	addi	a5,a5,-596 # 8001a098 <bcache+0x8000>
    800022f4:	00018717          	auipc	a4,0x18
    800022f8:	00c70713          	addi	a4,a4,12 # 8001a300 <bcache+0x8268>
    800022fc:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002300:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002304:	00010497          	auipc	s1,0x10
    80002308:	dac48493          	addi	s1,s1,-596 # 800120b0 <bcache+0x18>
    b->next = bcache.head.next;
    8000230c:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    8000230e:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002310:	00006a17          	auipc	s4,0x6
    80002314:	138a0a13          	addi	s4,s4,312 # 80008448 <etext+0x448>
    b->next = bcache.head.next;
    80002318:	2b893783          	ld	a5,696(s2)
    8000231c:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    8000231e:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002322:	85d2                	mv	a1,s4
    80002324:	01048513          	addi	a0,s1,16
    80002328:	00001097          	auipc	ra,0x1
    8000232c:	4ba080e7          	jalr	1210(ra) # 800037e2 <initsleeplock>
    bcache.head.next->prev = b;
    80002330:	2b893783          	ld	a5,696(s2)
    80002334:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002336:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000233a:	45848493          	addi	s1,s1,1112
    8000233e:	fd349de3          	bne	s1,s3,80002318 <binit+0x54>
  }
}
    80002342:	70a2                	ld	ra,40(sp)
    80002344:	7402                	ld	s0,32(sp)
    80002346:	64e2                	ld	s1,24(sp)
    80002348:	6942                	ld	s2,16(sp)
    8000234a:	69a2                	ld	s3,8(sp)
    8000234c:	6a02                	ld	s4,0(sp)
    8000234e:	6145                	addi	sp,sp,48
    80002350:	8082                	ret

0000000080002352 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002352:	7179                	addi	sp,sp,-48
    80002354:	f406                	sd	ra,40(sp)
    80002356:	f022                	sd	s0,32(sp)
    80002358:	ec26                	sd	s1,24(sp)
    8000235a:	e84a                	sd	s2,16(sp)
    8000235c:	e44e                	sd	s3,8(sp)
    8000235e:	1800                	addi	s0,sp,48
    80002360:	892a                	mv	s2,a0
    80002362:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002364:	00010517          	auipc	a0,0x10
    80002368:	d3450513          	addi	a0,a0,-716 # 80012098 <bcache>
    8000236c:	00004097          	auipc	ra,0x4
    80002370:	f06080e7          	jalr	-250(ra) # 80006272 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002374:	00018497          	auipc	s1,0x18
    80002378:	fdc4b483          	ld	s1,-36(s1) # 8001a350 <bcache+0x82b8>
    8000237c:	00018797          	auipc	a5,0x18
    80002380:	f8478793          	addi	a5,a5,-124 # 8001a300 <bcache+0x8268>
    80002384:	02f48f63          	beq	s1,a5,800023c2 <bread+0x70>
    80002388:	873e                	mv	a4,a5
    8000238a:	a021                	j	80002392 <bread+0x40>
    8000238c:	68a4                	ld	s1,80(s1)
    8000238e:	02e48a63          	beq	s1,a4,800023c2 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002392:	449c                	lw	a5,8(s1)
    80002394:	ff279ce3          	bne	a5,s2,8000238c <bread+0x3a>
    80002398:	44dc                	lw	a5,12(s1)
    8000239a:	ff3799e3          	bne	a5,s3,8000238c <bread+0x3a>
      b->refcnt++;
    8000239e:	40bc                	lw	a5,64(s1)
    800023a0:	2785                	addiw	a5,a5,1
    800023a2:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800023a4:	00010517          	auipc	a0,0x10
    800023a8:	cf450513          	addi	a0,a0,-780 # 80012098 <bcache>
    800023ac:	00004097          	auipc	ra,0x4
    800023b0:	f76080e7          	jalr	-138(ra) # 80006322 <release>
      acquiresleep(&b->lock);
    800023b4:	01048513          	addi	a0,s1,16
    800023b8:	00001097          	auipc	ra,0x1
    800023bc:	464080e7          	jalr	1124(ra) # 8000381c <acquiresleep>
      return b;
    800023c0:	a8b9                	j	8000241e <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800023c2:	00018497          	auipc	s1,0x18
    800023c6:	f864b483          	ld	s1,-122(s1) # 8001a348 <bcache+0x82b0>
    800023ca:	00018797          	auipc	a5,0x18
    800023ce:	f3678793          	addi	a5,a5,-202 # 8001a300 <bcache+0x8268>
    800023d2:	00f48863          	beq	s1,a5,800023e2 <bread+0x90>
    800023d6:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800023d8:	40bc                	lw	a5,64(s1)
    800023da:	cf81                	beqz	a5,800023f2 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800023dc:	64a4                	ld	s1,72(s1)
    800023de:	fee49de3          	bne	s1,a4,800023d8 <bread+0x86>
  panic("bget: no buffers");
    800023e2:	00006517          	auipc	a0,0x6
    800023e6:	06e50513          	addi	a0,a0,110 # 80008450 <etext+0x450>
    800023ea:	00004097          	auipc	ra,0x4
    800023ee:	908080e7          	jalr	-1784(ra) # 80005cf2 <panic>
      b->dev = dev;
    800023f2:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800023f6:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800023fa:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800023fe:	4785                	li	a5,1
    80002400:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002402:	00010517          	auipc	a0,0x10
    80002406:	c9650513          	addi	a0,a0,-874 # 80012098 <bcache>
    8000240a:	00004097          	auipc	ra,0x4
    8000240e:	f18080e7          	jalr	-232(ra) # 80006322 <release>
      acquiresleep(&b->lock);
    80002412:	01048513          	addi	a0,s1,16
    80002416:	00001097          	auipc	ra,0x1
    8000241a:	406080e7          	jalr	1030(ra) # 8000381c <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    8000241e:	409c                	lw	a5,0(s1)
    80002420:	cb89                	beqz	a5,80002432 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002422:	8526                	mv	a0,s1
    80002424:	70a2                	ld	ra,40(sp)
    80002426:	7402                	ld	s0,32(sp)
    80002428:	64e2                	ld	s1,24(sp)
    8000242a:	6942                	ld	s2,16(sp)
    8000242c:	69a2                	ld	s3,8(sp)
    8000242e:	6145                	addi	sp,sp,48
    80002430:	8082                	ret
    virtio_disk_rw(b, 0);
    80002432:	4581                	li	a1,0
    80002434:	8526                	mv	a0,s1
    80002436:	00003097          	auipc	ra,0x3
    8000243a:	028080e7          	jalr	40(ra) # 8000545e <virtio_disk_rw>
    b->valid = 1;
    8000243e:	4785                	li	a5,1
    80002440:	c09c                	sw	a5,0(s1)
  return b;
    80002442:	b7c5                	j	80002422 <bread+0xd0>

0000000080002444 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002444:	1101                	addi	sp,sp,-32
    80002446:	ec06                	sd	ra,24(sp)
    80002448:	e822                	sd	s0,16(sp)
    8000244a:	e426                	sd	s1,8(sp)
    8000244c:	1000                	addi	s0,sp,32
    8000244e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002450:	0541                	addi	a0,a0,16
    80002452:	00001097          	auipc	ra,0x1
    80002456:	464080e7          	jalr	1124(ra) # 800038b6 <holdingsleep>
    8000245a:	cd01                	beqz	a0,80002472 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    8000245c:	4585                	li	a1,1
    8000245e:	8526                	mv	a0,s1
    80002460:	00003097          	auipc	ra,0x3
    80002464:	ffe080e7          	jalr	-2(ra) # 8000545e <virtio_disk_rw>
}
    80002468:	60e2                	ld	ra,24(sp)
    8000246a:	6442                	ld	s0,16(sp)
    8000246c:	64a2                	ld	s1,8(sp)
    8000246e:	6105                	addi	sp,sp,32
    80002470:	8082                	ret
    panic("bwrite");
    80002472:	00006517          	auipc	a0,0x6
    80002476:	ff650513          	addi	a0,a0,-10 # 80008468 <etext+0x468>
    8000247a:	00004097          	auipc	ra,0x4
    8000247e:	878080e7          	jalr	-1928(ra) # 80005cf2 <panic>

0000000080002482 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002482:	1101                	addi	sp,sp,-32
    80002484:	ec06                	sd	ra,24(sp)
    80002486:	e822                	sd	s0,16(sp)
    80002488:	e426                	sd	s1,8(sp)
    8000248a:	e04a                	sd	s2,0(sp)
    8000248c:	1000                	addi	s0,sp,32
    8000248e:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002490:	01050913          	addi	s2,a0,16
    80002494:	854a                	mv	a0,s2
    80002496:	00001097          	auipc	ra,0x1
    8000249a:	420080e7          	jalr	1056(ra) # 800038b6 <holdingsleep>
    8000249e:	c535                	beqz	a0,8000250a <brelse+0x88>
    panic("brelse");

  releasesleep(&b->lock);
    800024a0:	854a                	mv	a0,s2
    800024a2:	00001097          	auipc	ra,0x1
    800024a6:	3d0080e7          	jalr	976(ra) # 80003872 <releasesleep>

  acquire(&bcache.lock);
    800024aa:	00010517          	auipc	a0,0x10
    800024ae:	bee50513          	addi	a0,a0,-1042 # 80012098 <bcache>
    800024b2:	00004097          	auipc	ra,0x4
    800024b6:	dc0080e7          	jalr	-576(ra) # 80006272 <acquire>
  b->refcnt--;
    800024ba:	40bc                	lw	a5,64(s1)
    800024bc:	37fd                	addiw	a5,a5,-1
    800024be:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800024c0:	e79d                	bnez	a5,800024ee <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800024c2:	68b8                	ld	a4,80(s1)
    800024c4:	64bc                	ld	a5,72(s1)
    800024c6:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800024c8:	68b8                	ld	a4,80(s1)
    800024ca:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800024cc:	00018797          	auipc	a5,0x18
    800024d0:	bcc78793          	addi	a5,a5,-1076 # 8001a098 <bcache+0x8000>
    800024d4:	2b87b703          	ld	a4,696(a5)
    800024d8:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800024da:	00018717          	auipc	a4,0x18
    800024de:	e2670713          	addi	a4,a4,-474 # 8001a300 <bcache+0x8268>
    800024e2:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800024e4:	2b87b703          	ld	a4,696(a5)
    800024e8:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800024ea:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800024ee:	00010517          	auipc	a0,0x10
    800024f2:	baa50513          	addi	a0,a0,-1110 # 80012098 <bcache>
    800024f6:	00004097          	auipc	ra,0x4
    800024fa:	e2c080e7          	jalr	-468(ra) # 80006322 <release>
}
    800024fe:	60e2                	ld	ra,24(sp)
    80002500:	6442                	ld	s0,16(sp)
    80002502:	64a2                	ld	s1,8(sp)
    80002504:	6902                	ld	s2,0(sp)
    80002506:	6105                	addi	sp,sp,32
    80002508:	8082                	ret
    panic("brelse");
    8000250a:	00006517          	auipc	a0,0x6
    8000250e:	f6650513          	addi	a0,a0,-154 # 80008470 <etext+0x470>
    80002512:	00003097          	auipc	ra,0x3
    80002516:	7e0080e7          	jalr	2016(ra) # 80005cf2 <panic>

000000008000251a <bpin>:

void
bpin(struct buf *b) {
    8000251a:	1101                	addi	sp,sp,-32
    8000251c:	ec06                	sd	ra,24(sp)
    8000251e:	e822                	sd	s0,16(sp)
    80002520:	e426                	sd	s1,8(sp)
    80002522:	1000                	addi	s0,sp,32
    80002524:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002526:	00010517          	auipc	a0,0x10
    8000252a:	b7250513          	addi	a0,a0,-1166 # 80012098 <bcache>
    8000252e:	00004097          	auipc	ra,0x4
    80002532:	d44080e7          	jalr	-700(ra) # 80006272 <acquire>
  b->refcnt++;
    80002536:	40bc                	lw	a5,64(s1)
    80002538:	2785                	addiw	a5,a5,1
    8000253a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000253c:	00010517          	auipc	a0,0x10
    80002540:	b5c50513          	addi	a0,a0,-1188 # 80012098 <bcache>
    80002544:	00004097          	auipc	ra,0x4
    80002548:	dde080e7          	jalr	-546(ra) # 80006322 <release>
}
    8000254c:	60e2                	ld	ra,24(sp)
    8000254e:	6442                	ld	s0,16(sp)
    80002550:	64a2                	ld	s1,8(sp)
    80002552:	6105                	addi	sp,sp,32
    80002554:	8082                	ret

0000000080002556 <bunpin>:

void
bunpin(struct buf *b) {
    80002556:	1101                	addi	sp,sp,-32
    80002558:	ec06                	sd	ra,24(sp)
    8000255a:	e822                	sd	s0,16(sp)
    8000255c:	e426                	sd	s1,8(sp)
    8000255e:	1000                	addi	s0,sp,32
    80002560:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002562:	00010517          	auipc	a0,0x10
    80002566:	b3650513          	addi	a0,a0,-1226 # 80012098 <bcache>
    8000256a:	00004097          	auipc	ra,0x4
    8000256e:	d08080e7          	jalr	-760(ra) # 80006272 <acquire>
  b->refcnt--;
    80002572:	40bc                	lw	a5,64(s1)
    80002574:	37fd                	addiw	a5,a5,-1
    80002576:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002578:	00010517          	auipc	a0,0x10
    8000257c:	b2050513          	addi	a0,a0,-1248 # 80012098 <bcache>
    80002580:	00004097          	auipc	ra,0x4
    80002584:	da2080e7          	jalr	-606(ra) # 80006322 <release>
}
    80002588:	60e2                	ld	ra,24(sp)
    8000258a:	6442                	ld	s0,16(sp)
    8000258c:	64a2                	ld	s1,8(sp)
    8000258e:	6105                	addi	sp,sp,32
    80002590:	8082                	ret

0000000080002592 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002592:	1101                	addi	sp,sp,-32
    80002594:	ec06                	sd	ra,24(sp)
    80002596:	e822                	sd	s0,16(sp)
    80002598:	e426                	sd	s1,8(sp)
    8000259a:	e04a                	sd	s2,0(sp)
    8000259c:	1000                	addi	s0,sp,32
    8000259e:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800025a0:	00d5d79b          	srliw	a5,a1,0xd
    800025a4:	00018597          	auipc	a1,0x18
    800025a8:	1d05a583          	lw	a1,464(a1) # 8001a774 <sb+0x1c>
    800025ac:	9dbd                	addw	a1,a1,a5
    800025ae:	00000097          	auipc	ra,0x0
    800025b2:	da4080e7          	jalr	-604(ra) # 80002352 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800025b6:	0074f713          	andi	a4,s1,7
    800025ba:	4785                	li	a5,1
    800025bc:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    800025c0:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    800025c2:	90d9                	srli	s1,s1,0x36
    800025c4:	00950733          	add	a4,a0,s1
    800025c8:	05874703          	lbu	a4,88(a4)
    800025cc:	00e7f6b3          	and	a3,a5,a4
    800025d0:	c69d                	beqz	a3,800025fe <bfree+0x6c>
    800025d2:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800025d4:	94aa                	add	s1,s1,a0
    800025d6:	fff7c793          	not	a5,a5
    800025da:	8f7d                	and	a4,a4,a5
    800025dc:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800025e0:	00001097          	auipc	ra,0x1
    800025e4:	11e080e7          	jalr	286(ra) # 800036fe <log_write>
  brelse(bp);
    800025e8:	854a                	mv	a0,s2
    800025ea:	00000097          	auipc	ra,0x0
    800025ee:	e98080e7          	jalr	-360(ra) # 80002482 <brelse>
}
    800025f2:	60e2                	ld	ra,24(sp)
    800025f4:	6442                	ld	s0,16(sp)
    800025f6:	64a2                	ld	s1,8(sp)
    800025f8:	6902                	ld	s2,0(sp)
    800025fa:	6105                	addi	sp,sp,32
    800025fc:	8082                	ret
    panic("freeing free block");
    800025fe:	00006517          	auipc	a0,0x6
    80002602:	e7a50513          	addi	a0,a0,-390 # 80008478 <etext+0x478>
    80002606:	00003097          	auipc	ra,0x3
    8000260a:	6ec080e7          	jalr	1772(ra) # 80005cf2 <panic>

000000008000260e <balloc>:
{
    8000260e:	715d                	addi	sp,sp,-80
    80002610:	e486                	sd	ra,72(sp)
    80002612:	e0a2                	sd	s0,64(sp)
    80002614:	fc26                	sd	s1,56(sp)
    80002616:	f84a                	sd	s2,48(sp)
    80002618:	f44e                	sd	s3,40(sp)
    8000261a:	f052                	sd	s4,32(sp)
    8000261c:	ec56                	sd	s5,24(sp)
    8000261e:	e85a                	sd	s6,16(sp)
    80002620:	e45e                	sd	s7,8(sp)
    80002622:	e062                	sd	s8,0(sp)
    80002624:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    80002626:	00018797          	auipc	a5,0x18
    8000262a:	1367a783          	lw	a5,310(a5) # 8001a75c <sb+0x4>
    8000262e:	c7c1                	beqz	a5,800026b6 <balloc+0xa8>
    80002630:	8baa                	mv	s7,a0
    80002632:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002634:	00018b17          	auipc	s6,0x18
    80002638:	124b0b13          	addi	s6,s6,292 # 8001a758 <sb>
      m = 1 << (bi % 8);
    8000263c:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000263e:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002640:	6c09                	lui	s8,0x2
    80002642:	a821                	j	8000265a <balloc+0x4c>
    brelse(bp);
    80002644:	854a                	mv	a0,s2
    80002646:	00000097          	auipc	ra,0x0
    8000264a:	e3c080e7          	jalr	-452(ra) # 80002482 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000264e:	015c0abb          	addw	s5,s8,s5
    80002652:	004b2783          	lw	a5,4(s6)
    80002656:	06faf063          	bgeu	s5,a5,800026b6 <balloc+0xa8>
    bp = bread(dev, BBLOCK(b, sb));
    8000265a:	41fad79b          	sraiw	a5,s5,0x1f
    8000265e:	0137d79b          	srliw	a5,a5,0x13
    80002662:	015787bb          	addw	a5,a5,s5
    80002666:	40d7d79b          	sraiw	a5,a5,0xd
    8000266a:	01cb2583          	lw	a1,28(s6)
    8000266e:	9dbd                	addw	a1,a1,a5
    80002670:	855e                	mv	a0,s7
    80002672:	00000097          	auipc	ra,0x0
    80002676:	ce0080e7          	jalr	-800(ra) # 80002352 <bread>
    8000267a:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000267c:	004b2503          	lw	a0,4(s6)
    80002680:	84d6                	mv	s1,s5
    80002682:	4701                	li	a4,0
    80002684:	fca4f0e3          	bgeu	s1,a0,80002644 <balloc+0x36>
      m = 1 << (bi % 8);
    80002688:	00777693          	andi	a3,a4,7
    8000268c:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002690:	41f7579b          	sraiw	a5,a4,0x1f
    80002694:	01d7d79b          	srliw	a5,a5,0x1d
    80002698:	9fb9                	addw	a5,a5,a4
    8000269a:	4037d79b          	sraiw	a5,a5,0x3
    8000269e:	00f90633          	add	a2,s2,a5
    800026a2:	05864603          	lbu	a2,88(a2)
    800026a6:	00c6f5b3          	and	a1,a3,a2
    800026aa:	cd91                	beqz	a1,800026c6 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800026ac:	2705                	addiw	a4,a4,1
    800026ae:	2485                	addiw	s1,s1,1
    800026b0:	fd471ae3          	bne	a4,s4,80002684 <balloc+0x76>
    800026b4:	bf41                	j	80002644 <balloc+0x36>
  panic("balloc: out of blocks");
    800026b6:	00006517          	auipc	a0,0x6
    800026ba:	dda50513          	addi	a0,a0,-550 # 80008490 <etext+0x490>
    800026be:	00003097          	auipc	ra,0x3
    800026c2:	634080e7          	jalr	1588(ra) # 80005cf2 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800026c6:	97ca                	add	a5,a5,s2
    800026c8:	8e55                	or	a2,a2,a3
    800026ca:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800026ce:	854a                	mv	a0,s2
    800026d0:	00001097          	auipc	ra,0x1
    800026d4:	02e080e7          	jalr	46(ra) # 800036fe <log_write>
        brelse(bp);
    800026d8:	854a                	mv	a0,s2
    800026da:	00000097          	auipc	ra,0x0
    800026de:	da8080e7          	jalr	-600(ra) # 80002482 <brelse>
  bp = bread(dev, bno);
    800026e2:	85a6                	mv	a1,s1
    800026e4:	855e                	mv	a0,s7
    800026e6:	00000097          	auipc	ra,0x0
    800026ea:	c6c080e7          	jalr	-916(ra) # 80002352 <bread>
    800026ee:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800026f0:	40000613          	li	a2,1024
    800026f4:	4581                	li	a1,0
    800026f6:	05850513          	addi	a0,a0,88
    800026fa:	ffffe097          	auipc	ra,0xffffe
    800026fe:	a80080e7          	jalr	-1408(ra) # 8000017a <memset>
  log_write(bp);
    80002702:	854a                	mv	a0,s2
    80002704:	00001097          	auipc	ra,0x1
    80002708:	ffa080e7          	jalr	-6(ra) # 800036fe <log_write>
  brelse(bp);
    8000270c:	854a                	mv	a0,s2
    8000270e:	00000097          	auipc	ra,0x0
    80002712:	d74080e7          	jalr	-652(ra) # 80002482 <brelse>
}
    80002716:	8526                	mv	a0,s1
    80002718:	60a6                	ld	ra,72(sp)
    8000271a:	6406                	ld	s0,64(sp)
    8000271c:	74e2                	ld	s1,56(sp)
    8000271e:	7942                	ld	s2,48(sp)
    80002720:	79a2                	ld	s3,40(sp)
    80002722:	7a02                	ld	s4,32(sp)
    80002724:	6ae2                	ld	s5,24(sp)
    80002726:	6b42                	ld	s6,16(sp)
    80002728:	6ba2                	ld	s7,8(sp)
    8000272a:	6c02                	ld	s8,0(sp)
    8000272c:	6161                	addi	sp,sp,80
    8000272e:	8082                	ret

0000000080002730 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80002730:	7179                	addi	sp,sp,-48
    80002732:	f406                	sd	ra,40(sp)
    80002734:	f022                	sd	s0,32(sp)
    80002736:	ec26                	sd	s1,24(sp)
    80002738:	e84a                	sd	s2,16(sp)
    8000273a:	e44e                	sd	s3,8(sp)
    8000273c:	1800                	addi	s0,sp,48
    8000273e:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002740:	47ad                	li	a5,11
    80002742:	04b7fd63          	bgeu	a5,a1,8000279c <bmap+0x6c>
    80002746:	e052                	sd	s4,0(sp)
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002748:	ff45849b          	addiw	s1,a1,-12

  if(bn < NINDIRECT){
    8000274c:	0ff00793          	li	a5,255
    80002750:	0897ef63          	bltu	a5,s1,800027ee <bmap+0xbe>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002754:	08052583          	lw	a1,128(a0)
    80002758:	c5a5                	beqz	a1,800027c0 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    8000275a:	00092503          	lw	a0,0(s2)
    8000275e:	00000097          	auipc	ra,0x0
    80002762:	bf4080e7          	jalr	-1036(ra) # 80002352 <bread>
    80002766:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002768:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000276c:	02049713          	slli	a4,s1,0x20
    80002770:	01e75593          	srli	a1,a4,0x1e
    80002774:	00b784b3          	add	s1,a5,a1
    80002778:	0004a983          	lw	s3,0(s1)
    8000277c:	04098b63          	beqz	s3,800027d2 <bmap+0xa2>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80002780:	8552                	mv	a0,s4
    80002782:	00000097          	auipc	ra,0x0
    80002786:	d00080e7          	jalr	-768(ra) # 80002482 <brelse>
    return addr;
    8000278a:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    8000278c:	854e                	mv	a0,s3
    8000278e:	70a2                	ld	ra,40(sp)
    80002790:	7402                	ld	s0,32(sp)
    80002792:	64e2                	ld	s1,24(sp)
    80002794:	6942                	ld	s2,16(sp)
    80002796:	69a2                	ld	s3,8(sp)
    80002798:	6145                	addi	sp,sp,48
    8000279a:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    8000279c:	02059793          	slli	a5,a1,0x20
    800027a0:	01e7d593          	srli	a1,a5,0x1e
    800027a4:	00b504b3          	add	s1,a0,a1
    800027a8:	0504a983          	lw	s3,80(s1)
    800027ac:	fe0990e3          	bnez	s3,8000278c <bmap+0x5c>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800027b0:	4108                	lw	a0,0(a0)
    800027b2:	00000097          	auipc	ra,0x0
    800027b6:	e5c080e7          	jalr	-420(ra) # 8000260e <balloc>
    800027ba:	89aa                	mv	s3,a0
    800027bc:	c8a8                	sw	a0,80(s1)
    800027be:	b7f9                	j	8000278c <bmap+0x5c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800027c0:	4108                	lw	a0,0(a0)
    800027c2:	00000097          	auipc	ra,0x0
    800027c6:	e4c080e7          	jalr	-436(ra) # 8000260e <balloc>
    800027ca:	85aa                	mv	a1,a0
    800027cc:	08a92023          	sw	a0,128(s2)
    800027d0:	b769                	j	8000275a <bmap+0x2a>
      a[bn] = addr = balloc(ip->dev);
    800027d2:	00092503          	lw	a0,0(s2)
    800027d6:	00000097          	auipc	ra,0x0
    800027da:	e38080e7          	jalr	-456(ra) # 8000260e <balloc>
    800027de:	89aa                	mv	s3,a0
    800027e0:	c088                	sw	a0,0(s1)
      log_write(bp);
    800027e2:	8552                	mv	a0,s4
    800027e4:	00001097          	auipc	ra,0x1
    800027e8:	f1a080e7          	jalr	-230(ra) # 800036fe <log_write>
    800027ec:	bf51                	j	80002780 <bmap+0x50>
  panic("bmap: out of range");
    800027ee:	00006517          	auipc	a0,0x6
    800027f2:	cba50513          	addi	a0,a0,-838 # 800084a8 <etext+0x4a8>
    800027f6:	00003097          	auipc	ra,0x3
    800027fa:	4fc080e7          	jalr	1276(ra) # 80005cf2 <panic>

00000000800027fe <iget>:
{
    800027fe:	7179                	addi	sp,sp,-48
    80002800:	f406                	sd	ra,40(sp)
    80002802:	f022                	sd	s0,32(sp)
    80002804:	ec26                	sd	s1,24(sp)
    80002806:	e84a                	sd	s2,16(sp)
    80002808:	e44e                	sd	s3,8(sp)
    8000280a:	e052                	sd	s4,0(sp)
    8000280c:	1800                	addi	s0,sp,48
    8000280e:	89aa                	mv	s3,a0
    80002810:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002812:	00018517          	auipc	a0,0x18
    80002816:	f6650513          	addi	a0,a0,-154 # 8001a778 <itable>
    8000281a:	00004097          	auipc	ra,0x4
    8000281e:	a58080e7          	jalr	-1448(ra) # 80006272 <acquire>
  empty = 0;
    80002822:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002824:	00018497          	auipc	s1,0x18
    80002828:	f6c48493          	addi	s1,s1,-148 # 8001a790 <itable+0x18>
    8000282c:	0001a697          	auipc	a3,0x1a
    80002830:	9f468693          	addi	a3,a3,-1548 # 8001c220 <log>
    80002834:	a039                	j	80002842 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002836:	02090b63          	beqz	s2,8000286c <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000283a:	08848493          	addi	s1,s1,136
    8000283e:	02d48a63          	beq	s1,a3,80002872 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002842:	449c                	lw	a5,8(s1)
    80002844:	fef059e3          	blez	a5,80002836 <iget+0x38>
    80002848:	4098                	lw	a4,0(s1)
    8000284a:	ff3716e3          	bne	a4,s3,80002836 <iget+0x38>
    8000284e:	40d8                	lw	a4,4(s1)
    80002850:	ff4713e3          	bne	a4,s4,80002836 <iget+0x38>
      ip->ref++;
    80002854:	2785                	addiw	a5,a5,1
    80002856:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002858:	00018517          	auipc	a0,0x18
    8000285c:	f2050513          	addi	a0,a0,-224 # 8001a778 <itable>
    80002860:	00004097          	auipc	ra,0x4
    80002864:	ac2080e7          	jalr	-1342(ra) # 80006322 <release>
      return ip;
    80002868:	8926                	mv	s2,s1
    8000286a:	a03d                	j	80002898 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000286c:	f7f9                	bnez	a5,8000283a <iget+0x3c>
      empty = ip;
    8000286e:	8926                	mv	s2,s1
    80002870:	b7e9                	j	8000283a <iget+0x3c>
  if(empty == 0)
    80002872:	02090c63          	beqz	s2,800028aa <iget+0xac>
  ip->dev = dev;
    80002876:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    8000287a:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000287e:	4785                	li	a5,1
    80002880:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002884:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002888:	00018517          	auipc	a0,0x18
    8000288c:	ef050513          	addi	a0,a0,-272 # 8001a778 <itable>
    80002890:	00004097          	auipc	ra,0x4
    80002894:	a92080e7          	jalr	-1390(ra) # 80006322 <release>
}
    80002898:	854a                	mv	a0,s2
    8000289a:	70a2                	ld	ra,40(sp)
    8000289c:	7402                	ld	s0,32(sp)
    8000289e:	64e2                	ld	s1,24(sp)
    800028a0:	6942                	ld	s2,16(sp)
    800028a2:	69a2                	ld	s3,8(sp)
    800028a4:	6a02                	ld	s4,0(sp)
    800028a6:	6145                	addi	sp,sp,48
    800028a8:	8082                	ret
    panic("iget: no inodes");
    800028aa:	00006517          	auipc	a0,0x6
    800028ae:	c1650513          	addi	a0,a0,-1002 # 800084c0 <etext+0x4c0>
    800028b2:	00003097          	auipc	ra,0x3
    800028b6:	440080e7          	jalr	1088(ra) # 80005cf2 <panic>

00000000800028ba <fsinit>:
fsinit(int dev) {
    800028ba:	7179                	addi	sp,sp,-48
    800028bc:	f406                	sd	ra,40(sp)
    800028be:	f022                	sd	s0,32(sp)
    800028c0:	ec26                	sd	s1,24(sp)
    800028c2:	e84a                	sd	s2,16(sp)
    800028c4:	e44e                	sd	s3,8(sp)
    800028c6:	1800                	addi	s0,sp,48
    800028c8:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800028ca:	4585                	li	a1,1
    800028cc:	00000097          	auipc	ra,0x0
    800028d0:	a86080e7          	jalr	-1402(ra) # 80002352 <bread>
    800028d4:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800028d6:	00018997          	auipc	s3,0x18
    800028da:	e8298993          	addi	s3,s3,-382 # 8001a758 <sb>
    800028de:	02000613          	li	a2,32
    800028e2:	05850593          	addi	a1,a0,88
    800028e6:	854e                	mv	a0,s3
    800028e8:	ffffe097          	auipc	ra,0xffffe
    800028ec:	8f6080e7          	jalr	-1802(ra) # 800001de <memmove>
  brelse(bp);
    800028f0:	8526                	mv	a0,s1
    800028f2:	00000097          	auipc	ra,0x0
    800028f6:	b90080e7          	jalr	-1136(ra) # 80002482 <brelse>
  if(sb.magic != FSMAGIC)
    800028fa:	0009a703          	lw	a4,0(s3)
    800028fe:	102037b7          	lui	a5,0x10203
    80002902:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002906:	02f71263          	bne	a4,a5,8000292a <fsinit+0x70>
  initlog(dev, &sb);
    8000290a:	00018597          	auipc	a1,0x18
    8000290e:	e4e58593          	addi	a1,a1,-434 # 8001a758 <sb>
    80002912:	854a                	mv	a0,s2
    80002914:	00001097          	auipc	ra,0x1
    80002918:	b74080e7          	jalr	-1164(ra) # 80003488 <initlog>
}
    8000291c:	70a2                	ld	ra,40(sp)
    8000291e:	7402                	ld	s0,32(sp)
    80002920:	64e2                	ld	s1,24(sp)
    80002922:	6942                	ld	s2,16(sp)
    80002924:	69a2                	ld	s3,8(sp)
    80002926:	6145                	addi	sp,sp,48
    80002928:	8082                	ret
    panic("invalid file system");
    8000292a:	00006517          	auipc	a0,0x6
    8000292e:	ba650513          	addi	a0,a0,-1114 # 800084d0 <etext+0x4d0>
    80002932:	00003097          	auipc	ra,0x3
    80002936:	3c0080e7          	jalr	960(ra) # 80005cf2 <panic>

000000008000293a <iinit>:
{
    8000293a:	7179                	addi	sp,sp,-48
    8000293c:	f406                	sd	ra,40(sp)
    8000293e:	f022                	sd	s0,32(sp)
    80002940:	ec26                	sd	s1,24(sp)
    80002942:	e84a                	sd	s2,16(sp)
    80002944:	e44e                	sd	s3,8(sp)
    80002946:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002948:	00006597          	auipc	a1,0x6
    8000294c:	ba058593          	addi	a1,a1,-1120 # 800084e8 <etext+0x4e8>
    80002950:	00018517          	auipc	a0,0x18
    80002954:	e2850513          	addi	a0,a0,-472 # 8001a778 <itable>
    80002958:	00004097          	auipc	ra,0x4
    8000295c:	886080e7          	jalr	-1914(ra) # 800061de <initlock>
  for(i = 0; i < NINODE; i++) {
    80002960:	00018497          	auipc	s1,0x18
    80002964:	e4048493          	addi	s1,s1,-448 # 8001a7a0 <itable+0x28>
    80002968:	0001a997          	auipc	s3,0x1a
    8000296c:	8c898993          	addi	s3,s3,-1848 # 8001c230 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002970:	00006917          	auipc	s2,0x6
    80002974:	b8090913          	addi	s2,s2,-1152 # 800084f0 <etext+0x4f0>
    80002978:	85ca                	mv	a1,s2
    8000297a:	8526                	mv	a0,s1
    8000297c:	00001097          	auipc	ra,0x1
    80002980:	e66080e7          	jalr	-410(ra) # 800037e2 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002984:	08848493          	addi	s1,s1,136
    80002988:	ff3498e3          	bne	s1,s3,80002978 <iinit+0x3e>
}
    8000298c:	70a2                	ld	ra,40(sp)
    8000298e:	7402                	ld	s0,32(sp)
    80002990:	64e2                	ld	s1,24(sp)
    80002992:	6942                	ld	s2,16(sp)
    80002994:	69a2                	ld	s3,8(sp)
    80002996:	6145                	addi	sp,sp,48
    80002998:	8082                	ret

000000008000299a <ialloc>:
{
    8000299a:	7139                	addi	sp,sp,-64
    8000299c:	fc06                	sd	ra,56(sp)
    8000299e:	f822                	sd	s0,48(sp)
    800029a0:	f426                	sd	s1,40(sp)
    800029a2:	f04a                	sd	s2,32(sp)
    800029a4:	ec4e                	sd	s3,24(sp)
    800029a6:	e852                	sd	s4,16(sp)
    800029a8:	e456                	sd	s5,8(sp)
    800029aa:	e05a                	sd	s6,0(sp)
    800029ac:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    800029ae:	00018717          	auipc	a4,0x18
    800029b2:	db672703          	lw	a4,-586(a4) # 8001a764 <sb+0xc>
    800029b6:	4785                	li	a5,1
    800029b8:	04e7f863          	bgeu	a5,a4,80002a08 <ialloc+0x6e>
    800029bc:	8aaa                	mv	s5,a0
    800029be:	8b2e                	mv	s6,a1
    800029c0:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    800029c2:	00018a17          	auipc	s4,0x18
    800029c6:	d96a0a13          	addi	s4,s4,-618 # 8001a758 <sb>
    800029ca:	00495593          	srli	a1,s2,0x4
    800029ce:	018a2783          	lw	a5,24(s4)
    800029d2:	9dbd                	addw	a1,a1,a5
    800029d4:	8556                	mv	a0,s5
    800029d6:	00000097          	auipc	ra,0x0
    800029da:	97c080e7          	jalr	-1668(ra) # 80002352 <bread>
    800029de:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    800029e0:	05850993          	addi	s3,a0,88
    800029e4:	00f97793          	andi	a5,s2,15
    800029e8:	079a                	slli	a5,a5,0x6
    800029ea:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    800029ec:	00099783          	lh	a5,0(s3)
    800029f0:	c785                	beqz	a5,80002a18 <ialloc+0x7e>
    brelse(bp);
    800029f2:	00000097          	auipc	ra,0x0
    800029f6:	a90080e7          	jalr	-1392(ra) # 80002482 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    800029fa:	0905                	addi	s2,s2,1
    800029fc:	00ca2703          	lw	a4,12(s4)
    80002a00:	0009079b          	sext.w	a5,s2
    80002a04:	fce7e3e3          	bltu	a5,a4,800029ca <ialloc+0x30>
  panic("ialloc: no inodes");
    80002a08:	00006517          	auipc	a0,0x6
    80002a0c:	af050513          	addi	a0,a0,-1296 # 800084f8 <etext+0x4f8>
    80002a10:	00003097          	auipc	ra,0x3
    80002a14:	2e2080e7          	jalr	738(ra) # 80005cf2 <panic>
      memset(dip, 0, sizeof(*dip));
    80002a18:	04000613          	li	a2,64
    80002a1c:	4581                	li	a1,0
    80002a1e:	854e                	mv	a0,s3
    80002a20:	ffffd097          	auipc	ra,0xffffd
    80002a24:	75a080e7          	jalr	1882(ra) # 8000017a <memset>
      dip->type = type;
    80002a28:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002a2c:	8526                	mv	a0,s1
    80002a2e:	00001097          	auipc	ra,0x1
    80002a32:	cd0080e7          	jalr	-816(ra) # 800036fe <log_write>
      brelse(bp);
    80002a36:	8526                	mv	a0,s1
    80002a38:	00000097          	auipc	ra,0x0
    80002a3c:	a4a080e7          	jalr	-1462(ra) # 80002482 <brelse>
      return iget(dev, inum);
    80002a40:	0009059b          	sext.w	a1,s2
    80002a44:	8556                	mv	a0,s5
    80002a46:	00000097          	auipc	ra,0x0
    80002a4a:	db8080e7          	jalr	-584(ra) # 800027fe <iget>
}
    80002a4e:	70e2                	ld	ra,56(sp)
    80002a50:	7442                	ld	s0,48(sp)
    80002a52:	74a2                	ld	s1,40(sp)
    80002a54:	7902                	ld	s2,32(sp)
    80002a56:	69e2                	ld	s3,24(sp)
    80002a58:	6a42                	ld	s4,16(sp)
    80002a5a:	6aa2                	ld	s5,8(sp)
    80002a5c:	6b02                	ld	s6,0(sp)
    80002a5e:	6121                	addi	sp,sp,64
    80002a60:	8082                	ret

0000000080002a62 <iupdate>:
{
    80002a62:	1101                	addi	sp,sp,-32
    80002a64:	ec06                	sd	ra,24(sp)
    80002a66:	e822                	sd	s0,16(sp)
    80002a68:	e426                	sd	s1,8(sp)
    80002a6a:	e04a                	sd	s2,0(sp)
    80002a6c:	1000                	addi	s0,sp,32
    80002a6e:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002a70:	415c                	lw	a5,4(a0)
    80002a72:	0047d79b          	srliw	a5,a5,0x4
    80002a76:	00018597          	auipc	a1,0x18
    80002a7a:	cfa5a583          	lw	a1,-774(a1) # 8001a770 <sb+0x18>
    80002a7e:	9dbd                	addw	a1,a1,a5
    80002a80:	4108                	lw	a0,0(a0)
    80002a82:	00000097          	auipc	ra,0x0
    80002a86:	8d0080e7          	jalr	-1840(ra) # 80002352 <bread>
    80002a8a:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002a8c:	05850793          	addi	a5,a0,88
    80002a90:	40d8                	lw	a4,4(s1)
    80002a92:	8b3d                	andi	a4,a4,15
    80002a94:	071a                	slli	a4,a4,0x6
    80002a96:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002a98:	04449703          	lh	a4,68(s1)
    80002a9c:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002aa0:	04649703          	lh	a4,70(s1)
    80002aa4:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002aa8:	04849703          	lh	a4,72(s1)
    80002aac:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002ab0:	04a49703          	lh	a4,74(s1)
    80002ab4:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002ab8:	44f8                	lw	a4,76(s1)
    80002aba:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002abc:	03400613          	li	a2,52
    80002ac0:	05048593          	addi	a1,s1,80
    80002ac4:	00c78513          	addi	a0,a5,12
    80002ac8:	ffffd097          	auipc	ra,0xffffd
    80002acc:	716080e7          	jalr	1814(ra) # 800001de <memmove>
  log_write(bp);
    80002ad0:	854a                	mv	a0,s2
    80002ad2:	00001097          	auipc	ra,0x1
    80002ad6:	c2c080e7          	jalr	-980(ra) # 800036fe <log_write>
  brelse(bp);
    80002ada:	854a                	mv	a0,s2
    80002adc:	00000097          	auipc	ra,0x0
    80002ae0:	9a6080e7          	jalr	-1626(ra) # 80002482 <brelse>
}
    80002ae4:	60e2                	ld	ra,24(sp)
    80002ae6:	6442                	ld	s0,16(sp)
    80002ae8:	64a2                	ld	s1,8(sp)
    80002aea:	6902                	ld	s2,0(sp)
    80002aec:	6105                	addi	sp,sp,32
    80002aee:	8082                	ret

0000000080002af0 <idup>:
{
    80002af0:	1101                	addi	sp,sp,-32
    80002af2:	ec06                	sd	ra,24(sp)
    80002af4:	e822                	sd	s0,16(sp)
    80002af6:	e426                	sd	s1,8(sp)
    80002af8:	1000                	addi	s0,sp,32
    80002afa:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002afc:	00018517          	auipc	a0,0x18
    80002b00:	c7c50513          	addi	a0,a0,-900 # 8001a778 <itable>
    80002b04:	00003097          	auipc	ra,0x3
    80002b08:	76e080e7          	jalr	1902(ra) # 80006272 <acquire>
  ip->ref++;
    80002b0c:	449c                	lw	a5,8(s1)
    80002b0e:	2785                	addiw	a5,a5,1
    80002b10:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002b12:	00018517          	auipc	a0,0x18
    80002b16:	c6650513          	addi	a0,a0,-922 # 8001a778 <itable>
    80002b1a:	00004097          	auipc	ra,0x4
    80002b1e:	808080e7          	jalr	-2040(ra) # 80006322 <release>
}
    80002b22:	8526                	mv	a0,s1
    80002b24:	60e2                	ld	ra,24(sp)
    80002b26:	6442                	ld	s0,16(sp)
    80002b28:	64a2                	ld	s1,8(sp)
    80002b2a:	6105                	addi	sp,sp,32
    80002b2c:	8082                	ret

0000000080002b2e <ilock>:
{
    80002b2e:	1101                	addi	sp,sp,-32
    80002b30:	ec06                	sd	ra,24(sp)
    80002b32:	e822                	sd	s0,16(sp)
    80002b34:	e426                	sd	s1,8(sp)
    80002b36:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002b38:	c10d                	beqz	a0,80002b5a <ilock+0x2c>
    80002b3a:	84aa                	mv	s1,a0
    80002b3c:	451c                	lw	a5,8(a0)
    80002b3e:	00f05e63          	blez	a5,80002b5a <ilock+0x2c>
  acquiresleep(&ip->lock);
    80002b42:	0541                	addi	a0,a0,16
    80002b44:	00001097          	auipc	ra,0x1
    80002b48:	cd8080e7          	jalr	-808(ra) # 8000381c <acquiresleep>
  if(ip->valid == 0){
    80002b4c:	40bc                	lw	a5,64(s1)
    80002b4e:	cf99                	beqz	a5,80002b6c <ilock+0x3e>
}
    80002b50:	60e2                	ld	ra,24(sp)
    80002b52:	6442                	ld	s0,16(sp)
    80002b54:	64a2                	ld	s1,8(sp)
    80002b56:	6105                	addi	sp,sp,32
    80002b58:	8082                	ret
    80002b5a:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80002b5c:	00006517          	auipc	a0,0x6
    80002b60:	9b450513          	addi	a0,a0,-1612 # 80008510 <etext+0x510>
    80002b64:	00003097          	auipc	ra,0x3
    80002b68:	18e080e7          	jalr	398(ra) # 80005cf2 <panic>
    80002b6c:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b6e:	40dc                	lw	a5,4(s1)
    80002b70:	0047d79b          	srliw	a5,a5,0x4
    80002b74:	00018597          	auipc	a1,0x18
    80002b78:	bfc5a583          	lw	a1,-1028(a1) # 8001a770 <sb+0x18>
    80002b7c:	9dbd                	addw	a1,a1,a5
    80002b7e:	4088                	lw	a0,0(s1)
    80002b80:	fffff097          	auipc	ra,0xfffff
    80002b84:	7d2080e7          	jalr	2002(ra) # 80002352 <bread>
    80002b88:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b8a:	05850593          	addi	a1,a0,88
    80002b8e:	40dc                	lw	a5,4(s1)
    80002b90:	8bbd                	andi	a5,a5,15
    80002b92:	079a                	slli	a5,a5,0x6
    80002b94:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002b96:	00059783          	lh	a5,0(a1)
    80002b9a:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002b9e:	00259783          	lh	a5,2(a1)
    80002ba2:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002ba6:	00459783          	lh	a5,4(a1)
    80002baa:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002bae:	00659783          	lh	a5,6(a1)
    80002bb2:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002bb6:	459c                	lw	a5,8(a1)
    80002bb8:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002bba:	03400613          	li	a2,52
    80002bbe:	05b1                	addi	a1,a1,12
    80002bc0:	05048513          	addi	a0,s1,80
    80002bc4:	ffffd097          	auipc	ra,0xffffd
    80002bc8:	61a080e7          	jalr	1562(ra) # 800001de <memmove>
    brelse(bp);
    80002bcc:	854a                	mv	a0,s2
    80002bce:	00000097          	auipc	ra,0x0
    80002bd2:	8b4080e7          	jalr	-1868(ra) # 80002482 <brelse>
    ip->valid = 1;
    80002bd6:	4785                	li	a5,1
    80002bd8:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002bda:	04449783          	lh	a5,68(s1)
    80002bde:	c399                	beqz	a5,80002be4 <ilock+0xb6>
    80002be0:	6902                	ld	s2,0(sp)
    80002be2:	b7bd                	j	80002b50 <ilock+0x22>
      panic("ilock: no type");
    80002be4:	00006517          	auipc	a0,0x6
    80002be8:	93450513          	addi	a0,a0,-1740 # 80008518 <etext+0x518>
    80002bec:	00003097          	auipc	ra,0x3
    80002bf0:	106080e7          	jalr	262(ra) # 80005cf2 <panic>

0000000080002bf4 <iunlock>:
{
    80002bf4:	1101                	addi	sp,sp,-32
    80002bf6:	ec06                	sd	ra,24(sp)
    80002bf8:	e822                	sd	s0,16(sp)
    80002bfa:	e426                	sd	s1,8(sp)
    80002bfc:	e04a                	sd	s2,0(sp)
    80002bfe:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002c00:	c905                	beqz	a0,80002c30 <iunlock+0x3c>
    80002c02:	84aa                	mv	s1,a0
    80002c04:	01050913          	addi	s2,a0,16
    80002c08:	854a                	mv	a0,s2
    80002c0a:	00001097          	auipc	ra,0x1
    80002c0e:	cac080e7          	jalr	-852(ra) # 800038b6 <holdingsleep>
    80002c12:	cd19                	beqz	a0,80002c30 <iunlock+0x3c>
    80002c14:	449c                	lw	a5,8(s1)
    80002c16:	00f05d63          	blez	a5,80002c30 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002c1a:	854a                	mv	a0,s2
    80002c1c:	00001097          	auipc	ra,0x1
    80002c20:	c56080e7          	jalr	-938(ra) # 80003872 <releasesleep>
}
    80002c24:	60e2                	ld	ra,24(sp)
    80002c26:	6442                	ld	s0,16(sp)
    80002c28:	64a2                	ld	s1,8(sp)
    80002c2a:	6902                	ld	s2,0(sp)
    80002c2c:	6105                	addi	sp,sp,32
    80002c2e:	8082                	ret
    panic("iunlock");
    80002c30:	00006517          	auipc	a0,0x6
    80002c34:	8f850513          	addi	a0,a0,-1800 # 80008528 <etext+0x528>
    80002c38:	00003097          	auipc	ra,0x3
    80002c3c:	0ba080e7          	jalr	186(ra) # 80005cf2 <panic>

0000000080002c40 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002c40:	7179                	addi	sp,sp,-48
    80002c42:	f406                	sd	ra,40(sp)
    80002c44:	f022                	sd	s0,32(sp)
    80002c46:	ec26                	sd	s1,24(sp)
    80002c48:	e84a                	sd	s2,16(sp)
    80002c4a:	e44e                	sd	s3,8(sp)
    80002c4c:	1800                	addi	s0,sp,48
    80002c4e:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002c50:	05050493          	addi	s1,a0,80
    80002c54:	08050913          	addi	s2,a0,128
    80002c58:	a021                	j	80002c60 <itrunc+0x20>
    80002c5a:	0491                	addi	s1,s1,4
    80002c5c:	01248d63          	beq	s1,s2,80002c76 <itrunc+0x36>
    if(ip->addrs[i]){
    80002c60:	408c                	lw	a1,0(s1)
    80002c62:	dde5                	beqz	a1,80002c5a <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002c64:	0009a503          	lw	a0,0(s3)
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	92a080e7          	jalr	-1750(ra) # 80002592 <bfree>
      ip->addrs[i] = 0;
    80002c70:	0004a023          	sw	zero,0(s1)
    80002c74:	b7dd                	j	80002c5a <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002c76:	0809a583          	lw	a1,128(s3)
    80002c7a:	ed99                	bnez	a1,80002c98 <itrunc+0x58>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002c7c:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002c80:	854e                	mv	a0,s3
    80002c82:	00000097          	auipc	ra,0x0
    80002c86:	de0080e7          	jalr	-544(ra) # 80002a62 <iupdate>
}
    80002c8a:	70a2                	ld	ra,40(sp)
    80002c8c:	7402                	ld	s0,32(sp)
    80002c8e:	64e2                	ld	s1,24(sp)
    80002c90:	6942                	ld	s2,16(sp)
    80002c92:	69a2                	ld	s3,8(sp)
    80002c94:	6145                	addi	sp,sp,48
    80002c96:	8082                	ret
    80002c98:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002c9a:	0009a503          	lw	a0,0(s3)
    80002c9e:	fffff097          	auipc	ra,0xfffff
    80002ca2:	6b4080e7          	jalr	1716(ra) # 80002352 <bread>
    80002ca6:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002ca8:	05850493          	addi	s1,a0,88
    80002cac:	45850913          	addi	s2,a0,1112
    80002cb0:	a021                	j	80002cb8 <itrunc+0x78>
    80002cb2:	0491                	addi	s1,s1,4
    80002cb4:	01248b63          	beq	s1,s2,80002cca <itrunc+0x8a>
      if(a[j])
    80002cb8:	408c                	lw	a1,0(s1)
    80002cba:	dde5                	beqz	a1,80002cb2 <itrunc+0x72>
        bfree(ip->dev, a[j]);
    80002cbc:	0009a503          	lw	a0,0(s3)
    80002cc0:	00000097          	auipc	ra,0x0
    80002cc4:	8d2080e7          	jalr	-1838(ra) # 80002592 <bfree>
    80002cc8:	b7ed                	j	80002cb2 <itrunc+0x72>
    brelse(bp);
    80002cca:	8552                	mv	a0,s4
    80002ccc:	fffff097          	auipc	ra,0xfffff
    80002cd0:	7b6080e7          	jalr	1974(ra) # 80002482 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002cd4:	0809a583          	lw	a1,128(s3)
    80002cd8:	0009a503          	lw	a0,0(s3)
    80002cdc:	00000097          	auipc	ra,0x0
    80002ce0:	8b6080e7          	jalr	-1866(ra) # 80002592 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002ce4:	0809a023          	sw	zero,128(s3)
    80002ce8:	6a02                	ld	s4,0(sp)
    80002cea:	bf49                	j	80002c7c <itrunc+0x3c>

0000000080002cec <iput>:
{
    80002cec:	1101                	addi	sp,sp,-32
    80002cee:	ec06                	sd	ra,24(sp)
    80002cf0:	e822                	sd	s0,16(sp)
    80002cf2:	e426                	sd	s1,8(sp)
    80002cf4:	1000                	addi	s0,sp,32
    80002cf6:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002cf8:	00018517          	auipc	a0,0x18
    80002cfc:	a8050513          	addi	a0,a0,-1408 # 8001a778 <itable>
    80002d00:	00003097          	auipc	ra,0x3
    80002d04:	572080e7          	jalr	1394(ra) # 80006272 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002d08:	4498                	lw	a4,8(s1)
    80002d0a:	4785                	li	a5,1
    80002d0c:	02f70263          	beq	a4,a5,80002d30 <iput+0x44>
  ip->ref--;
    80002d10:	449c                	lw	a5,8(s1)
    80002d12:	37fd                	addiw	a5,a5,-1
    80002d14:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002d16:	00018517          	auipc	a0,0x18
    80002d1a:	a6250513          	addi	a0,a0,-1438 # 8001a778 <itable>
    80002d1e:	00003097          	auipc	ra,0x3
    80002d22:	604080e7          	jalr	1540(ra) # 80006322 <release>
}
    80002d26:	60e2                	ld	ra,24(sp)
    80002d28:	6442                	ld	s0,16(sp)
    80002d2a:	64a2                	ld	s1,8(sp)
    80002d2c:	6105                	addi	sp,sp,32
    80002d2e:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002d30:	40bc                	lw	a5,64(s1)
    80002d32:	dff9                	beqz	a5,80002d10 <iput+0x24>
    80002d34:	04a49783          	lh	a5,74(s1)
    80002d38:	ffe1                	bnez	a5,80002d10 <iput+0x24>
    80002d3a:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002d3c:	01048913          	addi	s2,s1,16
    80002d40:	854a                	mv	a0,s2
    80002d42:	00001097          	auipc	ra,0x1
    80002d46:	ada080e7          	jalr	-1318(ra) # 8000381c <acquiresleep>
    release(&itable.lock);
    80002d4a:	00018517          	auipc	a0,0x18
    80002d4e:	a2e50513          	addi	a0,a0,-1490 # 8001a778 <itable>
    80002d52:	00003097          	auipc	ra,0x3
    80002d56:	5d0080e7          	jalr	1488(ra) # 80006322 <release>
    itrunc(ip);
    80002d5a:	8526                	mv	a0,s1
    80002d5c:	00000097          	auipc	ra,0x0
    80002d60:	ee4080e7          	jalr	-284(ra) # 80002c40 <itrunc>
    ip->type = 0;
    80002d64:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002d68:	8526                	mv	a0,s1
    80002d6a:	00000097          	auipc	ra,0x0
    80002d6e:	cf8080e7          	jalr	-776(ra) # 80002a62 <iupdate>
    ip->valid = 0;
    80002d72:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002d76:	854a                	mv	a0,s2
    80002d78:	00001097          	auipc	ra,0x1
    80002d7c:	afa080e7          	jalr	-1286(ra) # 80003872 <releasesleep>
    acquire(&itable.lock);
    80002d80:	00018517          	auipc	a0,0x18
    80002d84:	9f850513          	addi	a0,a0,-1544 # 8001a778 <itable>
    80002d88:	00003097          	auipc	ra,0x3
    80002d8c:	4ea080e7          	jalr	1258(ra) # 80006272 <acquire>
    80002d90:	6902                	ld	s2,0(sp)
    80002d92:	bfbd                	j	80002d10 <iput+0x24>

0000000080002d94 <iunlockput>:
{
    80002d94:	1101                	addi	sp,sp,-32
    80002d96:	ec06                	sd	ra,24(sp)
    80002d98:	e822                	sd	s0,16(sp)
    80002d9a:	e426                	sd	s1,8(sp)
    80002d9c:	1000                	addi	s0,sp,32
    80002d9e:	84aa                	mv	s1,a0
  iunlock(ip);
    80002da0:	00000097          	auipc	ra,0x0
    80002da4:	e54080e7          	jalr	-428(ra) # 80002bf4 <iunlock>
  iput(ip);
    80002da8:	8526                	mv	a0,s1
    80002daa:	00000097          	auipc	ra,0x0
    80002dae:	f42080e7          	jalr	-190(ra) # 80002cec <iput>
}
    80002db2:	60e2                	ld	ra,24(sp)
    80002db4:	6442                	ld	s0,16(sp)
    80002db6:	64a2                	ld	s1,8(sp)
    80002db8:	6105                	addi	sp,sp,32
    80002dba:	8082                	ret

0000000080002dbc <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002dbc:	1141                	addi	sp,sp,-16
    80002dbe:	e406                	sd	ra,8(sp)
    80002dc0:	e022                	sd	s0,0(sp)
    80002dc2:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002dc4:	411c                	lw	a5,0(a0)
    80002dc6:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002dc8:	415c                	lw	a5,4(a0)
    80002dca:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002dcc:	04451783          	lh	a5,68(a0)
    80002dd0:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002dd4:	04a51783          	lh	a5,74(a0)
    80002dd8:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002ddc:	04c56783          	lwu	a5,76(a0)
    80002de0:	e99c                	sd	a5,16(a1)
}
    80002de2:	60a2                	ld	ra,8(sp)
    80002de4:	6402                	ld	s0,0(sp)
    80002de6:	0141                	addi	sp,sp,16
    80002de8:	8082                	ret

0000000080002dea <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002dea:	457c                	lw	a5,76(a0)
    80002dec:	0ed7ea63          	bltu	a5,a3,80002ee0 <readi+0xf6>
{
    80002df0:	7159                	addi	sp,sp,-112
    80002df2:	f486                	sd	ra,104(sp)
    80002df4:	f0a2                	sd	s0,96(sp)
    80002df6:	eca6                	sd	s1,88(sp)
    80002df8:	fc56                	sd	s5,56(sp)
    80002dfa:	f85a                	sd	s6,48(sp)
    80002dfc:	f45e                	sd	s7,40(sp)
    80002dfe:	ec66                	sd	s9,24(sp)
    80002e00:	1880                	addi	s0,sp,112
    80002e02:	8baa                	mv	s7,a0
    80002e04:	8cae                	mv	s9,a1
    80002e06:	8ab2                	mv	s5,a2
    80002e08:	84b6                	mv	s1,a3
    80002e0a:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002e0c:	9f35                	addw	a4,a4,a3
    return 0;
    80002e0e:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002e10:	0ad76763          	bltu	a4,a3,80002ebe <readi+0xd4>
    80002e14:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002e16:	00e7f463          	bgeu	a5,a4,80002e1e <readi+0x34>
    n = ip->size - off;
    80002e1a:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e1e:	0a0b0f63          	beqz	s6,80002edc <readi+0xf2>
    80002e22:	e8ca                	sd	s2,80(sp)
    80002e24:	e0d2                	sd	s4,64(sp)
    80002e26:	f062                	sd	s8,32(sp)
    80002e28:	e86a                	sd	s10,16(sp)
    80002e2a:	e46e                	sd	s11,8(sp)
    80002e2c:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e2e:	40000d93          	li	s11,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002e32:	5d7d                	li	s10,-1
    80002e34:	a82d                	j	80002e6e <readi+0x84>
    80002e36:	020a1c13          	slli	s8,s4,0x20
    80002e3a:	020c5c13          	srli	s8,s8,0x20
    80002e3e:	05890613          	addi	a2,s2,88
    80002e42:	86e2                	mv	a3,s8
    80002e44:	963e                	add	a2,a2,a5
    80002e46:	85d6                	mv	a1,s5
    80002e48:	8566                	mv	a0,s9
    80002e4a:	fffff097          	auipc	ra,0xfffff
    80002e4e:	ac8080e7          	jalr	-1336(ra) # 80001912 <either_copyout>
    80002e52:	05a50963          	beq	a0,s10,80002ea4 <readi+0xba>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002e56:	854a                	mv	a0,s2
    80002e58:	fffff097          	auipc	ra,0xfffff
    80002e5c:	62a080e7          	jalr	1578(ra) # 80002482 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e60:	013a09bb          	addw	s3,s4,s3
    80002e64:	009a04bb          	addw	s1,s4,s1
    80002e68:	9ae2                	add	s5,s5,s8
    80002e6a:	0769f363          	bgeu	s3,s6,80002ed0 <readi+0xe6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002e6e:	000ba903          	lw	s2,0(s7)
    80002e72:	00a4d59b          	srliw	a1,s1,0xa
    80002e76:	855e                	mv	a0,s7
    80002e78:	00000097          	auipc	ra,0x0
    80002e7c:	8b8080e7          	jalr	-1864(ra) # 80002730 <bmap>
    80002e80:	85aa                	mv	a1,a0
    80002e82:	854a                	mv	a0,s2
    80002e84:	fffff097          	auipc	ra,0xfffff
    80002e88:	4ce080e7          	jalr	1230(ra) # 80002352 <bread>
    80002e8c:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e8e:	3ff4f793          	andi	a5,s1,1023
    80002e92:	40fd873b          	subw	a4,s11,a5
    80002e96:	413b06bb          	subw	a3,s6,s3
    80002e9a:	8a3a                	mv	s4,a4
    80002e9c:	f8e6fde3          	bgeu	a3,a4,80002e36 <readi+0x4c>
    80002ea0:	8a36                	mv	s4,a3
    80002ea2:	bf51                	j	80002e36 <readi+0x4c>
      brelse(bp);
    80002ea4:	854a                	mv	a0,s2
    80002ea6:	fffff097          	auipc	ra,0xfffff
    80002eaa:	5dc080e7          	jalr	1500(ra) # 80002482 <brelse>
      tot = -1;
    80002eae:	59fd                	li	s3,-1
      break;
    80002eb0:	6946                	ld	s2,80(sp)
    80002eb2:	6a06                	ld	s4,64(sp)
    80002eb4:	7c02                	ld	s8,32(sp)
    80002eb6:	6d42                	ld	s10,16(sp)
    80002eb8:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002eba:	854e                	mv	a0,s3
    80002ebc:	69a6                	ld	s3,72(sp)
}
    80002ebe:	70a6                	ld	ra,104(sp)
    80002ec0:	7406                	ld	s0,96(sp)
    80002ec2:	64e6                	ld	s1,88(sp)
    80002ec4:	7ae2                	ld	s5,56(sp)
    80002ec6:	7b42                	ld	s6,48(sp)
    80002ec8:	7ba2                	ld	s7,40(sp)
    80002eca:	6ce2                	ld	s9,24(sp)
    80002ecc:	6165                	addi	sp,sp,112
    80002ece:	8082                	ret
    80002ed0:	6946                	ld	s2,80(sp)
    80002ed2:	6a06                	ld	s4,64(sp)
    80002ed4:	7c02                	ld	s8,32(sp)
    80002ed6:	6d42                	ld	s10,16(sp)
    80002ed8:	6da2                	ld	s11,8(sp)
    80002eda:	b7c5                	j	80002eba <readi+0xd0>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002edc:	89da                	mv	s3,s6
    80002ede:	bff1                	j	80002eba <readi+0xd0>
    return 0;
    80002ee0:	4501                	li	a0,0
}
    80002ee2:	8082                	ret

0000000080002ee4 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002ee4:	457c                	lw	a5,76(a0)
    80002ee6:	10d7e963          	bltu	a5,a3,80002ff8 <writei+0x114>
{
    80002eea:	7159                	addi	sp,sp,-112
    80002eec:	f486                	sd	ra,104(sp)
    80002eee:	f0a2                	sd	s0,96(sp)
    80002ef0:	e8ca                	sd	s2,80(sp)
    80002ef2:	fc56                	sd	s5,56(sp)
    80002ef4:	f45e                	sd	s7,40(sp)
    80002ef6:	f062                	sd	s8,32(sp)
    80002ef8:	ec66                	sd	s9,24(sp)
    80002efa:	1880                	addi	s0,sp,112
    80002efc:	8baa                	mv	s7,a0
    80002efe:	8cae                	mv	s9,a1
    80002f00:	8ab2                	mv	s5,a2
    80002f02:	8936                	mv	s2,a3
    80002f04:	8c3a                	mv	s8,a4
  if(off > ip->size || off + n < off)
    80002f06:	00e687bb          	addw	a5,a3,a4
    80002f0a:	0ed7e963          	bltu	a5,a3,80002ffc <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002f0e:	00043737          	lui	a4,0x43
    80002f12:	0ef76763          	bltu	a4,a5,80003000 <writei+0x11c>
    80002f16:	e0d2                	sd	s4,64(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f18:	0c0c0863          	beqz	s8,80002fe8 <writei+0x104>
    80002f1c:	eca6                	sd	s1,88(sp)
    80002f1e:	e4ce                	sd	s3,72(sp)
    80002f20:	f85a                	sd	s6,48(sp)
    80002f22:	e86a                	sd	s10,16(sp)
    80002f24:	e46e                	sd	s11,8(sp)
    80002f26:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f28:	40000d93          	li	s11,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002f2c:	5d7d                	li	s10,-1
    80002f2e:	a091                	j	80002f72 <writei+0x8e>
    80002f30:	02099b13          	slli	s6,s3,0x20
    80002f34:	020b5b13          	srli	s6,s6,0x20
    80002f38:	05848513          	addi	a0,s1,88
    80002f3c:	86da                	mv	a3,s6
    80002f3e:	8656                	mv	a2,s5
    80002f40:	85e6                	mv	a1,s9
    80002f42:	953e                	add	a0,a0,a5
    80002f44:	fffff097          	auipc	ra,0xfffff
    80002f48:	a24080e7          	jalr	-1500(ra) # 80001968 <either_copyin>
    80002f4c:	05a50e63          	beq	a0,s10,80002fa8 <writei+0xc4>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002f50:	8526                	mv	a0,s1
    80002f52:	00000097          	auipc	ra,0x0
    80002f56:	7ac080e7          	jalr	1964(ra) # 800036fe <log_write>
    brelse(bp);
    80002f5a:	8526                	mv	a0,s1
    80002f5c:	fffff097          	auipc	ra,0xfffff
    80002f60:	526080e7          	jalr	1318(ra) # 80002482 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f64:	01498a3b          	addw	s4,s3,s4
    80002f68:	0129893b          	addw	s2,s3,s2
    80002f6c:	9ada                	add	s5,s5,s6
    80002f6e:	058a7263          	bgeu	s4,s8,80002fb2 <writei+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002f72:	000ba483          	lw	s1,0(s7)
    80002f76:	00a9559b          	srliw	a1,s2,0xa
    80002f7a:	855e                	mv	a0,s7
    80002f7c:	fffff097          	auipc	ra,0xfffff
    80002f80:	7b4080e7          	jalr	1972(ra) # 80002730 <bmap>
    80002f84:	85aa                	mv	a1,a0
    80002f86:	8526                	mv	a0,s1
    80002f88:	fffff097          	auipc	ra,0xfffff
    80002f8c:	3ca080e7          	jalr	970(ra) # 80002352 <bread>
    80002f90:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f92:	3ff97793          	andi	a5,s2,1023
    80002f96:	40fd873b          	subw	a4,s11,a5
    80002f9a:	414c06bb          	subw	a3,s8,s4
    80002f9e:	89ba                	mv	s3,a4
    80002fa0:	f8e6f8e3          	bgeu	a3,a4,80002f30 <writei+0x4c>
    80002fa4:	89b6                	mv	s3,a3
    80002fa6:	b769                	j	80002f30 <writei+0x4c>
      brelse(bp);
    80002fa8:	8526                	mv	a0,s1
    80002faa:	fffff097          	auipc	ra,0xfffff
    80002fae:	4d8080e7          	jalr	1240(ra) # 80002482 <brelse>
  }

  if(off > ip->size)
    80002fb2:	04cba783          	lw	a5,76(s7)
    80002fb6:	0327fb63          	bgeu	a5,s2,80002fec <writei+0x108>
    ip->size = off;
    80002fba:	052ba623          	sw	s2,76(s7)
    80002fbe:	64e6                	ld	s1,88(sp)
    80002fc0:	69a6                	ld	s3,72(sp)
    80002fc2:	7b42                	ld	s6,48(sp)
    80002fc4:	6d42                	ld	s10,16(sp)
    80002fc6:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002fc8:	855e                	mv	a0,s7
    80002fca:	00000097          	auipc	ra,0x0
    80002fce:	a98080e7          	jalr	-1384(ra) # 80002a62 <iupdate>

  return tot;
    80002fd2:	8552                	mv	a0,s4
    80002fd4:	6a06                	ld	s4,64(sp)
}
    80002fd6:	70a6                	ld	ra,104(sp)
    80002fd8:	7406                	ld	s0,96(sp)
    80002fda:	6946                	ld	s2,80(sp)
    80002fdc:	7ae2                	ld	s5,56(sp)
    80002fde:	7ba2                	ld	s7,40(sp)
    80002fe0:	7c02                	ld	s8,32(sp)
    80002fe2:	6ce2                	ld	s9,24(sp)
    80002fe4:	6165                	addi	sp,sp,112
    80002fe6:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002fe8:	8a62                	mv	s4,s8
    80002fea:	bff9                	j	80002fc8 <writei+0xe4>
    80002fec:	64e6                	ld	s1,88(sp)
    80002fee:	69a6                	ld	s3,72(sp)
    80002ff0:	7b42                	ld	s6,48(sp)
    80002ff2:	6d42                	ld	s10,16(sp)
    80002ff4:	6da2                	ld	s11,8(sp)
    80002ff6:	bfc9                	j	80002fc8 <writei+0xe4>
    return -1;
    80002ff8:	557d                	li	a0,-1
}
    80002ffa:	8082                	ret
    return -1;
    80002ffc:	557d                	li	a0,-1
    80002ffe:	bfe1                	j	80002fd6 <writei+0xf2>
    return -1;
    80003000:	557d                	li	a0,-1
    80003002:	bfd1                	j	80002fd6 <writei+0xf2>

0000000080003004 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003004:	1141                	addi	sp,sp,-16
    80003006:	e406                	sd	ra,8(sp)
    80003008:	e022                	sd	s0,0(sp)
    8000300a:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000300c:	4639                	li	a2,14
    8000300e:	ffffd097          	auipc	ra,0xffffd
    80003012:	248080e7          	jalr	584(ra) # 80000256 <strncmp>
}
    80003016:	60a2                	ld	ra,8(sp)
    80003018:	6402                	ld	s0,0(sp)
    8000301a:	0141                	addi	sp,sp,16
    8000301c:	8082                	ret

000000008000301e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000301e:	711d                	addi	sp,sp,-96
    80003020:	ec86                	sd	ra,88(sp)
    80003022:	e8a2                	sd	s0,80(sp)
    80003024:	e4a6                	sd	s1,72(sp)
    80003026:	e0ca                	sd	s2,64(sp)
    80003028:	fc4e                	sd	s3,56(sp)
    8000302a:	f852                	sd	s4,48(sp)
    8000302c:	f456                	sd	s5,40(sp)
    8000302e:	f05a                	sd	s6,32(sp)
    80003030:	ec5e                	sd	s7,24(sp)
    80003032:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003034:	04451703          	lh	a4,68(a0)
    80003038:	4785                	li	a5,1
    8000303a:	00f71f63          	bne	a4,a5,80003058 <dirlookup+0x3a>
    8000303e:	892a                	mv	s2,a0
    80003040:	8aae                	mv	s5,a1
    80003042:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003044:	457c                	lw	a5,76(a0)
    80003046:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003048:	fa040a13          	addi	s4,s0,-96
    8000304c:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    8000304e:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003052:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003054:	e79d                	bnez	a5,80003082 <dirlookup+0x64>
    80003056:	a88d                	j	800030c8 <dirlookup+0xaa>
    panic("dirlookup not DIR");
    80003058:	00005517          	auipc	a0,0x5
    8000305c:	4d850513          	addi	a0,a0,1240 # 80008530 <etext+0x530>
    80003060:	00003097          	auipc	ra,0x3
    80003064:	c92080e7          	jalr	-878(ra) # 80005cf2 <panic>
      panic("dirlookup read");
    80003068:	00005517          	auipc	a0,0x5
    8000306c:	4e050513          	addi	a0,a0,1248 # 80008548 <etext+0x548>
    80003070:	00003097          	auipc	ra,0x3
    80003074:	c82080e7          	jalr	-894(ra) # 80005cf2 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003078:	24c1                	addiw	s1,s1,16
    8000307a:	04c92783          	lw	a5,76(s2)
    8000307e:	04f4f463          	bgeu	s1,a5,800030c6 <dirlookup+0xa8>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003082:	874e                	mv	a4,s3
    80003084:	86a6                	mv	a3,s1
    80003086:	8652                	mv	a2,s4
    80003088:	4581                	li	a1,0
    8000308a:	854a                	mv	a0,s2
    8000308c:	00000097          	auipc	ra,0x0
    80003090:	d5e080e7          	jalr	-674(ra) # 80002dea <readi>
    80003094:	fd351ae3          	bne	a0,s3,80003068 <dirlookup+0x4a>
    if(de.inum == 0)
    80003098:	fa045783          	lhu	a5,-96(s0)
    8000309c:	dff1                	beqz	a5,80003078 <dirlookup+0x5a>
    if(namecmp(name, de.name) == 0){
    8000309e:	85da                	mv	a1,s6
    800030a0:	8556                	mv	a0,s5
    800030a2:	00000097          	auipc	ra,0x0
    800030a6:	f62080e7          	jalr	-158(ra) # 80003004 <namecmp>
    800030aa:	f579                	bnez	a0,80003078 <dirlookup+0x5a>
      if(poff)
    800030ac:	000b8463          	beqz	s7,800030b4 <dirlookup+0x96>
        *poff = off;
    800030b0:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    800030b4:	fa045583          	lhu	a1,-96(s0)
    800030b8:	00092503          	lw	a0,0(s2)
    800030bc:	fffff097          	auipc	ra,0xfffff
    800030c0:	742080e7          	jalr	1858(ra) # 800027fe <iget>
    800030c4:	a011                	j	800030c8 <dirlookup+0xaa>
  return 0;
    800030c6:	4501                	li	a0,0
}
    800030c8:	60e6                	ld	ra,88(sp)
    800030ca:	6446                	ld	s0,80(sp)
    800030cc:	64a6                	ld	s1,72(sp)
    800030ce:	6906                	ld	s2,64(sp)
    800030d0:	79e2                	ld	s3,56(sp)
    800030d2:	7a42                	ld	s4,48(sp)
    800030d4:	7aa2                	ld	s5,40(sp)
    800030d6:	7b02                	ld	s6,32(sp)
    800030d8:	6be2                	ld	s7,24(sp)
    800030da:	6125                	addi	sp,sp,96
    800030dc:	8082                	ret

00000000800030de <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800030de:	711d                	addi	sp,sp,-96
    800030e0:	ec86                	sd	ra,88(sp)
    800030e2:	e8a2                	sd	s0,80(sp)
    800030e4:	e4a6                	sd	s1,72(sp)
    800030e6:	e0ca                	sd	s2,64(sp)
    800030e8:	fc4e                	sd	s3,56(sp)
    800030ea:	f852                	sd	s4,48(sp)
    800030ec:	f456                	sd	s5,40(sp)
    800030ee:	f05a                	sd	s6,32(sp)
    800030f0:	ec5e                	sd	s7,24(sp)
    800030f2:	e862                	sd	s8,16(sp)
    800030f4:	e466                	sd	s9,8(sp)
    800030f6:	e06a                	sd	s10,0(sp)
    800030f8:	1080                	addi	s0,sp,96
    800030fa:	84aa                	mv	s1,a0
    800030fc:	8b2e                	mv	s6,a1
    800030fe:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003100:	00054703          	lbu	a4,0(a0)
    80003104:	02f00793          	li	a5,47
    80003108:	02f70363          	beq	a4,a5,8000312e <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000310c:	ffffe097          	auipc	ra,0xffffe
    80003110:	d96080e7          	jalr	-618(ra) # 80000ea2 <myproc>
    80003114:	15053503          	ld	a0,336(a0)
    80003118:	00000097          	auipc	ra,0x0
    8000311c:	9d8080e7          	jalr	-1576(ra) # 80002af0 <idup>
    80003120:	8a2a                	mv	s4,a0
  while(*path == '/')
    80003122:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80003126:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80003128:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    8000312a:	4b85                	li	s7,1
    8000312c:	a87d                	j	800031ea <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    8000312e:	4585                	li	a1,1
    80003130:	852e                	mv	a0,a1
    80003132:	fffff097          	auipc	ra,0xfffff
    80003136:	6cc080e7          	jalr	1740(ra) # 800027fe <iget>
    8000313a:	8a2a                	mv	s4,a0
    8000313c:	b7dd                	j	80003122 <namex+0x44>
      iunlockput(ip);
    8000313e:	8552                	mv	a0,s4
    80003140:	00000097          	auipc	ra,0x0
    80003144:	c54080e7          	jalr	-940(ra) # 80002d94 <iunlockput>
      return 0;
    80003148:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    8000314a:	8552                	mv	a0,s4
    8000314c:	60e6                	ld	ra,88(sp)
    8000314e:	6446                	ld	s0,80(sp)
    80003150:	64a6                	ld	s1,72(sp)
    80003152:	6906                	ld	s2,64(sp)
    80003154:	79e2                	ld	s3,56(sp)
    80003156:	7a42                	ld	s4,48(sp)
    80003158:	7aa2                	ld	s5,40(sp)
    8000315a:	7b02                	ld	s6,32(sp)
    8000315c:	6be2                	ld	s7,24(sp)
    8000315e:	6c42                	ld	s8,16(sp)
    80003160:	6ca2                	ld	s9,8(sp)
    80003162:	6d02                	ld	s10,0(sp)
    80003164:	6125                	addi	sp,sp,96
    80003166:	8082                	ret
      iunlock(ip);
    80003168:	8552                	mv	a0,s4
    8000316a:	00000097          	auipc	ra,0x0
    8000316e:	a8a080e7          	jalr	-1398(ra) # 80002bf4 <iunlock>
      return ip;
    80003172:	bfe1                	j	8000314a <namex+0x6c>
      iunlockput(ip);
    80003174:	8552                	mv	a0,s4
    80003176:	00000097          	auipc	ra,0x0
    8000317a:	c1e080e7          	jalr	-994(ra) # 80002d94 <iunlockput>
      return 0;
    8000317e:	8a4e                	mv	s4,s3
    80003180:	b7e9                	j	8000314a <namex+0x6c>
  len = path - s;
    80003182:	40998633          	sub	a2,s3,s1
    80003186:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    8000318a:	09ac5863          	bge	s8,s10,8000321a <namex+0x13c>
    memmove(name, s, DIRSIZ);
    8000318e:	8666                	mv	a2,s9
    80003190:	85a6                	mv	a1,s1
    80003192:	8556                	mv	a0,s5
    80003194:	ffffd097          	auipc	ra,0xffffd
    80003198:	04a080e7          	jalr	74(ra) # 800001de <memmove>
    8000319c:	84ce                	mv	s1,s3
  while(*path == '/')
    8000319e:	0004c783          	lbu	a5,0(s1)
    800031a2:	01279763          	bne	a5,s2,800031b0 <namex+0xd2>
    path++;
    800031a6:	0485                	addi	s1,s1,1
  while(*path == '/')
    800031a8:	0004c783          	lbu	a5,0(s1)
    800031ac:	ff278de3          	beq	a5,s2,800031a6 <namex+0xc8>
    ilock(ip);
    800031b0:	8552                	mv	a0,s4
    800031b2:	00000097          	auipc	ra,0x0
    800031b6:	97c080e7          	jalr	-1668(ra) # 80002b2e <ilock>
    if(ip->type != T_DIR){
    800031ba:	044a1783          	lh	a5,68(s4)
    800031be:	f97790e3          	bne	a5,s7,8000313e <namex+0x60>
    if(nameiparent && *path == '\0'){
    800031c2:	000b0563          	beqz	s6,800031cc <namex+0xee>
    800031c6:	0004c783          	lbu	a5,0(s1)
    800031ca:	dfd9                	beqz	a5,80003168 <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    800031cc:	4601                	li	a2,0
    800031ce:	85d6                	mv	a1,s5
    800031d0:	8552                	mv	a0,s4
    800031d2:	00000097          	auipc	ra,0x0
    800031d6:	e4c080e7          	jalr	-436(ra) # 8000301e <dirlookup>
    800031da:	89aa                	mv	s3,a0
    800031dc:	dd41                	beqz	a0,80003174 <namex+0x96>
    iunlockput(ip);
    800031de:	8552                	mv	a0,s4
    800031e0:	00000097          	auipc	ra,0x0
    800031e4:	bb4080e7          	jalr	-1100(ra) # 80002d94 <iunlockput>
    ip = next;
    800031e8:	8a4e                	mv	s4,s3
  while(*path == '/')
    800031ea:	0004c783          	lbu	a5,0(s1)
    800031ee:	01279763          	bne	a5,s2,800031fc <namex+0x11e>
    path++;
    800031f2:	0485                	addi	s1,s1,1
  while(*path == '/')
    800031f4:	0004c783          	lbu	a5,0(s1)
    800031f8:	ff278de3          	beq	a5,s2,800031f2 <namex+0x114>
  if(*path == 0)
    800031fc:	cb9d                	beqz	a5,80003232 <namex+0x154>
  while(*path != '/' && *path != 0)
    800031fe:	0004c783          	lbu	a5,0(s1)
    80003202:	89a6                	mv	s3,s1
  len = path - s;
    80003204:	4d01                	li	s10,0
    80003206:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    80003208:	01278963          	beq	a5,s2,8000321a <namex+0x13c>
    8000320c:	dbbd                	beqz	a5,80003182 <namex+0xa4>
    path++;
    8000320e:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80003210:	0009c783          	lbu	a5,0(s3)
    80003214:	ff279ce3          	bne	a5,s2,8000320c <namex+0x12e>
    80003218:	b7ad                	j	80003182 <namex+0xa4>
    memmove(name, s, len);
    8000321a:	2601                	sext.w	a2,a2
    8000321c:	85a6                	mv	a1,s1
    8000321e:	8556                	mv	a0,s5
    80003220:	ffffd097          	auipc	ra,0xffffd
    80003224:	fbe080e7          	jalr	-66(ra) # 800001de <memmove>
    name[len] = 0;
    80003228:	9d56                	add	s10,s10,s5
    8000322a:	000d0023          	sb	zero,0(s10)
    8000322e:	84ce                	mv	s1,s3
    80003230:	b7bd                	j	8000319e <namex+0xc0>
  if(nameiparent){
    80003232:	f00b0ce3          	beqz	s6,8000314a <namex+0x6c>
    iput(ip);
    80003236:	8552                	mv	a0,s4
    80003238:	00000097          	auipc	ra,0x0
    8000323c:	ab4080e7          	jalr	-1356(ra) # 80002cec <iput>
    return 0;
    80003240:	4a01                	li	s4,0
    80003242:	b721                	j	8000314a <namex+0x6c>

0000000080003244 <dirlink>:
{
    80003244:	715d                	addi	sp,sp,-80
    80003246:	e486                	sd	ra,72(sp)
    80003248:	e0a2                	sd	s0,64(sp)
    8000324a:	f84a                	sd	s2,48(sp)
    8000324c:	ec56                	sd	s5,24(sp)
    8000324e:	e85a                	sd	s6,16(sp)
    80003250:	0880                	addi	s0,sp,80
    80003252:	892a                	mv	s2,a0
    80003254:	8aae                	mv	s5,a1
    80003256:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003258:	4601                	li	a2,0
    8000325a:	00000097          	auipc	ra,0x0
    8000325e:	dc4080e7          	jalr	-572(ra) # 8000301e <dirlookup>
    80003262:	e129                	bnez	a0,800032a4 <dirlink+0x60>
    80003264:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003266:	04c92483          	lw	s1,76(s2)
    8000326a:	cca9                	beqz	s1,800032c4 <dirlink+0x80>
    8000326c:	f44e                	sd	s3,40(sp)
    8000326e:	f052                	sd	s4,32(sp)
    80003270:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003272:	fb040a13          	addi	s4,s0,-80
    80003276:	49c1                	li	s3,16
    80003278:	874e                	mv	a4,s3
    8000327a:	86a6                	mv	a3,s1
    8000327c:	8652                	mv	a2,s4
    8000327e:	4581                	li	a1,0
    80003280:	854a                	mv	a0,s2
    80003282:	00000097          	auipc	ra,0x0
    80003286:	b68080e7          	jalr	-1176(ra) # 80002dea <readi>
    8000328a:	03351363          	bne	a0,s3,800032b0 <dirlink+0x6c>
    if(de.inum == 0)
    8000328e:	fb045783          	lhu	a5,-80(s0)
    80003292:	c79d                	beqz	a5,800032c0 <dirlink+0x7c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003294:	24c1                	addiw	s1,s1,16
    80003296:	04c92783          	lw	a5,76(s2)
    8000329a:	fcf4efe3          	bltu	s1,a5,80003278 <dirlink+0x34>
    8000329e:	79a2                	ld	s3,40(sp)
    800032a0:	7a02                	ld	s4,32(sp)
    800032a2:	a00d                	j	800032c4 <dirlink+0x80>
    iput(ip);
    800032a4:	00000097          	auipc	ra,0x0
    800032a8:	a48080e7          	jalr	-1464(ra) # 80002cec <iput>
    return -1;
    800032ac:	557d                	li	a0,-1
    800032ae:	a0a9                	j	800032f8 <dirlink+0xb4>
      panic("dirlink read");
    800032b0:	00005517          	auipc	a0,0x5
    800032b4:	2a850513          	addi	a0,a0,680 # 80008558 <etext+0x558>
    800032b8:	00003097          	auipc	ra,0x3
    800032bc:	a3a080e7          	jalr	-1478(ra) # 80005cf2 <panic>
    800032c0:	79a2                	ld	s3,40(sp)
    800032c2:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    800032c4:	4639                	li	a2,14
    800032c6:	85d6                	mv	a1,s5
    800032c8:	fb240513          	addi	a0,s0,-78
    800032cc:	ffffd097          	auipc	ra,0xffffd
    800032d0:	fc4080e7          	jalr	-60(ra) # 80000290 <strncpy>
  de.inum = inum;
    800032d4:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032d8:	4741                	li	a4,16
    800032da:	86a6                	mv	a3,s1
    800032dc:	fb040613          	addi	a2,s0,-80
    800032e0:	4581                	li	a1,0
    800032e2:	854a                	mv	a0,s2
    800032e4:	00000097          	auipc	ra,0x0
    800032e8:	c00080e7          	jalr	-1024(ra) # 80002ee4 <writei>
    800032ec:	872a                	mv	a4,a0
    800032ee:	47c1                	li	a5,16
  return 0;
    800032f0:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032f2:	00f71a63          	bne	a4,a5,80003306 <dirlink+0xc2>
    800032f6:	74e2                	ld	s1,56(sp)
}
    800032f8:	60a6                	ld	ra,72(sp)
    800032fa:	6406                	ld	s0,64(sp)
    800032fc:	7942                	ld	s2,48(sp)
    800032fe:	6ae2                	ld	s5,24(sp)
    80003300:	6b42                	ld	s6,16(sp)
    80003302:	6161                	addi	sp,sp,80
    80003304:	8082                	ret
    80003306:	f44e                	sd	s3,40(sp)
    80003308:	f052                	sd	s4,32(sp)
    panic("dirlink");
    8000330a:	00005517          	auipc	a0,0x5
    8000330e:	35650513          	addi	a0,a0,854 # 80008660 <etext+0x660>
    80003312:	00003097          	auipc	ra,0x3
    80003316:	9e0080e7          	jalr	-1568(ra) # 80005cf2 <panic>

000000008000331a <namei>:

struct inode*
namei(char *path)
{
    8000331a:	1101                	addi	sp,sp,-32
    8000331c:	ec06                	sd	ra,24(sp)
    8000331e:	e822                	sd	s0,16(sp)
    80003320:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003322:	fe040613          	addi	a2,s0,-32
    80003326:	4581                	li	a1,0
    80003328:	00000097          	auipc	ra,0x0
    8000332c:	db6080e7          	jalr	-586(ra) # 800030de <namex>
}
    80003330:	60e2                	ld	ra,24(sp)
    80003332:	6442                	ld	s0,16(sp)
    80003334:	6105                	addi	sp,sp,32
    80003336:	8082                	ret

0000000080003338 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003338:	1141                	addi	sp,sp,-16
    8000333a:	e406                	sd	ra,8(sp)
    8000333c:	e022                	sd	s0,0(sp)
    8000333e:	0800                	addi	s0,sp,16
    80003340:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003342:	4585                	li	a1,1
    80003344:	00000097          	auipc	ra,0x0
    80003348:	d9a080e7          	jalr	-614(ra) # 800030de <namex>
}
    8000334c:	60a2                	ld	ra,8(sp)
    8000334e:	6402                	ld	s0,0(sp)
    80003350:	0141                	addi	sp,sp,16
    80003352:	8082                	ret

0000000080003354 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003354:	1101                	addi	sp,sp,-32
    80003356:	ec06                	sd	ra,24(sp)
    80003358:	e822                	sd	s0,16(sp)
    8000335a:	e426                	sd	s1,8(sp)
    8000335c:	e04a                	sd	s2,0(sp)
    8000335e:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003360:	00019917          	auipc	s2,0x19
    80003364:	ec090913          	addi	s2,s2,-320 # 8001c220 <log>
    80003368:	01892583          	lw	a1,24(s2)
    8000336c:	02892503          	lw	a0,40(s2)
    80003370:	fffff097          	auipc	ra,0xfffff
    80003374:	fe2080e7          	jalr	-30(ra) # 80002352 <bread>
    80003378:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    8000337a:	02c92603          	lw	a2,44(s2)
    8000337e:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003380:	00c05f63          	blez	a2,8000339e <write_head+0x4a>
    80003384:	00019717          	auipc	a4,0x19
    80003388:	ecc70713          	addi	a4,a4,-308 # 8001c250 <log+0x30>
    8000338c:	87aa                	mv	a5,a0
    8000338e:	060a                	slli	a2,a2,0x2
    80003390:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80003392:	4314                	lw	a3,0(a4)
    80003394:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003396:	0711                	addi	a4,a4,4
    80003398:	0791                	addi	a5,a5,4
    8000339a:	fec79ce3          	bne	a5,a2,80003392 <write_head+0x3e>
  }
  bwrite(buf);
    8000339e:	8526                	mv	a0,s1
    800033a0:	fffff097          	auipc	ra,0xfffff
    800033a4:	0a4080e7          	jalr	164(ra) # 80002444 <bwrite>
  brelse(buf);
    800033a8:	8526                	mv	a0,s1
    800033aa:	fffff097          	auipc	ra,0xfffff
    800033ae:	0d8080e7          	jalr	216(ra) # 80002482 <brelse>
}
    800033b2:	60e2                	ld	ra,24(sp)
    800033b4:	6442                	ld	s0,16(sp)
    800033b6:	64a2                	ld	s1,8(sp)
    800033b8:	6902                	ld	s2,0(sp)
    800033ba:	6105                	addi	sp,sp,32
    800033bc:	8082                	ret

00000000800033be <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800033be:	00019797          	auipc	a5,0x19
    800033c2:	e8e7a783          	lw	a5,-370(a5) # 8001c24c <log+0x2c>
    800033c6:	0cf05063          	blez	a5,80003486 <install_trans+0xc8>
{
    800033ca:	715d                	addi	sp,sp,-80
    800033cc:	e486                	sd	ra,72(sp)
    800033ce:	e0a2                	sd	s0,64(sp)
    800033d0:	fc26                	sd	s1,56(sp)
    800033d2:	f84a                	sd	s2,48(sp)
    800033d4:	f44e                	sd	s3,40(sp)
    800033d6:	f052                	sd	s4,32(sp)
    800033d8:	ec56                	sd	s5,24(sp)
    800033da:	e85a                	sd	s6,16(sp)
    800033dc:	e45e                	sd	s7,8(sp)
    800033de:	0880                	addi	s0,sp,80
    800033e0:	8b2a                	mv	s6,a0
    800033e2:	00019a97          	auipc	s5,0x19
    800033e6:	e6ea8a93          	addi	s5,s5,-402 # 8001c250 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800033ea:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800033ec:	00019997          	auipc	s3,0x19
    800033f0:	e3498993          	addi	s3,s3,-460 # 8001c220 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800033f4:	40000b93          	li	s7,1024
    800033f8:	a00d                	j	8000341a <install_trans+0x5c>
    brelse(lbuf);
    800033fa:	854a                	mv	a0,s2
    800033fc:	fffff097          	auipc	ra,0xfffff
    80003400:	086080e7          	jalr	134(ra) # 80002482 <brelse>
    brelse(dbuf);
    80003404:	8526                	mv	a0,s1
    80003406:	fffff097          	auipc	ra,0xfffff
    8000340a:	07c080e7          	jalr	124(ra) # 80002482 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000340e:	2a05                	addiw	s4,s4,1
    80003410:	0a91                	addi	s5,s5,4
    80003412:	02c9a783          	lw	a5,44(s3)
    80003416:	04fa5d63          	bge	s4,a5,80003470 <install_trans+0xb2>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000341a:	0189a583          	lw	a1,24(s3)
    8000341e:	014585bb          	addw	a1,a1,s4
    80003422:	2585                	addiw	a1,a1,1
    80003424:	0289a503          	lw	a0,40(s3)
    80003428:	fffff097          	auipc	ra,0xfffff
    8000342c:	f2a080e7          	jalr	-214(ra) # 80002352 <bread>
    80003430:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003432:	000aa583          	lw	a1,0(s5)
    80003436:	0289a503          	lw	a0,40(s3)
    8000343a:	fffff097          	auipc	ra,0xfffff
    8000343e:	f18080e7          	jalr	-232(ra) # 80002352 <bread>
    80003442:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003444:	865e                	mv	a2,s7
    80003446:	05890593          	addi	a1,s2,88
    8000344a:	05850513          	addi	a0,a0,88
    8000344e:	ffffd097          	auipc	ra,0xffffd
    80003452:	d90080e7          	jalr	-624(ra) # 800001de <memmove>
    bwrite(dbuf);  // write dst to disk
    80003456:	8526                	mv	a0,s1
    80003458:	fffff097          	auipc	ra,0xfffff
    8000345c:	fec080e7          	jalr	-20(ra) # 80002444 <bwrite>
    if(recovering == 0)
    80003460:	f80b1de3          	bnez	s6,800033fa <install_trans+0x3c>
      bunpin(dbuf);
    80003464:	8526                	mv	a0,s1
    80003466:	fffff097          	auipc	ra,0xfffff
    8000346a:	0f0080e7          	jalr	240(ra) # 80002556 <bunpin>
    8000346e:	b771                	j	800033fa <install_trans+0x3c>
}
    80003470:	60a6                	ld	ra,72(sp)
    80003472:	6406                	ld	s0,64(sp)
    80003474:	74e2                	ld	s1,56(sp)
    80003476:	7942                	ld	s2,48(sp)
    80003478:	79a2                	ld	s3,40(sp)
    8000347a:	7a02                	ld	s4,32(sp)
    8000347c:	6ae2                	ld	s5,24(sp)
    8000347e:	6b42                	ld	s6,16(sp)
    80003480:	6ba2                	ld	s7,8(sp)
    80003482:	6161                	addi	sp,sp,80
    80003484:	8082                	ret
    80003486:	8082                	ret

0000000080003488 <initlog>:
{
    80003488:	7179                	addi	sp,sp,-48
    8000348a:	f406                	sd	ra,40(sp)
    8000348c:	f022                	sd	s0,32(sp)
    8000348e:	ec26                	sd	s1,24(sp)
    80003490:	e84a                	sd	s2,16(sp)
    80003492:	e44e                	sd	s3,8(sp)
    80003494:	1800                	addi	s0,sp,48
    80003496:	892a                	mv	s2,a0
    80003498:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    8000349a:	00019497          	auipc	s1,0x19
    8000349e:	d8648493          	addi	s1,s1,-634 # 8001c220 <log>
    800034a2:	00005597          	auipc	a1,0x5
    800034a6:	0c658593          	addi	a1,a1,198 # 80008568 <etext+0x568>
    800034aa:	8526                	mv	a0,s1
    800034ac:	00003097          	auipc	ra,0x3
    800034b0:	d32080e7          	jalr	-718(ra) # 800061de <initlock>
  log.start = sb->logstart;
    800034b4:	0149a583          	lw	a1,20(s3)
    800034b8:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800034ba:	0109a783          	lw	a5,16(s3)
    800034be:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800034c0:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800034c4:	854a                	mv	a0,s2
    800034c6:	fffff097          	auipc	ra,0xfffff
    800034ca:	e8c080e7          	jalr	-372(ra) # 80002352 <bread>
  log.lh.n = lh->n;
    800034ce:	4d30                	lw	a2,88(a0)
    800034d0:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800034d2:	00c05f63          	blez	a2,800034f0 <initlog+0x68>
    800034d6:	87aa                	mv	a5,a0
    800034d8:	00019717          	auipc	a4,0x19
    800034dc:	d7870713          	addi	a4,a4,-648 # 8001c250 <log+0x30>
    800034e0:	060a                	slli	a2,a2,0x2
    800034e2:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    800034e4:	4ff4                	lw	a3,92(a5)
    800034e6:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800034e8:	0791                	addi	a5,a5,4
    800034ea:	0711                	addi	a4,a4,4
    800034ec:	fec79ce3          	bne	a5,a2,800034e4 <initlog+0x5c>
  brelse(buf);
    800034f0:	fffff097          	auipc	ra,0xfffff
    800034f4:	f92080e7          	jalr	-110(ra) # 80002482 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800034f8:	4505                	li	a0,1
    800034fa:	00000097          	auipc	ra,0x0
    800034fe:	ec4080e7          	jalr	-316(ra) # 800033be <install_trans>
  log.lh.n = 0;
    80003502:	00019797          	auipc	a5,0x19
    80003506:	d407a523          	sw	zero,-694(a5) # 8001c24c <log+0x2c>
  write_head(); // clear the log
    8000350a:	00000097          	auipc	ra,0x0
    8000350e:	e4a080e7          	jalr	-438(ra) # 80003354 <write_head>
}
    80003512:	70a2                	ld	ra,40(sp)
    80003514:	7402                	ld	s0,32(sp)
    80003516:	64e2                	ld	s1,24(sp)
    80003518:	6942                	ld	s2,16(sp)
    8000351a:	69a2                	ld	s3,8(sp)
    8000351c:	6145                	addi	sp,sp,48
    8000351e:	8082                	ret

0000000080003520 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003520:	1101                	addi	sp,sp,-32
    80003522:	ec06                	sd	ra,24(sp)
    80003524:	e822                	sd	s0,16(sp)
    80003526:	e426                	sd	s1,8(sp)
    80003528:	e04a                	sd	s2,0(sp)
    8000352a:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000352c:	00019517          	auipc	a0,0x19
    80003530:	cf450513          	addi	a0,a0,-780 # 8001c220 <log>
    80003534:	00003097          	auipc	ra,0x3
    80003538:	d3e080e7          	jalr	-706(ra) # 80006272 <acquire>
  while(1){
    if(log.committing){
    8000353c:	00019497          	auipc	s1,0x19
    80003540:	ce448493          	addi	s1,s1,-796 # 8001c220 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003544:	4979                	li	s2,30
    80003546:	a039                	j	80003554 <begin_op+0x34>
      sleep(&log, &log.lock);
    80003548:	85a6                	mv	a1,s1
    8000354a:	8526                	mv	a0,s1
    8000354c:	ffffe097          	auipc	ra,0xffffe
    80003550:	028080e7          	jalr	40(ra) # 80001574 <sleep>
    if(log.committing){
    80003554:	50dc                	lw	a5,36(s1)
    80003556:	fbed                	bnez	a5,80003548 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003558:	5098                	lw	a4,32(s1)
    8000355a:	2705                	addiw	a4,a4,1
    8000355c:	0027179b          	slliw	a5,a4,0x2
    80003560:	9fb9                	addw	a5,a5,a4
    80003562:	0017979b          	slliw	a5,a5,0x1
    80003566:	54d4                	lw	a3,44(s1)
    80003568:	9fb5                	addw	a5,a5,a3
    8000356a:	00f95963          	bge	s2,a5,8000357c <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000356e:	85a6                	mv	a1,s1
    80003570:	8526                	mv	a0,s1
    80003572:	ffffe097          	auipc	ra,0xffffe
    80003576:	002080e7          	jalr	2(ra) # 80001574 <sleep>
    8000357a:	bfe9                	j	80003554 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    8000357c:	00019517          	auipc	a0,0x19
    80003580:	ca450513          	addi	a0,a0,-860 # 8001c220 <log>
    80003584:	d118                	sw	a4,32(a0)
      release(&log.lock);
    80003586:	00003097          	auipc	ra,0x3
    8000358a:	d9c080e7          	jalr	-612(ra) # 80006322 <release>
      break;
    }
  }
}
    8000358e:	60e2                	ld	ra,24(sp)
    80003590:	6442                	ld	s0,16(sp)
    80003592:	64a2                	ld	s1,8(sp)
    80003594:	6902                	ld	s2,0(sp)
    80003596:	6105                	addi	sp,sp,32
    80003598:	8082                	ret

000000008000359a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000359a:	7139                	addi	sp,sp,-64
    8000359c:	fc06                	sd	ra,56(sp)
    8000359e:	f822                	sd	s0,48(sp)
    800035a0:	f426                	sd	s1,40(sp)
    800035a2:	f04a                	sd	s2,32(sp)
    800035a4:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800035a6:	00019497          	auipc	s1,0x19
    800035aa:	c7a48493          	addi	s1,s1,-902 # 8001c220 <log>
    800035ae:	8526                	mv	a0,s1
    800035b0:	00003097          	auipc	ra,0x3
    800035b4:	cc2080e7          	jalr	-830(ra) # 80006272 <acquire>
  log.outstanding -= 1;
    800035b8:	509c                	lw	a5,32(s1)
    800035ba:	37fd                	addiw	a5,a5,-1
    800035bc:	893e                	mv	s2,a5
    800035be:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800035c0:	50dc                	lw	a5,36(s1)
    800035c2:	e7b9                	bnez	a5,80003610 <end_op+0x76>
    panic("log.committing");
  if(log.outstanding == 0){
    800035c4:	06091263          	bnez	s2,80003628 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800035c8:	00019497          	auipc	s1,0x19
    800035cc:	c5848493          	addi	s1,s1,-936 # 8001c220 <log>
    800035d0:	4785                	li	a5,1
    800035d2:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800035d4:	8526                	mv	a0,s1
    800035d6:	00003097          	auipc	ra,0x3
    800035da:	d4c080e7          	jalr	-692(ra) # 80006322 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800035de:	54dc                	lw	a5,44(s1)
    800035e0:	06f04863          	bgtz	a5,80003650 <end_op+0xb6>
    acquire(&log.lock);
    800035e4:	00019497          	auipc	s1,0x19
    800035e8:	c3c48493          	addi	s1,s1,-964 # 8001c220 <log>
    800035ec:	8526                	mv	a0,s1
    800035ee:	00003097          	auipc	ra,0x3
    800035f2:	c84080e7          	jalr	-892(ra) # 80006272 <acquire>
    log.committing = 0;
    800035f6:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800035fa:	8526                	mv	a0,s1
    800035fc:	ffffe097          	auipc	ra,0xffffe
    80003600:	0fe080e7          	jalr	254(ra) # 800016fa <wakeup>
    release(&log.lock);
    80003604:	8526                	mv	a0,s1
    80003606:	00003097          	auipc	ra,0x3
    8000360a:	d1c080e7          	jalr	-740(ra) # 80006322 <release>
}
    8000360e:	a81d                	j	80003644 <end_op+0xaa>
    80003610:	ec4e                	sd	s3,24(sp)
    80003612:	e852                	sd	s4,16(sp)
    80003614:	e456                	sd	s5,8(sp)
    80003616:	e05a                	sd	s6,0(sp)
    panic("log.committing");
    80003618:	00005517          	auipc	a0,0x5
    8000361c:	f5850513          	addi	a0,a0,-168 # 80008570 <etext+0x570>
    80003620:	00002097          	auipc	ra,0x2
    80003624:	6d2080e7          	jalr	1746(ra) # 80005cf2 <panic>
    wakeup(&log);
    80003628:	00019497          	auipc	s1,0x19
    8000362c:	bf848493          	addi	s1,s1,-1032 # 8001c220 <log>
    80003630:	8526                	mv	a0,s1
    80003632:	ffffe097          	auipc	ra,0xffffe
    80003636:	0c8080e7          	jalr	200(ra) # 800016fa <wakeup>
  release(&log.lock);
    8000363a:	8526                	mv	a0,s1
    8000363c:	00003097          	auipc	ra,0x3
    80003640:	ce6080e7          	jalr	-794(ra) # 80006322 <release>
}
    80003644:	70e2                	ld	ra,56(sp)
    80003646:	7442                	ld	s0,48(sp)
    80003648:	74a2                	ld	s1,40(sp)
    8000364a:	7902                	ld	s2,32(sp)
    8000364c:	6121                	addi	sp,sp,64
    8000364e:	8082                	ret
    80003650:	ec4e                	sd	s3,24(sp)
    80003652:	e852                	sd	s4,16(sp)
    80003654:	e456                	sd	s5,8(sp)
    80003656:	e05a                	sd	s6,0(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80003658:	00019a97          	auipc	s5,0x19
    8000365c:	bf8a8a93          	addi	s5,s5,-1032 # 8001c250 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003660:	00019a17          	auipc	s4,0x19
    80003664:	bc0a0a13          	addi	s4,s4,-1088 # 8001c220 <log>
    memmove(to->data, from->data, BSIZE);
    80003668:	40000b13          	li	s6,1024
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    8000366c:	018a2583          	lw	a1,24(s4)
    80003670:	012585bb          	addw	a1,a1,s2
    80003674:	2585                	addiw	a1,a1,1
    80003676:	028a2503          	lw	a0,40(s4)
    8000367a:	fffff097          	auipc	ra,0xfffff
    8000367e:	cd8080e7          	jalr	-808(ra) # 80002352 <bread>
    80003682:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003684:	000aa583          	lw	a1,0(s5)
    80003688:	028a2503          	lw	a0,40(s4)
    8000368c:	fffff097          	auipc	ra,0xfffff
    80003690:	cc6080e7          	jalr	-826(ra) # 80002352 <bread>
    80003694:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003696:	865a                	mv	a2,s6
    80003698:	05850593          	addi	a1,a0,88
    8000369c:	05848513          	addi	a0,s1,88
    800036a0:	ffffd097          	auipc	ra,0xffffd
    800036a4:	b3e080e7          	jalr	-1218(ra) # 800001de <memmove>
    bwrite(to);  // write the log
    800036a8:	8526                	mv	a0,s1
    800036aa:	fffff097          	auipc	ra,0xfffff
    800036ae:	d9a080e7          	jalr	-614(ra) # 80002444 <bwrite>
    brelse(from);
    800036b2:	854e                	mv	a0,s3
    800036b4:	fffff097          	auipc	ra,0xfffff
    800036b8:	dce080e7          	jalr	-562(ra) # 80002482 <brelse>
    brelse(to);
    800036bc:	8526                	mv	a0,s1
    800036be:	fffff097          	auipc	ra,0xfffff
    800036c2:	dc4080e7          	jalr	-572(ra) # 80002482 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800036c6:	2905                	addiw	s2,s2,1
    800036c8:	0a91                	addi	s5,s5,4
    800036ca:	02ca2783          	lw	a5,44(s4)
    800036ce:	f8f94fe3          	blt	s2,a5,8000366c <end_op+0xd2>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800036d2:	00000097          	auipc	ra,0x0
    800036d6:	c82080e7          	jalr	-894(ra) # 80003354 <write_head>
    install_trans(0); // Now install writes to home locations
    800036da:	4501                	li	a0,0
    800036dc:	00000097          	auipc	ra,0x0
    800036e0:	ce2080e7          	jalr	-798(ra) # 800033be <install_trans>
    log.lh.n = 0;
    800036e4:	00019797          	auipc	a5,0x19
    800036e8:	b607a423          	sw	zero,-1176(a5) # 8001c24c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800036ec:	00000097          	auipc	ra,0x0
    800036f0:	c68080e7          	jalr	-920(ra) # 80003354 <write_head>
    800036f4:	69e2                	ld	s3,24(sp)
    800036f6:	6a42                	ld	s4,16(sp)
    800036f8:	6aa2                	ld	s5,8(sp)
    800036fa:	6b02                	ld	s6,0(sp)
    800036fc:	b5e5                	j	800035e4 <end_op+0x4a>

00000000800036fe <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800036fe:	1101                	addi	sp,sp,-32
    80003700:	ec06                	sd	ra,24(sp)
    80003702:	e822                	sd	s0,16(sp)
    80003704:	e426                	sd	s1,8(sp)
    80003706:	e04a                	sd	s2,0(sp)
    80003708:	1000                	addi	s0,sp,32
    8000370a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000370c:	00019917          	auipc	s2,0x19
    80003710:	b1490913          	addi	s2,s2,-1260 # 8001c220 <log>
    80003714:	854a                	mv	a0,s2
    80003716:	00003097          	auipc	ra,0x3
    8000371a:	b5c080e7          	jalr	-1188(ra) # 80006272 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000371e:	02c92603          	lw	a2,44(s2)
    80003722:	47f5                	li	a5,29
    80003724:	06c7c563          	blt	a5,a2,8000378e <log_write+0x90>
    80003728:	00019797          	auipc	a5,0x19
    8000372c:	b147a783          	lw	a5,-1260(a5) # 8001c23c <log+0x1c>
    80003730:	37fd                	addiw	a5,a5,-1
    80003732:	04f65e63          	bge	a2,a5,8000378e <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003736:	00019797          	auipc	a5,0x19
    8000373a:	b0a7a783          	lw	a5,-1270(a5) # 8001c240 <log+0x20>
    8000373e:	06f05063          	blez	a5,8000379e <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003742:	4781                	li	a5,0
    80003744:	06c05563          	blez	a2,800037ae <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003748:	44cc                	lw	a1,12(s1)
    8000374a:	00019717          	auipc	a4,0x19
    8000374e:	b0670713          	addi	a4,a4,-1274 # 8001c250 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003752:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003754:	4314                	lw	a3,0(a4)
    80003756:	04b68c63          	beq	a3,a1,800037ae <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    8000375a:	2785                	addiw	a5,a5,1
    8000375c:	0711                	addi	a4,a4,4
    8000375e:	fef61be3          	bne	a2,a5,80003754 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003762:	0621                	addi	a2,a2,8
    80003764:	060a                	slli	a2,a2,0x2
    80003766:	00019797          	auipc	a5,0x19
    8000376a:	aba78793          	addi	a5,a5,-1350 # 8001c220 <log>
    8000376e:	97b2                	add	a5,a5,a2
    80003770:	44d8                	lw	a4,12(s1)
    80003772:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003774:	8526                	mv	a0,s1
    80003776:	fffff097          	auipc	ra,0xfffff
    8000377a:	da4080e7          	jalr	-604(ra) # 8000251a <bpin>
    log.lh.n++;
    8000377e:	00019717          	auipc	a4,0x19
    80003782:	aa270713          	addi	a4,a4,-1374 # 8001c220 <log>
    80003786:	575c                	lw	a5,44(a4)
    80003788:	2785                	addiw	a5,a5,1
    8000378a:	d75c                	sw	a5,44(a4)
    8000378c:	a82d                	j	800037c6 <log_write+0xc8>
    panic("too big a transaction");
    8000378e:	00005517          	auipc	a0,0x5
    80003792:	df250513          	addi	a0,a0,-526 # 80008580 <etext+0x580>
    80003796:	00002097          	auipc	ra,0x2
    8000379a:	55c080e7          	jalr	1372(ra) # 80005cf2 <panic>
    panic("log_write outside of trans");
    8000379e:	00005517          	auipc	a0,0x5
    800037a2:	dfa50513          	addi	a0,a0,-518 # 80008598 <etext+0x598>
    800037a6:	00002097          	auipc	ra,0x2
    800037aa:	54c080e7          	jalr	1356(ra) # 80005cf2 <panic>
  log.lh.block[i] = b->blockno;
    800037ae:	00878693          	addi	a3,a5,8
    800037b2:	068a                	slli	a3,a3,0x2
    800037b4:	00019717          	auipc	a4,0x19
    800037b8:	a6c70713          	addi	a4,a4,-1428 # 8001c220 <log>
    800037bc:	9736                	add	a4,a4,a3
    800037be:	44d4                	lw	a3,12(s1)
    800037c0:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800037c2:	faf609e3          	beq	a2,a5,80003774 <log_write+0x76>
  }
  release(&log.lock);
    800037c6:	00019517          	auipc	a0,0x19
    800037ca:	a5a50513          	addi	a0,a0,-1446 # 8001c220 <log>
    800037ce:	00003097          	auipc	ra,0x3
    800037d2:	b54080e7          	jalr	-1196(ra) # 80006322 <release>
}
    800037d6:	60e2                	ld	ra,24(sp)
    800037d8:	6442                	ld	s0,16(sp)
    800037da:	64a2                	ld	s1,8(sp)
    800037dc:	6902                	ld	s2,0(sp)
    800037de:	6105                	addi	sp,sp,32
    800037e0:	8082                	ret

00000000800037e2 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800037e2:	1101                	addi	sp,sp,-32
    800037e4:	ec06                	sd	ra,24(sp)
    800037e6:	e822                	sd	s0,16(sp)
    800037e8:	e426                	sd	s1,8(sp)
    800037ea:	e04a                	sd	s2,0(sp)
    800037ec:	1000                	addi	s0,sp,32
    800037ee:	84aa                	mv	s1,a0
    800037f0:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800037f2:	00005597          	auipc	a1,0x5
    800037f6:	dc658593          	addi	a1,a1,-570 # 800085b8 <etext+0x5b8>
    800037fa:	0521                	addi	a0,a0,8
    800037fc:	00003097          	auipc	ra,0x3
    80003800:	9e2080e7          	jalr	-1566(ra) # 800061de <initlock>
  lk->name = name;
    80003804:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003808:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000380c:	0204a423          	sw	zero,40(s1)
}
    80003810:	60e2                	ld	ra,24(sp)
    80003812:	6442                	ld	s0,16(sp)
    80003814:	64a2                	ld	s1,8(sp)
    80003816:	6902                	ld	s2,0(sp)
    80003818:	6105                	addi	sp,sp,32
    8000381a:	8082                	ret

000000008000381c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000381c:	1101                	addi	sp,sp,-32
    8000381e:	ec06                	sd	ra,24(sp)
    80003820:	e822                	sd	s0,16(sp)
    80003822:	e426                	sd	s1,8(sp)
    80003824:	e04a                	sd	s2,0(sp)
    80003826:	1000                	addi	s0,sp,32
    80003828:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000382a:	00850913          	addi	s2,a0,8
    8000382e:	854a                	mv	a0,s2
    80003830:	00003097          	auipc	ra,0x3
    80003834:	a42080e7          	jalr	-1470(ra) # 80006272 <acquire>
  while (lk->locked) {
    80003838:	409c                	lw	a5,0(s1)
    8000383a:	cb89                	beqz	a5,8000384c <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    8000383c:	85ca                	mv	a1,s2
    8000383e:	8526                	mv	a0,s1
    80003840:	ffffe097          	auipc	ra,0xffffe
    80003844:	d34080e7          	jalr	-716(ra) # 80001574 <sleep>
  while (lk->locked) {
    80003848:	409c                	lw	a5,0(s1)
    8000384a:	fbed                	bnez	a5,8000383c <acquiresleep+0x20>
  }
  lk->locked = 1;
    8000384c:	4785                	li	a5,1
    8000384e:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003850:	ffffd097          	auipc	ra,0xffffd
    80003854:	652080e7          	jalr	1618(ra) # 80000ea2 <myproc>
    80003858:	591c                	lw	a5,48(a0)
    8000385a:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    8000385c:	854a                	mv	a0,s2
    8000385e:	00003097          	auipc	ra,0x3
    80003862:	ac4080e7          	jalr	-1340(ra) # 80006322 <release>
}
    80003866:	60e2                	ld	ra,24(sp)
    80003868:	6442                	ld	s0,16(sp)
    8000386a:	64a2                	ld	s1,8(sp)
    8000386c:	6902                	ld	s2,0(sp)
    8000386e:	6105                	addi	sp,sp,32
    80003870:	8082                	ret

0000000080003872 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003872:	1101                	addi	sp,sp,-32
    80003874:	ec06                	sd	ra,24(sp)
    80003876:	e822                	sd	s0,16(sp)
    80003878:	e426                	sd	s1,8(sp)
    8000387a:	e04a                	sd	s2,0(sp)
    8000387c:	1000                	addi	s0,sp,32
    8000387e:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003880:	00850913          	addi	s2,a0,8
    80003884:	854a                	mv	a0,s2
    80003886:	00003097          	auipc	ra,0x3
    8000388a:	9ec080e7          	jalr	-1556(ra) # 80006272 <acquire>
  lk->locked = 0;
    8000388e:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003892:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003896:	8526                	mv	a0,s1
    80003898:	ffffe097          	auipc	ra,0xffffe
    8000389c:	e62080e7          	jalr	-414(ra) # 800016fa <wakeup>
  release(&lk->lk);
    800038a0:	854a                	mv	a0,s2
    800038a2:	00003097          	auipc	ra,0x3
    800038a6:	a80080e7          	jalr	-1408(ra) # 80006322 <release>
}
    800038aa:	60e2                	ld	ra,24(sp)
    800038ac:	6442                	ld	s0,16(sp)
    800038ae:	64a2                	ld	s1,8(sp)
    800038b0:	6902                	ld	s2,0(sp)
    800038b2:	6105                	addi	sp,sp,32
    800038b4:	8082                	ret

00000000800038b6 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800038b6:	7179                	addi	sp,sp,-48
    800038b8:	f406                	sd	ra,40(sp)
    800038ba:	f022                	sd	s0,32(sp)
    800038bc:	ec26                	sd	s1,24(sp)
    800038be:	e84a                	sd	s2,16(sp)
    800038c0:	1800                	addi	s0,sp,48
    800038c2:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    800038c4:	00850913          	addi	s2,a0,8
    800038c8:	854a                	mv	a0,s2
    800038ca:	00003097          	auipc	ra,0x3
    800038ce:	9a8080e7          	jalr	-1624(ra) # 80006272 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    800038d2:	409c                	lw	a5,0(s1)
    800038d4:	ef91                	bnez	a5,800038f0 <holdingsleep+0x3a>
    800038d6:	4481                	li	s1,0
  release(&lk->lk);
    800038d8:	854a                	mv	a0,s2
    800038da:	00003097          	auipc	ra,0x3
    800038de:	a48080e7          	jalr	-1464(ra) # 80006322 <release>
  return r;
}
    800038e2:	8526                	mv	a0,s1
    800038e4:	70a2                	ld	ra,40(sp)
    800038e6:	7402                	ld	s0,32(sp)
    800038e8:	64e2                	ld	s1,24(sp)
    800038ea:	6942                	ld	s2,16(sp)
    800038ec:	6145                	addi	sp,sp,48
    800038ee:	8082                	ret
    800038f0:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    800038f2:	0284a983          	lw	s3,40(s1)
    800038f6:	ffffd097          	auipc	ra,0xffffd
    800038fa:	5ac080e7          	jalr	1452(ra) # 80000ea2 <myproc>
    800038fe:	5904                	lw	s1,48(a0)
    80003900:	413484b3          	sub	s1,s1,s3
    80003904:	0014b493          	seqz	s1,s1
    80003908:	69a2                	ld	s3,8(sp)
    8000390a:	b7f9                	j	800038d8 <holdingsleep+0x22>

000000008000390c <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000390c:	1141                	addi	sp,sp,-16
    8000390e:	e406                	sd	ra,8(sp)
    80003910:	e022                	sd	s0,0(sp)
    80003912:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003914:	00005597          	auipc	a1,0x5
    80003918:	cb458593          	addi	a1,a1,-844 # 800085c8 <etext+0x5c8>
    8000391c:	00019517          	auipc	a0,0x19
    80003920:	a4c50513          	addi	a0,a0,-1460 # 8001c368 <ftable>
    80003924:	00003097          	auipc	ra,0x3
    80003928:	8ba080e7          	jalr	-1862(ra) # 800061de <initlock>
}
    8000392c:	60a2                	ld	ra,8(sp)
    8000392e:	6402                	ld	s0,0(sp)
    80003930:	0141                	addi	sp,sp,16
    80003932:	8082                	ret

0000000080003934 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003934:	1101                	addi	sp,sp,-32
    80003936:	ec06                	sd	ra,24(sp)
    80003938:	e822                	sd	s0,16(sp)
    8000393a:	e426                	sd	s1,8(sp)
    8000393c:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000393e:	00019517          	auipc	a0,0x19
    80003942:	a2a50513          	addi	a0,a0,-1494 # 8001c368 <ftable>
    80003946:	00003097          	auipc	ra,0x3
    8000394a:	92c080e7          	jalr	-1748(ra) # 80006272 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000394e:	00019497          	auipc	s1,0x19
    80003952:	a3248493          	addi	s1,s1,-1486 # 8001c380 <ftable+0x18>
    80003956:	0001a717          	auipc	a4,0x1a
    8000395a:	9ca70713          	addi	a4,a4,-1590 # 8001d320 <ftable+0xfb8>
    if(f->ref == 0){
    8000395e:	40dc                	lw	a5,4(s1)
    80003960:	cf99                	beqz	a5,8000397e <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003962:	02848493          	addi	s1,s1,40
    80003966:	fee49ce3          	bne	s1,a4,8000395e <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    8000396a:	00019517          	auipc	a0,0x19
    8000396e:	9fe50513          	addi	a0,a0,-1538 # 8001c368 <ftable>
    80003972:	00003097          	auipc	ra,0x3
    80003976:	9b0080e7          	jalr	-1616(ra) # 80006322 <release>
  return 0;
    8000397a:	4481                	li	s1,0
    8000397c:	a819                	j	80003992 <filealloc+0x5e>
      f->ref = 1;
    8000397e:	4785                	li	a5,1
    80003980:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003982:	00019517          	auipc	a0,0x19
    80003986:	9e650513          	addi	a0,a0,-1562 # 8001c368 <ftable>
    8000398a:	00003097          	auipc	ra,0x3
    8000398e:	998080e7          	jalr	-1640(ra) # 80006322 <release>
}
    80003992:	8526                	mv	a0,s1
    80003994:	60e2                	ld	ra,24(sp)
    80003996:	6442                	ld	s0,16(sp)
    80003998:	64a2                	ld	s1,8(sp)
    8000399a:	6105                	addi	sp,sp,32
    8000399c:	8082                	ret

000000008000399e <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000399e:	1101                	addi	sp,sp,-32
    800039a0:	ec06                	sd	ra,24(sp)
    800039a2:	e822                	sd	s0,16(sp)
    800039a4:	e426                	sd	s1,8(sp)
    800039a6:	1000                	addi	s0,sp,32
    800039a8:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800039aa:	00019517          	auipc	a0,0x19
    800039ae:	9be50513          	addi	a0,a0,-1602 # 8001c368 <ftable>
    800039b2:	00003097          	auipc	ra,0x3
    800039b6:	8c0080e7          	jalr	-1856(ra) # 80006272 <acquire>
  if(f->ref < 1)
    800039ba:	40dc                	lw	a5,4(s1)
    800039bc:	02f05263          	blez	a5,800039e0 <filedup+0x42>
    panic("filedup");
  f->ref++;
    800039c0:	2785                	addiw	a5,a5,1
    800039c2:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    800039c4:	00019517          	auipc	a0,0x19
    800039c8:	9a450513          	addi	a0,a0,-1628 # 8001c368 <ftable>
    800039cc:	00003097          	auipc	ra,0x3
    800039d0:	956080e7          	jalr	-1706(ra) # 80006322 <release>
  return f;
}
    800039d4:	8526                	mv	a0,s1
    800039d6:	60e2                	ld	ra,24(sp)
    800039d8:	6442                	ld	s0,16(sp)
    800039da:	64a2                	ld	s1,8(sp)
    800039dc:	6105                	addi	sp,sp,32
    800039de:	8082                	ret
    panic("filedup");
    800039e0:	00005517          	auipc	a0,0x5
    800039e4:	bf050513          	addi	a0,a0,-1040 # 800085d0 <etext+0x5d0>
    800039e8:	00002097          	auipc	ra,0x2
    800039ec:	30a080e7          	jalr	778(ra) # 80005cf2 <panic>

00000000800039f0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800039f0:	7139                	addi	sp,sp,-64
    800039f2:	fc06                	sd	ra,56(sp)
    800039f4:	f822                	sd	s0,48(sp)
    800039f6:	f426                	sd	s1,40(sp)
    800039f8:	0080                	addi	s0,sp,64
    800039fa:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800039fc:	00019517          	auipc	a0,0x19
    80003a00:	96c50513          	addi	a0,a0,-1684 # 8001c368 <ftable>
    80003a04:	00003097          	auipc	ra,0x3
    80003a08:	86e080e7          	jalr	-1938(ra) # 80006272 <acquire>
  if(f->ref < 1)
    80003a0c:	40dc                	lw	a5,4(s1)
    80003a0e:	04f05a63          	blez	a5,80003a62 <fileclose+0x72>
    panic("fileclose");
  if(--f->ref > 0){
    80003a12:	37fd                	addiw	a5,a5,-1
    80003a14:	c0dc                	sw	a5,4(s1)
    80003a16:	06f04263          	bgtz	a5,80003a7a <fileclose+0x8a>
    80003a1a:	f04a                	sd	s2,32(sp)
    80003a1c:	ec4e                	sd	s3,24(sp)
    80003a1e:	e852                	sd	s4,16(sp)
    80003a20:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003a22:	0004a903          	lw	s2,0(s1)
    80003a26:	0094ca83          	lbu	s5,9(s1)
    80003a2a:	0104ba03          	ld	s4,16(s1)
    80003a2e:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003a32:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003a36:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003a3a:	00019517          	auipc	a0,0x19
    80003a3e:	92e50513          	addi	a0,a0,-1746 # 8001c368 <ftable>
    80003a42:	00003097          	auipc	ra,0x3
    80003a46:	8e0080e7          	jalr	-1824(ra) # 80006322 <release>

  if(ff.type == FD_PIPE){
    80003a4a:	4785                	li	a5,1
    80003a4c:	04f90463          	beq	s2,a5,80003a94 <fileclose+0xa4>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003a50:	3979                	addiw	s2,s2,-2
    80003a52:	4785                	li	a5,1
    80003a54:	0527fb63          	bgeu	a5,s2,80003aaa <fileclose+0xba>
    80003a58:	7902                	ld	s2,32(sp)
    80003a5a:	69e2                	ld	s3,24(sp)
    80003a5c:	6a42                	ld	s4,16(sp)
    80003a5e:	6aa2                	ld	s5,8(sp)
    80003a60:	a02d                	j	80003a8a <fileclose+0x9a>
    80003a62:	f04a                	sd	s2,32(sp)
    80003a64:	ec4e                	sd	s3,24(sp)
    80003a66:	e852                	sd	s4,16(sp)
    80003a68:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80003a6a:	00005517          	auipc	a0,0x5
    80003a6e:	b6e50513          	addi	a0,a0,-1170 # 800085d8 <etext+0x5d8>
    80003a72:	00002097          	auipc	ra,0x2
    80003a76:	280080e7          	jalr	640(ra) # 80005cf2 <panic>
    release(&ftable.lock);
    80003a7a:	00019517          	auipc	a0,0x19
    80003a7e:	8ee50513          	addi	a0,a0,-1810 # 8001c368 <ftable>
    80003a82:	00003097          	auipc	ra,0x3
    80003a86:	8a0080e7          	jalr	-1888(ra) # 80006322 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003a8a:	70e2                	ld	ra,56(sp)
    80003a8c:	7442                	ld	s0,48(sp)
    80003a8e:	74a2                	ld	s1,40(sp)
    80003a90:	6121                	addi	sp,sp,64
    80003a92:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003a94:	85d6                	mv	a1,s5
    80003a96:	8552                	mv	a0,s4
    80003a98:	00000097          	auipc	ra,0x0
    80003a9c:	3ac080e7          	jalr	940(ra) # 80003e44 <pipeclose>
    80003aa0:	7902                	ld	s2,32(sp)
    80003aa2:	69e2                	ld	s3,24(sp)
    80003aa4:	6a42                	ld	s4,16(sp)
    80003aa6:	6aa2                	ld	s5,8(sp)
    80003aa8:	b7cd                	j	80003a8a <fileclose+0x9a>
    begin_op();
    80003aaa:	00000097          	auipc	ra,0x0
    80003aae:	a76080e7          	jalr	-1418(ra) # 80003520 <begin_op>
    iput(ff.ip);
    80003ab2:	854e                	mv	a0,s3
    80003ab4:	fffff097          	auipc	ra,0xfffff
    80003ab8:	238080e7          	jalr	568(ra) # 80002cec <iput>
    end_op();
    80003abc:	00000097          	auipc	ra,0x0
    80003ac0:	ade080e7          	jalr	-1314(ra) # 8000359a <end_op>
    80003ac4:	7902                	ld	s2,32(sp)
    80003ac6:	69e2                	ld	s3,24(sp)
    80003ac8:	6a42                	ld	s4,16(sp)
    80003aca:	6aa2                	ld	s5,8(sp)
    80003acc:	bf7d                	j	80003a8a <fileclose+0x9a>

0000000080003ace <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003ace:	715d                	addi	sp,sp,-80
    80003ad0:	e486                	sd	ra,72(sp)
    80003ad2:	e0a2                	sd	s0,64(sp)
    80003ad4:	fc26                	sd	s1,56(sp)
    80003ad6:	f44e                	sd	s3,40(sp)
    80003ad8:	0880                	addi	s0,sp,80
    80003ada:	84aa                	mv	s1,a0
    80003adc:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003ade:	ffffd097          	auipc	ra,0xffffd
    80003ae2:	3c4080e7          	jalr	964(ra) # 80000ea2 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003ae6:	409c                	lw	a5,0(s1)
    80003ae8:	37f9                	addiw	a5,a5,-2
    80003aea:	4705                	li	a4,1
    80003aec:	04f76a63          	bltu	a4,a5,80003b40 <filestat+0x72>
    80003af0:	f84a                	sd	s2,48(sp)
    80003af2:	f052                	sd	s4,32(sp)
    80003af4:	892a                	mv	s2,a0
    ilock(f->ip);
    80003af6:	6c88                	ld	a0,24(s1)
    80003af8:	fffff097          	auipc	ra,0xfffff
    80003afc:	036080e7          	jalr	54(ra) # 80002b2e <ilock>
    stati(f->ip, &st);
    80003b00:	fb840a13          	addi	s4,s0,-72
    80003b04:	85d2                	mv	a1,s4
    80003b06:	6c88                	ld	a0,24(s1)
    80003b08:	fffff097          	auipc	ra,0xfffff
    80003b0c:	2b4080e7          	jalr	692(ra) # 80002dbc <stati>
    iunlock(f->ip);
    80003b10:	6c88                	ld	a0,24(s1)
    80003b12:	fffff097          	auipc	ra,0xfffff
    80003b16:	0e2080e7          	jalr	226(ra) # 80002bf4 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003b1a:	46e1                	li	a3,24
    80003b1c:	8652                	mv	a2,s4
    80003b1e:	85ce                	mv	a1,s3
    80003b20:	05093503          	ld	a0,80(s2)
    80003b24:	ffffd097          	auipc	ra,0xffffd
    80003b28:	02a080e7          	jalr	42(ra) # 80000b4e <copyout>
    80003b2c:	41f5551b          	sraiw	a0,a0,0x1f
    80003b30:	7942                	ld	s2,48(sp)
    80003b32:	7a02                	ld	s4,32(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003b34:	60a6                	ld	ra,72(sp)
    80003b36:	6406                	ld	s0,64(sp)
    80003b38:	74e2                	ld	s1,56(sp)
    80003b3a:	79a2                	ld	s3,40(sp)
    80003b3c:	6161                	addi	sp,sp,80
    80003b3e:	8082                	ret
  return -1;
    80003b40:	557d                	li	a0,-1
    80003b42:	bfcd                	j	80003b34 <filestat+0x66>

0000000080003b44 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003b44:	7179                	addi	sp,sp,-48
    80003b46:	f406                	sd	ra,40(sp)
    80003b48:	f022                	sd	s0,32(sp)
    80003b4a:	e84a                	sd	s2,16(sp)
    80003b4c:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003b4e:	00854783          	lbu	a5,8(a0)
    80003b52:	cbc5                	beqz	a5,80003c02 <fileread+0xbe>
    80003b54:	ec26                	sd	s1,24(sp)
    80003b56:	e44e                	sd	s3,8(sp)
    80003b58:	84aa                	mv	s1,a0
    80003b5a:	89ae                	mv	s3,a1
    80003b5c:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003b5e:	411c                	lw	a5,0(a0)
    80003b60:	4705                	li	a4,1
    80003b62:	04e78963          	beq	a5,a4,80003bb4 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003b66:	470d                	li	a4,3
    80003b68:	04e78f63          	beq	a5,a4,80003bc6 <fileread+0x82>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003b6c:	4709                	li	a4,2
    80003b6e:	08e79263          	bne	a5,a4,80003bf2 <fileread+0xae>
    ilock(f->ip);
    80003b72:	6d08                	ld	a0,24(a0)
    80003b74:	fffff097          	auipc	ra,0xfffff
    80003b78:	fba080e7          	jalr	-70(ra) # 80002b2e <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003b7c:	874a                	mv	a4,s2
    80003b7e:	5094                	lw	a3,32(s1)
    80003b80:	864e                	mv	a2,s3
    80003b82:	4585                	li	a1,1
    80003b84:	6c88                	ld	a0,24(s1)
    80003b86:	fffff097          	auipc	ra,0xfffff
    80003b8a:	264080e7          	jalr	612(ra) # 80002dea <readi>
    80003b8e:	892a                	mv	s2,a0
    80003b90:	00a05563          	blez	a0,80003b9a <fileread+0x56>
      f->off += r;
    80003b94:	509c                	lw	a5,32(s1)
    80003b96:	9fa9                	addw	a5,a5,a0
    80003b98:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003b9a:	6c88                	ld	a0,24(s1)
    80003b9c:	fffff097          	auipc	ra,0xfffff
    80003ba0:	058080e7          	jalr	88(ra) # 80002bf4 <iunlock>
    80003ba4:	64e2                	ld	s1,24(sp)
    80003ba6:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    80003ba8:	854a                	mv	a0,s2
    80003baa:	70a2                	ld	ra,40(sp)
    80003bac:	7402                	ld	s0,32(sp)
    80003bae:	6942                	ld	s2,16(sp)
    80003bb0:	6145                	addi	sp,sp,48
    80003bb2:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003bb4:	6908                	ld	a0,16(a0)
    80003bb6:	00000097          	auipc	ra,0x0
    80003bba:	414080e7          	jalr	1044(ra) # 80003fca <piperead>
    80003bbe:	892a                	mv	s2,a0
    80003bc0:	64e2                	ld	s1,24(sp)
    80003bc2:	69a2                	ld	s3,8(sp)
    80003bc4:	b7d5                	j	80003ba8 <fileread+0x64>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003bc6:	02451783          	lh	a5,36(a0)
    80003bca:	03079693          	slli	a3,a5,0x30
    80003bce:	92c1                	srli	a3,a3,0x30
    80003bd0:	4725                	li	a4,9
    80003bd2:	02d76a63          	bltu	a4,a3,80003c06 <fileread+0xc2>
    80003bd6:	0792                	slli	a5,a5,0x4
    80003bd8:	00018717          	auipc	a4,0x18
    80003bdc:	6f070713          	addi	a4,a4,1776 # 8001c2c8 <devsw>
    80003be0:	97ba                	add	a5,a5,a4
    80003be2:	639c                	ld	a5,0(a5)
    80003be4:	c78d                	beqz	a5,80003c0e <fileread+0xca>
    r = devsw[f->major].read(1, addr, n);
    80003be6:	4505                	li	a0,1
    80003be8:	9782                	jalr	a5
    80003bea:	892a                	mv	s2,a0
    80003bec:	64e2                	ld	s1,24(sp)
    80003bee:	69a2                	ld	s3,8(sp)
    80003bf0:	bf65                	j	80003ba8 <fileread+0x64>
    panic("fileread");
    80003bf2:	00005517          	auipc	a0,0x5
    80003bf6:	9f650513          	addi	a0,a0,-1546 # 800085e8 <etext+0x5e8>
    80003bfa:	00002097          	auipc	ra,0x2
    80003bfe:	0f8080e7          	jalr	248(ra) # 80005cf2 <panic>
    return -1;
    80003c02:	597d                	li	s2,-1
    80003c04:	b755                	j	80003ba8 <fileread+0x64>
      return -1;
    80003c06:	597d                	li	s2,-1
    80003c08:	64e2                	ld	s1,24(sp)
    80003c0a:	69a2                	ld	s3,8(sp)
    80003c0c:	bf71                	j	80003ba8 <fileread+0x64>
    80003c0e:	597d                	li	s2,-1
    80003c10:	64e2                	ld	s1,24(sp)
    80003c12:	69a2                	ld	s3,8(sp)
    80003c14:	bf51                	j	80003ba8 <fileread+0x64>

0000000080003c16 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003c16:	00954783          	lbu	a5,9(a0)
    80003c1a:	12078c63          	beqz	a5,80003d52 <filewrite+0x13c>
{
    80003c1e:	711d                	addi	sp,sp,-96
    80003c20:	ec86                	sd	ra,88(sp)
    80003c22:	e8a2                	sd	s0,80(sp)
    80003c24:	e0ca                	sd	s2,64(sp)
    80003c26:	f456                	sd	s5,40(sp)
    80003c28:	f05a                	sd	s6,32(sp)
    80003c2a:	1080                	addi	s0,sp,96
    80003c2c:	892a                	mv	s2,a0
    80003c2e:	8b2e                	mv	s6,a1
    80003c30:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003c32:	411c                	lw	a5,0(a0)
    80003c34:	4705                	li	a4,1
    80003c36:	02e78963          	beq	a5,a4,80003c68 <filewrite+0x52>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003c3a:	470d                	li	a4,3
    80003c3c:	02e78c63          	beq	a5,a4,80003c74 <filewrite+0x5e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003c40:	4709                	li	a4,2
    80003c42:	0ee79a63          	bne	a5,a4,80003d36 <filewrite+0x120>
    80003c46:	f852                	sd	s4,48(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003c48:	0cc05563          	blez	a2,80003d12 <filewrite+0xfc>
    80003c4c:	e4a6                	sd	s1,72(sp)
    80003c4e:	fc4e                	sd	s3,56(sp)
    80003c50:	ec5e                	sd	s7,24(sp)
    80003c52:	e862                	sd	s8,16(sp)
    80003c54:	e466                	sd	s9,8(sp)
    int i = 0;
    80003c56:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80003c58:	6b85                	lui	s7,0x1
    80003c5a:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003c5e:	6c85                	lui	s9,0x1
    80003c60:	c00c8c9b          	addiw	s9,s9,-1024 # c00 <_entry-0x7ffff400>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003c64:	4c05                	li	s8,1
    80003c66:	a849                	j	80003cf8 <filewrite+0xe2>
    ret = pipewrite(f->pipe, addr, n);
    80003c68:	6908                	ld	a0,16(a0)
    80003c6a:	00000097          	auipc	ra,0x0
    80003c6e:	24a080e7          	jalr	586(ra) # 80003eb4 <pipewrite>
    80003c72:	a85d                	j	80003d28 <filewrite+0x112>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003c74:	02451783          	lh	a5,36(a0)
    80003c78:	03079693          	slli	a3,a5,0x30
    80003c7c:	92c1                	srli	a3,a3,0x30
    80003c7e:	4725                	li	a4,9
    80003c80:	0cd76b63          	bltu	a4,a3,80003d56 <filewrite+0x140>
    80003c84:	0792                	slli	a5,a5,0x4
    80003c86:	00018717          	auipc	a4,0x18
    80003c8a:	64270713          	addi	a4,a4,1602 # 8001c2c8 <devsw>
    80003c8e:	97ba                	add	a5,a5,a4
    80003c90:	679c                	ld	a5,8(a5)
    80003c92:	c7e1                	beqz	a5,80003d5a <filewrite+0x144>
    ret = devsw[f->major].write(1, addr, n);
    80003c94:	4505                	li	a0,1
    80003c96:	9782                	jalr	a5
    80003c98:	a841                	j	80003d28 <filewrite+0x112>
      if(n1 > max)
    80003c9a:	2981                	sext.w	s3,s3
      begin_op();
    80003c9c:	00000097          	auipc	ra,0x0
    80003ca0:	884080e7          	jalr	-1916(ra) # 80003520 <begin_op>
      ilock(f->ip);
    80003ca4:	01893503          	ld	a0,24(s2)
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	e86080e7          	jalr	-378(ra) # 80002b2e <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003cb0:	874e                	mv	a4,s3
    80003cb2:	02092683          	lw	a3,32(s2)
    80003cb6:	016a0633          	add	a2,s4,s6
    80003cba:	85e2                	mv	a1,s8
    80003cbc:	01893503          	ld	a0,24(s2)
    80003cc0:	fffff097          	auipc	ra,0xfffff
    80003cc4:	224080e7          	jalr	548(ra) # 80002ee4 <writei>
    80003cc8:	84aa                	mv	s1,a0
    80003cca:	00a05763          	blez	a0,80003cd8 <filewrite+0xc2>
        f->off += r;
    80003cce:	02092783          	lw	a5,32(s2)
    80003cd2:	9fa9                	addw	a5,a5,a0
    80003cd4:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003cd8:	01893503          	ld	a0,24(s2)
    80003cdc:	fffff097          	auipc	ra,0xfffff
    80003ce0:	f18080e7          	jalr	-232(ra) # 80002bf4 <iunlock>
      end_op();
    80003ce4:	00000097          	auipc	ra,0x0
    80003ce8:	8b6080e7          	jalr	-1866(ra) # 8000359a <end_op>

      if(r != n1){
    80003cec:	02999563          	bne	s3,s1,80003d16 <filewrite+0x100>
        // error from writei
        break;
      }
      i += r;
    80003cf0:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    80003cf4:	015a5963          	bge	s4,s5,80003d06 <filewrite+0xf0>
      int n1 = n - i;
    80003cf8:	414a87bb          	subw	a5,s5,s4
    80003cfc:	89be                	mv	s3,a5
      if(n1 > max)
    80003cfe:	f8fbdee3          	bge	s7,a5,80003c9a <filewrite+0x84>
    80003d02:	89e6                	mv	s3,s9
    80003d04:	bf59                	j	80003c9a <filewrite+0x84>
    80003d06:	64a6                	ld	s1,72(sp)
    80003d08:	79e2                	ld	s3,56(sp)
    80003d0a:	6be2                	ld	s7,24(sp)
    80003d0c:	6c42                	ld	s8,16(sp)
    80003d0e:	6ca2                	ld	s9,8(sp)
    80003d10:	a801                	j	80003d20 <filewrite+0x10a>
    int i = 0;
    80003d12:	4a01                	li	s4,0
    80003d14:	a031                	j	80003d20 <filewrite+0x10a>
    80003d16:	64a6                	ld	s1,72(sp)
    80003d18:	79e2                	ld	s3,56(sp)
    80003d1a:	6be2                	ld	s7,24(sp)
    80003d1c:	6c42                	ld	s8,16(sp)
    80003d1e:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80003d20:	034a9f63          	bne	s5,s4,80003d5e <filewrite+0x148>
    80003d24:	8556                	mv	a0,s5
    80003d26:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003d28:	60e6                	ld	ra,88(sp)
    80003d2a:	6446                	ld	s0,80(sp)
    80003d2c:	6906                	ld	s2,64(sp)
    80003d2e:	7aa2                	ld	s5,40(sp)
    80003d30:	7b02                	ld	s6,32(sp)
    80003d32:	6125                	addi	sp,sp,96
    80003d34:	8082                	ret
    80003d36:	e4a6                	sd	s1,72(sp)
    80003d38:	fc4e                	sd	s3,56(sp)
    80003d3a:	f852                	sd	s4,48(sp)
    80003d3c:	ec5e                	sd	s7,24(sp)
    80003d3e:	e862                	sd	s8,16(sp)
    80003d40:	e466                	sd	s9,8(sp)
    panic("filewrite");
    80003d42:	00005517          	auipc	a0,0x5
    80003d46:	8b650513          	addi	a0,a0,-1866 # 800085f8 <etext+0x5f8>
    80003d4a:	00002097          	auipc	ra,0x2
    80003d4e:	fa8080e7          	jalr	-88(ra) # 80005cf2 <panic>
    return -1;
    80003d52:	557d                	li	a0,-1
}
    80003d54:	8082                	ret
      return -1;
    80003d56:	557d                	li	a0,-1
    80003d58:	bfc1                	j	80003d28 <filewrite+0x112>
    80003d5a:	557d                	li	a0,-1
    80003d5c:	b7f1                	j	80003d28 <filewrite+0x112>
    ret = (i == n ? n : -1);
    80003d5e:	557d                	li	a0,-1
    80003d60:	7a42                	ld	s4,48(sp)
    80003d62:	b7d9                	j	80003d28 <filewrite+0x112>

0000000080003d64 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003d64:	7179                	addi	sp,sp,-48
    80003d66:	f406                	sd	ra,40(sp)
    80003d68:	f022                	sd	s0,32(sp)
    80003d6a:	ec26                	sd	s1,24(sp)
    80003d6c:	e052                	sd	s4,0(sp)
    80003d6e:	1800                	addi	s0,sp,48
    80003d70:	84aa                	mv	s1,a0
    80003d72:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003d74:	0005b023          	sd	zero,0(a1)
    80003d78:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003d7c:	00000097          	auipc	ra,0x0
    80003d80:	bb8080e7          	jalr	-1096(ra) # 80003934 <filealloc>
    80003d84:	e088                	sd	a0,0(s1)
    80003d86:	cd49                	beqz	a0,80003e20 <pipealloc+0xbc>
    80003d88:	00000097          	auipc	ra,0x0
    80003d8c:	bac080e7          	jalr	-1108(ra) # 80003934 <filealloc>
    80003d90:	00aa3023          	sd	a0,0(s4)
    80003d94:	c141                	beqz	a0,80003e14 <pipealloc+0xb0>
    80003d96:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003d98:	ffffc097          	auipc	ra,0xffffc
    80003d9c:	382080e7          	jalr	898(ra) # 8000011a <kalloc>
    80003da0:	892a                	mv	s2,a0
    80003da2:	c13d                	beqz	a0,80003e08 <pipealloc+0xa4>
    80003da4:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003da6:	4985                	li	s3,1
    80003da8:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003dac:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003db0:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003db4:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003db8:	00004597          	auipc	a1,0x4
    80003dbc:	5f858593          	addi	a1,a1,1528 # 800083b0 <etext+0x3b0>
    80003dc0:	00002097          	auipc	ra,0x2
    80003dc4:	41e080e7          	jalr	1054(ra) # 800061de <initlock>
  (*f0)->type = FD_PIPE;
    80003dc8:	609c                	ld	a5,0(s1)
    80003dca:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003dce:	609c                	ld	a5,0(s1)
    80003dd0:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003dd4:	609c                	ld	a5,0(s1)
    80003dd6:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003dda:	609c                	ld	a5,0(s1)
    80003ddc:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003de0:	000a3783          	ld	a5,0(s4)
    80003de4:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003de8:	000a3783          	ld	a5,0(s4)
    80003dec:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003df0:	000a3783          	ld	a5,0(s4)
    80003df4:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003df8:	000a3783          	ld	a5,0(s4)
    80003dfc:	0127b823          	sd	s2,16(a5)
  return 0;
    80003e00:	4501                	li	a0,0
    80003e02:	6942                	ld	s2,16(sp)
    80003e04:	69a2                	ld	s3,8(sp)
    80003e06:	a03d                	j	80003e34 <pipealloc+0xd0>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003e08:	6088                	ld	a0,0(s1)
    80003e0a:	c119                	beqz	a0,80003e10 <pipealloc+0xac>
    80003e0c:	6942                	ld	s2,16(sp)
    80003e0e:	a029                	j	80003e18 <pipealloc+0xb4>
    80003e10:	6942                	ld	s2,16(sp)
    80003e12:	a039                	j	80003e20 <pipealloc+0xbc>
    80003e14:	6088                	ld	a0,0(s1)
    80003e16:	c50d                	beqz	a0,80003e40 <pipealloc+0xdc>
    fileclose(*f0);
    80003e18:	00000097          	auipc	ra,0x0
    80003e1c:	bd8080e7          	jalr	-1064(ra) # 800039f0 <fileclose>
  if(*f1)
    80003e20:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003e24:	557d                	li	a0,-1
  if(*f1)
    80003e26:	c799                	beqz	a5,80003e34 <pipealloc+0xd0>
    fileclose(*f1);
    80003e28:	853e                	mv	a0,a5
    80003e2a:	00000097          	auipc	ra,0x0
    80003e2e:	bc6080e7          	jalr	-1082(ra) # 800039f0 <fileclose>
  return -1;
    80003e32:	557d                	li	a0,-1
}
    80003e34:	70a2                	ld	ra,40(sp)
    80003e36:	7402                	ld	s0,32(sp)
    80003e38:	64e2                	ld	s1,24(sp)
    80003e3a:	6a02                	ld	s4,0(sp)
    80003e3c:	6145                	addi	sp,sp,48
    80003e3e:	8082                	ret
  return -1;
    80003e40:	557d                	li	a0,-1
    80003e42:	bfcd                	j	80003e34 <pipealloc+0xd0>

0000000080003e44 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003e44:	1101                	addi	sp,sp,-32
    80003e46:	ec06                	sd	ra,24(sp)
    80003e48:	e822                	sd	s0,16(sp)
    80003e4a:	e426                	sd	s1,8(sp)
    80003e4c:	e04a                	sd	s2,0(sp)
    80003e4e:	1000                	addi	s0,sp,32
    80003e50:	84aa                	mv	s1,a0
    80003e52:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003e54:	00002097          	auipc	ra,0x2
    80003e58:	41e080e7          	jalr	1054(ra) # 80006272 <acquire>
  if(writable){
    80003e5c:	02090d63          	beqz	s2,80003e96 <pipeclose+0x52>
    pi->writeopen = 0;
    80003e60:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003e64:	21848513          	addi	a0,s1,536
    80003e68:	ffffe097          	auipc	ra,0xffffe
    80003e6c:	892080e7          	jalr	-1902(ra) # 800016fa <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003e70:	2204b783          	ld	a5,544(s1)
    80003e74:	eb95                	bnez	a5,80003ea8 <pipeclose+0x64>
    release(&pi->lock);
    80003e76:	8526                	mv	a0,s1
    80003e78:	00002097          	auipc	ra,0x2
    80003e7c:	4aa080e7          	jalr	1194(ra) # 80006322 <release>
    kfree((char*)pi);
    80003e80:	8526                	mv	a0,s1
    80003e82:	ffffc097          	auipc	ra,0xffffc
    80003e86:	19a080e7          	jalr	410(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003e8a:	60e2                	ld	ra,24(sp)
    80003e8c:	6442                	ld	s0,16(sp)
    80003e8e:	64a2                	ld	s1,8(sp)
    80003e90:	6902                	ld	s2,0(sp)
    80003e92:	6105                	addi	sp,sp,32
    80003e94:	8082                	ret
    pi->readopen = 0;
    80003e96:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003e9a:	21c48513          	addi	a0,s1,540
    80003e9e:	ffffe097          	auipc	ra,0xffffe
    80003ea2:	85c080e7          	jalr	-1956(ra) # 800016fa <wakeup>
    80003ea6:	b7e9                	j	80003e70 <pipeclose+0x2c>
    release(&pi->lock);
    80003ea8:	8526                	mv	a0,s1
    80003eaa:	00002097          	auipc	ra,0x2
    80003eae:	478080e7          	jalr	1144(ra) # 80006322 <release>
}
    80003eb2:	bfe1                	j	80003e8a <pipeclose+0x46>

0000000080003eb4 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003eb4:	7159                	addi	sp,sp,-112
    80003eb6:	f486                	sd	ra,104(sp)
    80003eb8:	f0a2                	sd	s0,96(sp)
    80003eba:	eca6                	sd	s1,88(sp)
    80003ebc:	e8ca                	sd	s2,80(sp)
    80003ebe:	e4ce                	sd	s3,72(sp)
    80003ec0:	e0d2                	sd	s4,64(sp)
    80003ec2:	fc56                	sd	s5,56(sp)
    80003ec4:	1880                	addi	s0,sp,112
    80003ec6:	84aa                	mv	s1,a0
    80003ec8:	8aae                	mv	s5,a1
    80003eca:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003ecc:	ffffd097          	auipc	ra,0xffffd
    80003ed0:	fd6080e7          	jalr	-42(ra) # 80000ea2 <myproc>
    80003ed4:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003ed6:	8526                	mv	a0,s1
    80003ed8:	00002097          	auipc	ra,0x2
    80003edc:	39a080e7          	jalr	922(ra) # 80006272 <acquire>
  while(i < n){
    80003ee0:	0d405d63          	blez	s4,80003fba <pipewrite+0x106>
    80003ee4:	f85a                	sd	s6,48(sp)
    80003ee6:	f45e                	sd	s7,40(sp)
    80003ee8:	f062                	sd	s8,32(sp)
    80003eea:	ec66                	sd	s9,24(sp)
    80003eec:	e86a                	sd	s10,16(sp)
  int i = 0;
    80003eee:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003ef0:	f9f40c13          	addi	s8,s0,-97
    80003ef4:	4b85                	li	s7,1
    80003ef6:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003ef8:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003efc:	21c48c93          	addi	s9,s1,540
    80003f00:	a099                	j	80003f46 <pipewrite+0x92>
      release(&pi->lock);
    80003f02:	8526                	mv	a0,s1
    80003f04:	00002097          	auipc	ra,0x2
    80003f08:	41e080e7          	jalr	1054(ra) # 80006322 <release>
      return -1;
    80003f0c:	597d                	li	s2,-1
    80003f0e:	7b42                	ld	s6,48(sp)
    80003f10:	7ba2                	ld	s7,40(sp)
    80003f12:	7c02                	ld	s8,32(sp)
    80003f14:	6ce2                	ld	s9,24(sp)
    80003f16:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003f18:	854a                	mv	a0,s2
    80003f1a:	70a6                	ld	ra,104(sp)
    80003f1c:	7406                	ld	s0,96(sp)
    80003f1e:	64e6                	ld	s1,88(sp)
    80003f20:	6946                	ld	s2,80(sp)
    80003f22:	69a6                	ld	s3,72(sp)
    80003f24:	6a06                	ld	s4,64(sp)
    80003f26:	7ae2                	ld	s5,56(sp)
    80003f28:	6165                	addi	sp,sp,112
    80003f2a:	8082                	ret
      wakeup(&pi->nread);
    80003f2c:	856a                	mv	a0,s10
    80003f2e:	ffffd097          	auipc	ra,0xffffd
    80003f32:	7cc080e7          	jalr	1996(ra) # 800016fa <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003f36:	85a6                	mv	a1,s1
    80003f38:	8566                	mv	a0,s9
    80003f3a:	ffffd097          	auipc	ra,0xffffd
    80003f3e:	63a080e7          	jalr	1594(ra) # 80001574 <sleep>
  while(i < n){
    80003f42:	05495b63          	bge	s2,s4,80003f98 <pipewrite+0xe4>
    if(pi->readopen == 0 || pr->killed){
    80003f46:	2204a783          	lw	a5,544(s1)
    80003f4a:	dfc5                	beqz	a5,80003f02 <pipewrite+0x4e>
    80003f4c:	0289a783          	lw	a5,40(s3)
    80003f50:	fbcd                	bnez	a5,80003f02 <pipewrite+0x4e>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003f52:	2184a783          	lw	a5,536(s1)
    80003f56:	21c4a703          	lw	a4,540(s1)
    80003f5a:	2007879b          	addiw	a5,a5,512
    80003f5e:	fcf707e3          	beq	a4,a5,80003f2c <pipewrite+0x78>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f62:	86de                	mv	a3,s7
    80003f64:	01590633          	add	a2,s2,s5
    80003f68:	85e2                	mv	a1,s8
    80003f6a:	0509b503          	ld	a0,80(s3)
    80003f6e:	ffffd097          	auipc	ra,0xffffd
    80003f72:	c6c080e7          	jalr	-916(ra) # 80000bda <copyin>
    80003f76:	05650463          	beq	a0,s6,80003fbe <pipewrite+0x10a>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003f7a:	21c4a783          	lw	a5,540(s1)
    80003f7e:	0017871b          	addiw	a4,a5,1
    80003f82:	20e4ae23          	sw	a4,540(s1)
    80003f86:	1ff7f793          	andi	a5,a5,511
    80003f8a:	97a6                	add	a5,a5,s1
    80003f8c:	f9f44703          	lbu	a4,-97(s0)
    80003f90:	00e78c23          	sb	a4,24(a5)
      i++;
    80003f94:	2905                	addiw	s2,s2,1
    80003f96:	b775                	j	80003f42 <pipewrite+0x8e>
    80003f98:	7b42                	ld	s6,48(sp)
    80003f9a:	7ba2                	ld	s7,40(sp)
    80003f9c:	7c02                	ld	s8,32(sp)
    80003f9e:	6ce2                	ld	s9,24(sp)
    80003fa0:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    80003fa2:	21848513          	addi	a0,s1,536
    80003fa6:	ffffd097          	auipc	ra,0xffffd
    80003faa:	754080e7          	jalr	1876(ra) # 800016fa <wakeup>
  release(&pi->lock);
    80003fae:	8526                	mv	a0,s1
    80003fb0:	00002097          	auipc	ra,0x2
    80003fb4:	372080e7          	jalr	882(ra) # 80006322 <release>
  return i;
    80003fb8:	b785                	j	80003f18 <pipewrite+0x64>
  int i = 0;
    80003fba:	4901                	li	s2,0
    80003fbc:	b7dd                	j	80003fa2 <pipewrite+0xee>
    80003fbe:	7b42                	ld	s6,48(sp)
    80003fc0:	7ba2                	ld	s7,40(sp)
    80003fc2:	7c02                	ld	s8,32(sp)
    80003fc4:	6ce2                	ld	s9,24(sp)
    80003fc6:	6d42                	ld	s10,16(sp)
    80003fc8:	bfe9                	j	80003fa2 <pipewrite+0xee>

0000000080003fca <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003fca:	711d                	addi	sp,sp,-96
    80003fcc:	ec86                	sd	ra,88(sp)
    80003fce:	e8a2                	sd	s0,80(sp)
    80003fd0:	e4a6                	sd	s1,72(sp)
    80003fd2:	e0ca                	sd	s2,64(sp)
    80003fd4:	fc4e                	sd	s3,56(sp)
    80003fd6:	f852                	sd	s4,48(sp)
    80003fd8:	f456                	sd	s5,40(sp)
    80003fda:	1080                	addi	s0,sp,96
    80003fdc:	84aa                	mv	s1,a0
    80003fde:	892e                	mv	s2,a1
    80003fe0:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003fe2:	ffffd097          	auipc	ra,0xffffd
    80003fe6:	ec0080e7          	jalr	-320(ra) # 80000ea2 <myproc>
    80003fea:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003fec:	8526                	mv	a0,s1
    80003fee:	00002097          	auipc	ra,0x2
    80003ff2:	284080e7          	jalr	644(ra) # 80006272 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003ff6:	2184a703          	lw	a4,536(s1)
    80003ffa:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003ffe:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004002:	02f71863          	bne	a4,a5,80004032 <piperead+0x68>
    80004006:	2244a783          	lw	a5,548(s1)
    8000400a:	cf9d                	beqz	a5,80004048 <piperead+0x7e>
    if(pr->killed){
    8000400c:	028a2783          	lw	a5,40(s4)
    80004010:	e78d                	bnez	a5,8000403a <piperead+0x70>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004012:	85a6                	mv	a1,s1
    80004014:	854e                	mv	a0,s3
    80004016:	ffffd097          	auipc	ra,0xffffd
    8000401a:	55e080e7          	jalr	1374(ra) # 80001574 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000401e:	2184a703          	lw	a4,536(s1)
    80004022:	21c4a783          	lw	a5,540(s1)
    80004026:	fef700e3          	beq	a4,a5,80004006 <piperead+0x3c>
    8000402a:	f05a                	sd	s6,32(sp)
    8000402c:	ec5e                	sd	s7,24(sp)
    8000402e:	e862                	sd	s8,16(sp)
    80004030:	a839                	j	8000404e <piperead+0x84>
    80004032:	f05a                	sd	s6,32(sp)
    80004034:	ec5e                	sd	s7,24(sp)
    80004036:	e862                	sd	s8,16(sp)
    80004038:	a819                	j	8000404e <piperead+0x84>
      release(&pi->lock);
    8000403a:	8526                	mv	a0,s1
    8000403c:	00002097          	auipc	ra,0x2
    80004040:	2e6080e7          	jalr	742(ra) # 80006322 <release>
      return -1;
    80004044:	59fd                	li	s3,-1
    80004046:	a895                	j	800040ba <piperead+0xf0>
    80004048:	f05a                	sd	s6,32(sp)
    8000404a:	ec5e                	sd	s7,24(sp)
    8000404c:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000404e:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004050:	faf40c13          	addi	s8,s0,-81
    80004054:	4b85                	li	s7,1
    80004056:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004058:	05505363          	blez	s5,8000409e <piperead+0xd4>
    if(pi->nread == pi->nwrite)
    8000405c:	2184a783          	lw	a5,536(s1)
    80004060:	21c4a703          	lw	a4,540(s1)
    80004064:	02f70d63          	beq	a4,a5,8000409e <piperead+0xd4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004068:	0017871b          	addiw	a4,a5,1
    8000406c:	20e4ac23          	sw	a4,536(s1)
    80004070:	1ff7f793          	andi	a5,a5,511
    80004074:	97a6                	add	a5,a5,s1
    80004076:	0187c783          	lbu	a5,24(a5)
    8000407a:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000407e:	86de                	mv	a3,s7
    80004080:	8662                	mv	a2,s8
    80004082:	85ca                	mv	a1,s2
    80004084:	050a3503          	ld	a0,80(s4)
    80004088:	ffffd097          	auipc	ra,0xffffd
    8000408c:	ac6080e7          	jalr	-1338(ra) # 80000b4e <copyout>
    80004090:	01650763          	beq	a0,s6,8000409e <piperead+0xd4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004094:	2985                	addiw	s3,s3,1
    80004096:	0905                	addi	s2,s2,1
    80004098:	fd3a92e3          	bne	s5,s3,8000405c <piperead+0x92>
    8000409c:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000409e:	21c48513          	addi	a0,s1,540
    800040a2:	ffffd097          	auipc	ra,0xffffd
    800040a6:	658080e7          	jalr	1624(ra) # 800016fa <wakeup>
  release(&pi->lock);
    800040aa:	8526                	mv	a0,s1
    800040ac:	00002097          	auipc	ra,0x2
    800040b0:	276080e7          	jalr	630(ra) # 80006322 <release>
    800040b4:	7b02                	ld	s6,32(sp)
    800040b6:	6be2                	ld	s7,24(sp)
    800040b8:	6c42                	ld	s8,16(sp)
  return i;
}
    800040ba:	854e                	mv	a0,s3
    800040bc:	60e6                	ld	ra,88(sp)
    800040be:	6446                	ld	s0,80(sp)
    800040c0:	64a6                	ld	s1,72(sp)
    800040c2:	6906                	ld	s2,64(sp)
    800040c4:	79e2                	ld	s3,56(sp)
    800040c6:	7a42                	ld	s4,48(sp)
    800040c8:	7aa2                	ld	s5,40(sp)
    800040ca:	6125                	addi	sp,sp,96
    800040cc:	8082                	ret

00000000800040ce <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800040ce:	de010113          	addi	sp,sp,-544
    800040d2:	20113c23          	sd	ra,536(sp)
    800040d6:	20813823          	sd	s0,528(sp)
    800040da:	20913423          	sd	s1,520(sp)
    800040de:	21213023          	sd	s2,512(sp)
    800040e2:	1400                	addi	s0,sp,544
    800040e4:	892a                	mv	s2,a0
    800040e6:	dea43823          	sd	a0,-528(s0)
    800040ea:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800040ee:	ffffd097          	auipc	ra,0xffffd
    800040f2:	db4080e7          	jalr	-588(ra) # 80000ea2 <myproc>
    800040f6:	84aa                	mv	s1,a0

  begin_op();
    800040f8:	fffff097          	auipc	ra,0xfffff
    800040fc:	428080e7          	jalr	1064(ra) # 80003520 <begin_op>

  if((ip = namei(path)) == 0){
    80004100:	854a                	mv	a0,s2
    80004102:	fffff097          	auipc	ra,0xfffff
    80004106:	218080e7          	jalr	536(ra) # 8000331a <namei>
    8000410a:	c525                	beqz	a0,80004172 <exec+0xa4>
    8000410c:	fbd2                	sd	s4,496(sp)
    8000410e:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004110:	fffff097          	auipc	ra,0xfffff
    80004114:	a1e080e7          	jalr	-1506(ra) # 80002b2e <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004118:	04000713          	li	a4,64
    8000411c:	4681                	li	a3,0
    8000411e:	e5040613          	addi	a2,s0,-432
    80004122:	4581                	li	a1,0
    80004124:	8552                	mv	a0,s4
    80004126:	fffff097          	auipc	ra,0xfffff
    8000412a:	cc4080e7          	jalr	-828(ra) # 80002dea <readi>
    8000412e:	04000793          	li	a5,64
    80004132:	00f51a63          	bne	a0,a5,80004146 <exec+0x78>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004136:	e5042703          	lw	a4,-432(s0)
    8000413a:	464c47b7          	lui	a5,0x464c4
    8000413e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004142:	02f70e63          	beq	a4,a5,8000417e <exec+0xb0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004146:	8552                	mv	a0,s4
    80004148:	fffff097          	auipc	ra,0xfffff
    8000414c:	c4c080e7          	jalr	-948(ra) # 80002d94 <iunlockput>
    end_op();
    80004150:	fffff097          	auipc	ra,0xfffff
    80004154:	44a080e7          	jalr	1098(ra) # 8000359a <end_op>
  }
  return -1;
    80004158:	557d                	li	a0,-1
    8000415a:	7a5e                	ld	s4,496(sp)
}
    8000415c:	21813083          	ld	ra,536(sp)
    80004160:	21013403          	ld	s0,528(sp)
    80004164:	20813483          	ld	s1,520(sp)
    80004168:	20013903          	ld	s2,512(sp)
    8000416c:	22010113          	addi	sp,sp,544
    80004170:	8082                	ret
    end_op();
    80004172:	fffff097          	auipc	ra,0xfffff
    80004176:	428080e7          	jalr	1064(ra) # 8000359a <end_op>
    return -1;
    8000417a:	557d                	li	a0,-1
    8000417c:	b7c5                	j	8000415c <exec+0x8e>
    8000417e:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80004180:	8526                	mv	a0,s1
    80004182:	ffffd097          	auipc	ra,0xffffd
    80004186:	de4080e7          	jalr	-540(ra) # 80000f66 <proc_pagetable>
    8000418a:	8b2a                	mv	s6,a0
    8000418c:	2a050863          	beqz	a0,8000443c <exec+0x36e>
    80004190:	ffce                	sd	s3,504(sp)
    80004192:	f7d6                	sd	s5,488(sp)
    80004194:	efde                	sd	s7,472(sp)
    80004196:	ebe2                	sd	s8,464(sp)
    80004198:	e7e6                	sd	s9,456(sp)
    8000419a:	e3ea                	sd	s10,448(sp)
    8000419c:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000419e:	e7042683          	lw	a3,-400(s0)
    800041a2:	e8845783          	lhu	a5,-376(s0)
    800041a6:	cbfd                	beqz	a5,8000429c <exec+0x1ce>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800041a8:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800041aa:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800041ac:	03800d93          	li	s11,56
    if((ph.vaddr % PGSIZE) != 0)
    800041b0:	6c85                	lui	s9,0x1
    800041b2:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800041b6:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    800041ba:	6a85                	lui	s5,0x1
    800041bc:	a0b5                	j	80004228 <exec+0x15a>
      panic("loadseg: address should exist");
    800041be:	00004517          	auipc	a0,0x4
    800041c2:	44a50513          	addi	a0,a0,1098 # 80008608 <etext+0x608>
    800041c6:	00002097          	auipc	ra,0x2
    800041ca:	b2c080e7          	jalr	-1236(ra) # 80005cf2 <panic>
    if(sz - i < PGSIZE)
    800041ce:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800041d0:	874a                	mv	a4,s2
    800041d2:	009c06bb          	addw	a3,s8,s1
    800041d6:	4581                	li	a1,0
    800041d8:	8552                	mv	a0,s4
    800041da:	fffff097          	auipc	ra,0xfffff
    800041de:	c10080e7          	jalr	-1008(ra) # 80002dea <readi>
    800041e2:	26a91163          	bne	s2,a0,80004444 <exec+0x376>
  for(i = 0; i < sz; i += PGSIZE){
    800041e6:	009a84bb          	addw	s1,s5,s1
    800041ea:	0334f463          	bgeu	s1,s3,80004212 <exec+0x144>
    pa = walkaddr(pagetable, va + i);
    800041ee:	02049593          	slli	a1,s1,0x20
    800041f2:	9181                	srli	a1,a1,0x20
    800041f4:	95de                	add	a1,a1,s7
    800041f6:	855a                	mv	a0,s6
    800041f8:	ffffc097          	auipc	ra,0xffffc
    800041fc:	320080e7          	jalr	800(ra) # 80000518 <walkaddr>
    80004200:	862a                	mv	a2,a0
    if(pa == 0)
    80004202:	dd55                	beqz	a0,800041be <exec+0xf0>
    if(sz - i < PGSIZE)
    80004204:	409987bb          	subw	a5,s3,s1
    80004208:	893e                	mv	s2,a5
    8000420a:	fcfcf2e3          	bgeu	s9,a5,800041ce <exec+0x100>
    8000420e:	8956                	mv	s2,s5
    80004210:	bf7d                	j	800041ce <exec+0x100>
    sz = sz1;
    80004212:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004216:	2d05                	addiw	s10,s10,1
    80004218:	e0843783          	ld	a5,-504(s0)
    8000421c:	0387869b          	addiw	a3,a5,56
    80004220:	e8845783          	lhu	a5,-376(s0)
    80004224:	06fd5d63          	bge	s10,a5,8000429e <exec+0x1d0>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004228:	e0d43423          	sd	a3,-504(s0)
    8000422c:	876e                	mv	a4,s11
    8000422e:	e1840613          	addi	a2,s0,-488
    80004232:	4581                	li	a1,0
    80004234:	8552                	mv	a0,s4
    80004236:	fffff097          	auipc	ra,0xfffff
    8000423a:	bb4080e7          	jalr	-1100(ra) # 80002dea <readi>
    8000423e:	21b51163          	bne	a0,s11,80004440 <exec+0x372>
    if(ph.type != ELF_PROG_LOAD)
    80004242:	e1842783          	lw	a5,-488(s0)
    80004246:	4705                	li	a4,1
    80004248:	fce797e3          	bne	a5,a4,80004216 <exec+0x148>
    if(ph.memsz < ph.filesz)
    8000424c:	e4043603          	ld	a2,-448(s0)
    80004250:	e3843783          	ld	a5,-456(s0)
    80004254:	20f66863          	bltu	a2,a5,80004464 <exec+0x396>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004258:	e2843783          	ld	a5,-472(s0)
    8000425c:	963e                	add	a2,a2,a5
    8000425e:	20f66663          	bltu	a2,a5,8000446a <exec+0x39c>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004262:	85a6                	mv	a1,s1
    80004264:	855a                	mv	a0,s6
    80004266:	ffffc097          	auipc	ra,0xffffc
    8000426a:	676080e7          	jalr	1654(ra) # 800008dc <uvmalloc>
    8000426e:	dea43c23          	sd	a0,-520(s0)
    80004272:	1e050f63          	beqz	a0,80004470 <exec+0x3a2>
    if((ph.vaddr % PGSIZE) != 0)
    80004276:	e2843b83          	ld	s7,-472(s0)
    8000427a:	de843783          	ld	a5,-536(s0)
    8000427e:	00fbf7b3          	and	a5,s7,a5
    80004282:	1c079163          	bnez	a5,80004444 <exec+0x376>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004286:	e2042c03          	lw	s8,-480(s0)
    8000428a:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8000428e:	00098463          	beqz	s3,80004296 <exec+0x1c8>
    80004292:	4481                	li	s1,0
    80004294:	bfa9                	j	800041ee <exec+0x120>
    sz = sz1;
    80004296:	df843483          	ld	s1,-520(s0)
    8000429a:	bfb5                	j	80004216 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    8000429c:	4481                	li	s1,0
  iunlockput(ip);
    8000429e:	8552                	mv	a0,s4
    800042a0:	fffff097          	auipc	ra,0xfffff
    800042a4:	af4080e7          	jalr	-1292(ra) # 80002d94 <iunlockput>
  end_op();
    800042a8:	fffff097          	auipc	ra,0xfffff
    800042ac:	2f2080e7          	jalr	754(ra) # 8000359a <end_op>
  p = myproc();
    800042b0:	ffffd097          	auipc	ra,0xffffd
    800042b4:	bf2080e7          	jalr	-1038(ra) # 80000ea2 <myproc>
    800042b8:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800042ba:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800042be:	6985                	lui	s3,0x1
    800042c0:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    800042c2:	99a6                	add	s3,s3,s1
    800042c4:	77fd                	lui	a5,0xfffff
    800042c6:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800042ca:	6609                	lui	a2,0x2
    800042cc:	964e                	add	a2,a2,s3
    800042ce:	85ce                	mv	a1,s3
    800042d0:	855a                	mv	a0,s6
    800042d2:	ffffc097          	auipc	ra,0xffffc
    800042d6:	60a080e7          	jalr	1546(ra) # 800008dc <uvmalloc>
    800042da:	8a2a                	mv	s4,a0
    800042dc:	e115                	bnez	a0,80004300 <exec+0x232>
    proc_freepagetable(pagetable, sz);
    800042de:	85ce                	mv	a1,s3
    800042e0:	855a                	mv	a0,s6
    800042e2:	ffffd097          	auipc	ra,0xffffd
    800042e6:	d20080e7          	jalr	-736(ra) # 80001002 <proc_freepagetable>
  return -1;
    800042ea:	557d                	li	a0,-1
    800042ec:	79fe                	ld	s3,504(sp)
    800042ee:	7a5e                	ld	s4,496(sp)
    800042f0:	7abe                	ld	s5,488(sp)
    800042f2:	7b1e                	ld	s6,480(sp)
    800042f4:	6bfe                	ld	s7,472(sp)
    800042f6:	6c5e                	ld	s8,464(sp)
    800042f8:	6cbe                	ld	s9,456(sp)
    800042fa:	6d1e                	ld	s10,448(sp)
    800042fc:	7dfa                	ld	s11,440(sp)
    800042fe:	bdb9                	j	8000415c <exec+0x8e>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004300:	75f9                	lui	a1,0xffffe
    80004302:	95aa                	add	a1,a1,a0
    80004304:	855a                	mv	a0,s6
    80004306:	ffffd097          	auipc	ra,0xffffd
    8000430a:	816080e7          	jalr	-2026(ra) # 80000b1c <uvmclear>
  stackbase = sp - PGSIZE;
    8000430e:	7bfd                	lui	s7,0xfffff
    80004310:	9bd2                	add	s7,s7,s4
  for(argc = 0; argv[argc]; argc++) {
    80004312:	e0043783          	ld	a5,-512(s0)
    80004316:	6388                	ld	a0,0(a5)
  sp = sz;
    80004318:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    8000431a:	4481                	li	s1,0
    ustack[argc] = sp;
    8000431c:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80004320:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    80004324:	c135                	beqz	a0,80004388 <exec+0x2ba>
    sp -= strlen(argv[argc]) + 1;
    80004326:	ffffc097          	auipc	ra,0xffffc
    8000432a:	fe0080e7          	jalr	-32(ra) # 80000306 <strlen>
    8000432e:	0015079b          	addiw	a5,a0,1
    80004332:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004336:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    8000433a:	13796e63          	bltu	s2,s7,80004476 <exec+0x3a8>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000433e:	e0043d83          	ld	s11,-512(s0)
    80004342:	000db983          	ld	s3,0(s11)
    80004346:	854e                	mv	a0,s3
    80004348:	ffffc097          	auipc	ra,0xffffc
    8000434c:	fbe080e7          	jalr	-66(ra) # 80000306 <strlen>
    80004350:	0015069b          	addiw	a3,a0,1
    80004354:	864e                	mv	a2,s3
    80004356:	85ca                	mv	a1,s2
    80004358:	855a                	mv	a0,s6
    8000435a:	ffffc097          	auipc	ra,0xffffc
    8000435e:	7f4080e7          	jalr	2036(ra) # 80000b4e <copyout>
    80004362:	10054c63          	bltz	a0,8000447a <exec+0x3ac>
    ustack[argc] = sp;
    80004366:	00349793          	slli	a5,s1,0x3
    8000436a:	97e6                	add	a5,a5,s9
    8000436c:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffd5dc0>
  for(argc = 0; argv[argc]; argc++) {
    80004370:	0485                	addi	s1,s1,1
    80004372:	008d8793          	addi	a5,s11,8
    80004376:	e0f43023          	sd	a5,-512(s0)
    8000437a:	008db503          	ld	a0,8(s11)
    8000437e:	c509                	beqz	a0,80004388 <exec+0x2ba>
    if(argc >= MAXARG)
    80004380:	fb8493e3          	bne	s1,s8,80004326 <exec+0x258>
  sz = sz1;
    80004384:	89d2                	mv	s3,s4
    80004386:	bfa1                	j	800042de <exec+0x210>
  ustack[argc] = 0;
    80004388:	00349793          	slli	a5,s1,0x3
    8000438c:	f9078793          	addi	a5,a5,-112
    80004390:	97a2                	add	a5,a5,s0
    80004392:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004396:	00148693          	addi	a3,s1,1
    8000439a:	068e                	slli	a3,a3,0x3
    8000439c:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800043a0:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    800043a4:	89d2                	mv	s3,s4
  if(sp < stackbase)
    800043a6:	f3796ce3          	bltu	s2,s7,800042de <exec+0x210>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800043aa:	e9040613          	addi	a2,s0,-368
    800043ae:	85ca                	mv	a1,s2
    800043b0:	855a                	mv	a0,s6
    800043b2:	ffffc097          	auipc	ra,0xffffc
    800043b6:	79c080e7          	jalr	1948(ra) # 80000b4e <copyout>
    800043ba:	f20542e3          	bltz	a0,800042de <exec+0x210>
  p->trapframe->a1 = sp;
    800043be:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    800043c2:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800043c6:	df043783          	ld	a5,-528(s0)
    800043ca:	0007c703          	lbu	a4,0(a5)
    800043ce:	cf11                	beqz	a4,800043ea <exec+0x31c>
    800043d0:	0785                	addi	a5,a5,1
    if(*s == '/')
    800043d2:	02f00693          	li	a3,47
    800043d6:	a029                	j	800043e0 <exec+0x312>
  for(last=s=path; *s; s++)
    800043d8:	0785                	addi	a5,a5,1
    800043da:	fff7c703          	lbu	a4,-1(a5)
    800043de:	c711                	beqz	a4,800043ea <exec+0x31c>
    if(*s == '/')
    800043e0:	fed71ce3          	bne	a4,a3,800043d8 <exec+0x30a>
      last = s+1;
    800043e4:	def43823          	sd	a5,-528(s0)
    800043e8:	bfc5                	j	800043d8 <exec+0x30a>
  safestrcpy(p->name, last, sizeof(p->name));
    800043ea:	4641                	li	a2,16
    800043ec:	df043583          	ld	a1,-528(s0)
    800043f0:	158a8513          	addi	a0,s5,344
    800043f4:	ffffc097          	auipc	ra,0xffffc
    800043f8:	edc080e7          	jalr	-292(ra) # 800002d0 <safestrcpy>
  oldpagetable = p->pagetable;
    800043fc:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80004400:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    80004404:	054ab423          	sd	s4,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004408:	058ab783          	ld	a5,88(s5)
    8000440c:	e6843703          	ld	a4,-408(s0)
    80004410:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004412:	058ab783          	ld	a5,88(s5)
    80004416:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000441a:	85ea                	mv	a1,s10
    8000441c:	ffffd097          	auipc	ra,0xffffd
    80004420:	be6080e7          	jalr	-1050(ra) # 80001002 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004424:	0004851b          	sext.w	a0,s1
    80004428:	79fe                	ld	s3,504(sp)
    8000442a:	7a5e                	ld	s4,496(sp)
    8000442c:	7abe                	ld	s5,488(sp)
    8000442e:	7b1e                	ld	s6,480(sp)
    80004430:	6bfe                	ld	s7,472(sp)
    80004432:	6c5e                	ld	s8,464(sp)
    80004434:	6cbe                	ld	s9,456(sp)
    80004436:	6d1e                	ld	s10,448(sp)
    80004438:	7dfa                	ld	s11,440(sp)
    8000443a:	b30d                	j	8000415c <exec+0x8e>
    8000443c:	7b1e                	ld	s6,480(sp)
    8000443e:	b321                	j	80004146 <exec+0x78>
    80004440:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004444:	df843583          	ld	a1,-520(s0)
    80004448:	855a                	mv	a0,s6
    8000444a:	ffffd097          	auipc	ra,0xffffd
    8000444e:	bb8080e7          	jalr	-1096(ra) # 80001002 <proc_freepagetable>
  if(ip){
    80004452:	79fe                	ld	s3,504(sp)
    80004454:	7abe                	ld	s5,488(sp)
    80004456:	7b1e                	ld	s6,480(sp)
    80004458:	6bfe                	ld	s7,472(sp)
    8000445a:	6c5e                	ld	s8,464(sp)
    8000445c:	6cbe                	ld	s9,456(sp)
    8000445e:	6d1e                	ld	s10,448(sp)
    80004460:	7dfa                	ld	s11,440(sp)
    80004462:	b1d5                	j	80004146 <exec+0x78>
    80004464:	de943c23          	sd	s1,-520(s0)
    80004468:	bff1                	j	80004444 <exec+0x376>
    8000446a:	de943c23          	sd	s1,-520(s0)
    8000446e:	bfd9                	j	80004444 <exec+0x376>
    80004470:	de943c23          	sd	s1,-520(s0)
    80004474:	bfc1                	j	80004444 <exec+0x376>
  sz = sz1;
    80004476:	89d2                	mv	s3,s4
    80004478:	b59d                	j	800042de <exec+0x210>
    8000447a:	89d2                	mv	s3,s4
    8000447c:	b58d                	j	800042de <exec+0x210>

000000008000447e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000447e:	7179                	addi	sp,sp,-48
    80004480:	f406                	sd	ra,40(sp)
    80004482:	f022                	sd	s0,32(sp)
    80004484:	ec26                	sd	s1,24(sp)
    80004486:	e84a                	sd	s2,16(sp)
    80004488:	1800                	addi	s0,sp,48
    8000448a:	892e                	mv	s2,a1
    8000448c:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    8000448e:	fdc40593          	addi	a1,s0,-36
    80004492:	ffffe097          	auipc	ra,0xffffe
    80004496:	ada080e7          	jalr	-1318(ra) # 80001f6c <argint>
    8000449a:	04054063          	bltz	a0,800044da <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000449e:	fdc42703          	lw	a4,-36(s0)
    800044a2:	47bd                	li	a5,15
    800044a4:	02e7ed63          	bltu	a5,a4,800044de <argfd+0x60>
    800044a8:	ffffd097          	auipc	ra,0xffffd
    800044ac:	9fa080e7          	jalr	-1542(ra) # 80000ea2 <myproc>
    800044b0:	fdc42703          	lw	a4,-36(s0)
    800044b4:	01a70793          	addi	a5,a4,26
    800044b8:	078e                	slli	a5,a5,0x3
    800044ba:	953e                	add	a0,a0,a5
    800044bc:	611c                	ld	a5,0(a0)
    800044be:	c395                	beqz	a5,800044e2 <argfd+0x64>
    return -1;
  if(pfd)
    800044c0:	00090463          	beqz	s2,800044c8 <argfd+0x4a>
    *pfd = fd;
    800044c4:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800044c8:	4501                	li	a0,0
  if(pf)
    800044ca:	c091                	beqz	s1,800044ce <argfd+0x50>
    *pf = f;
    800044cc:	e09c                	sd	a5,0(s1)
}
    800044ce:	70a2                	ld	ra,40(sp)
    800044d0:	7402                	ld	s0,32(sp)
    800044d2:	64e2                	ld	s1,24(sp)
    800044d4:	6942                	ld	s2,16(sp)
    800044d6:	6145                	addi	sp,sp,48
    800044d8:	8082                	ret
    return -1;
    800044da:	557d                	li	a0,-1
    800044dc:	bfcd                	j	800044ce <argfd+0x50>
    return -1;
    800044de:	557d                	li	a0,-1
    800044e0:	b7fd                	j	800044ce <argfd+0x50>
    800044e2:	557d                	li	a0,-1
    800044e4:	b7ed                	j	800044ce <argfd+0x50>

00000000800044e6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800044e6:	1101                	addi	sp,sp,-32
    800044e8:	ec06                	sd	ra,24(sp)
    800044ea:	e822                	sd	s0,16(sp)
    800044ec:	e426                	sd	s1,8(sp)
    800044ee:	1000                	addi	s0,sp,32
    800044f0:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800044f2:	ffffd097          	auipc	ra,0xffffd
    800044f6:	9b0080e7          	jalr	-1616(ra) # 80000ea2 <myproc>
    800044fa:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800044fc:	0d050793          	addi	a5,a0,208
    80004500:	4501                	li	a0,0
    80004502:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004504:	6398                	ld	a4,0(a5)
    80004506:	cb19                	beqz	a4,8000451c <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004508:	2505                	addiw	a0,a0,1
    8000450a:	07a1                	addi	a5,a5,8
    8000450c:	fed51ce3          	bne	a0,a3,80004504 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004510:	557d                	li	a0,-1
}
    80004512:	60e2                	ld	ra,24(sp)
    80004514:	6442                	ld	s0,16(sp)
    80004516:	64a2                	ld	s1,8(sp)
    80004518:	6105                	addi	sp,sp,32
    8000451a:	8082                	ret
      p->ofile[fd] = f;
    8000451c:	01a50793          	addi	a5,a0,26
    80004520:	078e                	slli	a5,a5,0x3
    80004522:	963e                	add	a2,a2,a5
    80004524:	e204                	sd	s1,0(a2)
      return fd;
    80004526:	b7f5                	j	80004512 <fdalloc+0x2c>

0000000080004528 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004528:	715d                	addi	sp,sp,-80
    8000452a:	e486                	sd	ra,72(sp)
    8000452c:	e0a2                	sd	s0,64(sp)
    8000452e:	fc26                	sd	s1,56(sp)
    80004530:	f84a                	sd	s2,48(sp)
    80004532:	f44e                	sd	s3,40(sp)
    80004534:	f052                	sd	s4,32(sp)
    80004536:	ec56                	sd	s5,24(sp)
    80004538:	0880                	addi	s0,sp,80
    8000453a:	8aae                	mv	s5,a1
    8000453c:	8a32                	mv	s4,a2
    8000453e:	89b6                	mv	s3,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004540:	fb040593          	addi	a1,s0,-80
    80004544:	fffff097          	auipc	ra,0xfffff
    80004548:	df4080e7          	jalr	-524(ra) # 80003338 <nameiparent>
    8000454c:	892a                	mv	s2,a0
    8000454e:	12050c63          	beqz	a0,80004686 <create+0x15e>
    return 0;

  ilock(dp);
    80004552:	ffffe097          	auipc	ra,0xffffe
    80004556:	5dc080e7          	jalr	1500(ra) # 80002b2e <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000455a:	4601                	li	a2,0
    8000455c:	fb040593          	addi	a1,s0,-80
    80004560:	854a                	mv	a0,s2
    80004562:	fffff097          	auipc	ra,0xfffff
    80004566:	abc080e7          	jalr	-1348(ra) # 8000301e <dirlookup>
    8000456a:	84aa                	mv	s1,a0
    8000456c:	c539                	beqz	a0,800045ba <create+0x92>
    iunlockput(dp);
    8000456e:	854a                	mv	a0,s2
    80004570:	fffff097          	auipc	ra,0xfffff
    80004574:	824080e7          	jalr	-2012(ra) # 80002d94 <iunlockput>
    ilock(ip);
    80004578:	8526                	mv	a0,s1
    8000457a:	ffffe097          	auipc	ra,0xffffe
    8000457e:	5b4080e7          	jalr	1460(ra) # 80002b2e <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004582:	4789                	li	a5,2
    80004584:	02fa9463          	bne	s5,a5,800045ac <create+0x84>
    80004588:	0444d783          	lhu	a5,68(s1)
    8000458c:	37f9                	addiw	a5,a5,-2
    8000458e:	17c2                	slli	a5,a5,0x30
    80004590:	93c1                	srli	a5,a5,0x30
    80004592:	4705                	li	a4,1
    80004594:	00f76c63          	bltu	a4,a5,800045ac <create+0x84>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004598:	8526                	mv	a0,s1
    8000459a:	60a6                	ld	ra,72(sp)
    8000459c:	6406                	ld	s0,64(sp)
    8000459e:	74e2                	ld	s1,56(sp)
    800045a0:	7942                	ld	s2,48(sp)
    800045a2:	79a2                	ld	s3,40(sp)
    800045a4:	7a02                	ld	s4,32(sp)
    800045a6:	6ae2                	ld	s5,24(sp)
    800045a8:	6161                	addi	sp,sp,80
    800045aa:	8082                	ret
    iunlockput(ip);
    800045ac:	8526                	mv	a0,s1
    800045ae:	ffffe097          	auipc	ra,0xffffe
    800045b2:	7e6080e7          	jalr	2022(ra) # 80002d94 <iunlockput>
    return 0;
    800045b6:	4481                	li	s1,0
    800045b8:	b7c5                	j	80004598 <create+0x70>
  if((ip = ialloc(dp->dev, type)) == 0)
    800045ba:	85d6                	mv	a1,s5
    800045bc:	00092503          	lw	a0,0(s2)
    800045c0:	ffffe097          	auipc	ra,0xffffe
    800045c4:	3da080e7          	jalr	986(ra) # 8000299a <ialloc>
    800045c8:	84aa                	mv	s1,a0
    800045ca:	c139                	beqz	a0,80004610 <create+0xe8>
  ilock(ip);
    800045cc:	ffffe097          	auipc	ra,0xffffe
    800045d0:	562080e7          	jalr	1378(ra) # 80002b2e <ilock>
  ip->major = major;
    800045d4:	05449323          	sh	s4,70(s1)
  ip->minor = minor;
    800045d8:	05349423          	sh	s3,72(s1)
  ip->nlink = 1;
    800045dc:	4985                	li	s3,1
    800045de:	05349523          	sh	s3,74(s1)
  iupdate(ip);
    800045e2:	8526                	mv	a0,s1
    800045e4:	ffffe097          	auipc	ra,0xffffe
    800045e8:	47e080e7          	jalr	1150(ra) # 80002a62 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800045ec:	033a8a63          	beq	s5,s3,80004620 <create+0xf8>
  if(dirlink(dp, name, ip->inum) < 0)
    800045f0:	40d0                	lw	a2,4(s1)
    800045f2:	fb040593          	addi	a1,s0,-80
    800045f6:	854a                	mv	a0,s2
    800045f8:	fffff097          	auipc	ra,0xfffff
    800045fc:	c4c080e7          	jalr	-948(ra) # 80003244 <dirlink>
    80004600:	06054b63          	bltz	a0,80004676 <create+0x14e>
  iunlockput(dp);
    80004604:	854a                	mv	a0,s2
    80004606:	ffffe097          	auipc	ra,0xffffe
    8000460a:	78e080e7          	jalr	1934(ra) # 80002d94 <iunlockput>
  return ip;
    8000460e:	b769                	j	80004598 <create+0x70>
    panic("create: ialloc");
    80004610:	00004517          	auipc	a0,0x4
    80004614:	01850513          	addi	a0,a0,24 # 80008628 <etext+0x628>
    80004618:	00001097          	auipc	ra,0x1
    8000461c:	6da080e7          	jalr	1754(ra) # 80005cf2 <panic>
    dp->nlink++;  // for ".."
    80004620:	04a95783          	lhu	a5,74(s2)
    80004624:	2785                	addiw	a5,a5,1
    80004626:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    8000462a:	854a                	mv	a0,s2
    8000462c:	ffffe097          	auipc	ra,0xffffe
    80004630:	436080e7          	jalr	1078(ra) # 80002a62 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004634:	40d0                	lw	a2,4(s1)
    80004636:	00004597          	auipc	a1,0x4
    8000463a:	00258593          	addi	a1,a1,2 # 80008638 <etext+0x638>
    8000463e:	8526                	mv	a0,s1
    80004640:	fffff097          	auipc	ra,0xfffff
    80004644:	c04080e7          	jalr	-1020(ra) # 80003244 <dirlink>
    80004648:	00054f63          	bltz	a0,80004666 <create+0x13e>
    8000464c:	00492603          	lw	a2,4(s2)
    80004650:	00004597          	auipc	a1,0x4
    80004654:	ff058593          	addi	a1,a1,-16 # 80008640 <etext+0x640>
    80004658:	8526                	mv	a0,s1
    8000465a:	fffff097          	auipc	ra,0xfffff
    8000465e:	bea080e7          	jalr	-1046(ra) # 80003244 <dirlink>
    80004662:	f80557e3          	bgez	a0,800045f0 <create+0xc8>
      panic("create dots");
    80004666:	00004517          	auipc	a0,0x4
    8000466a:	fe250513          	addi	a0,a0,-30 # 80008648 <etext+0x648>
    8000466e:	00001097          	auipc	ra,0x1
    80004672:	684080e7          	jalr	1668(ra) # 80005cf2 <panic>
    panic("create: dirlink");
    80004676:	00004517          	auipc	a0,0x4
    8000467a:	fe250513          	addi	a0,a0,-30 # 80008658 <etext+0x658>
    8000467e:	00001097          	auipc	ra,0x1
    80004682:	674080e7          	jalr	1652(ra) # 80005cf2 <panic>
    return 0;
    80004686:	84aa                	mv	s1,a0
    80004688:	bf01                	j	80004598 <create+0x70>

000000008000468a <sys_dup>:
{
    8000468a:	7179                	addi	sp,sp,-48
    8000468c:	f406                	sd	ra,40(sp)
    8000468e:	f022                	sd	s0,32(sp)
    80004690:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004692:	fd840613          	addi	a2,s0,-40
    80004696:	4581                	li	a1,0
    80004698:	4501                	li	a0,0
    8000469a:	00000097          	auipc	ra,0x0
    8000469e:	de4080e7          	jalr	-540(ra) # 8000447e <argfd>
    return -1;
    800046a2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800046a4:	02054763          	bltz	a0,800046d2 <sys_dup+0x48>
    800046a8:	ec26                	sd	s1,24(sp)
    800046aa:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    800046ac:	fd843903          	ld	s2,-40(s0)
    800046b0:	854a                	mv	a0,s2
    800046b2:	00000097          	auipc	ra,0x0
    800046b6:	e34080e7          	jalr	-460(ra) # 800044e6 <fdalloc>
    800046ba:	84aa                	mv	s1,a0
    return -1;
    800046bc:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800046be:	00054f63          	bltz	a0,800046dc <sys_dup+0x52>
  filedup(f);
    800046c2:	854a                	mv	a0,s2
    800046c4:	fffff097          	auipc	ra,0xfffff
    800046c8:	2da080e7          	jalr	730(ra) # 8000399e <filedup>
  return fd;
    800046cc:	87a6                	mv	a5,s1
    800046ce:	64e2                	ld	s1,24(sp)
    800046d0:	6942                	ld	s2,16(sp)
}
    800046d2:	853e                	mv	a0,a5
    800046d4:	70a2                	ld	ra,40(sp)
    800046d6:	7402                	ld	s0,32(sp)
    800046d8:	6145                	addi	sp,sp,48
    800046da:	8082                	ret
    800046dc:	64e2                	ld	s1,24(sp)
    800046de:	6942                	ld	s2,16(sp)
    800046e0:	bfcd                	j	800046d2 <sys_dup+0x48>

00000000800046e2 <sys_read>:
{
    800046e2:	7179                	addi	sp,sp,-48
    800046e4:	f406                	sd	ra,40(sp)
    800046e6:	f022                	sd	s0,32(sp)
    800046e8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046ea:	fe840613          	addi	a2,s0,-24
    800046ee:	4581                	li	a1,0
    800046f0:	4501                	li	a0,0
    800046f2:	00000097          	auipc	ra,0x0
    800046f6:	d8c080e7          	jalr	-628(ra) # 8000447e <argfd>
    return -1;
    800046fa:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046fc:	04054163          	bltz	a0,8000473e <sys_read+0x5c>
    80004700:	fe440593          	addi	a1,s0,-28
    80004704:	4509                	li	a0,2
    80004706:	ffffe097          	auipc	ra,0xffffe
    8000470a:	866080e7          	jalr	-1946(ra) # 80001f6c <argint>
    return -1;
    8000470e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004710:	02054763          	bltz	a0,8000473e <sys_read+0x5c>
    80004714:	fd840593          	addi	a1,s0,-40
    80004718:	4505                	li	a0,1
    8000471a:	ffffe097          	auipc	ra,0xffffe
    8000471e:	874080e7          	jalr	-1932(ra) # 80001f8e <argaddr>
    return -1;
    80004722:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004724:	00054d63          	bltz	a0,8000473e <sys_read+0x5c>
  return fileread(f, p, n);
    80004728:	fe442603          	lw	a2,-28(s0)
    8000472c:	fd843583          	ld	a1,-40(s0)
    80004730:	fe843503          	ld	a0,-24(s0)
    80004734:	fffff097          	auipc	ra,0xfffff
    80004738:	410080e7          	jalr	1040(ra) # 80003b44 <fileread>
    8000473c:	87aa                	mv	a5,a0
}
    8000473e:	853e                	mv	a0,a5
    80004740:	70a2                	ld	ra,40(sp)
    80004742:	7402                	ld	s0,32(sp)
    80004744:	6145                	addi	sp,sp,48
    80004746:	8082                	ret

0000000080004748 <sys_write>:
{
    80004748:	7179                	addi	sp,sp,-48
    8000474a:	f406                	sd	ra,40(sp)
    8000474c:	f022                	sd	s0,32(sp)
    8000474e:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004750:	fe840613          	addi	a2,s0,-24
    80004754:	4581                	li	a1,0
    80004756:	4501                	li	a0,0
    80004758:	00000097          	auipc	ra,0x0
    8000475c:	d26080e7          	jalr	-730(ra) # 8000447e <argfd>
    return -1;
    80004760:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004762:	04054163          	bltz	a0,800047a4 <sys_write+0x5c>
    80004766:	fe440593          	addi	a1,s0,-28
    8000476a:	4509                	li	a0,2
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	800080e7          	jalr	-2048(ra) # 80001f6c <argint>
    return -1;
    80004774:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004776:	02054763          	bltz	a0,800047a4 <sys_write+0x5c>
    8000477a:	fd840593          	addi	a1,s0,-40
    8000477e:	4505                	li	a0,1
    80004780:	ffffe097          	auipc	ra,0xffffe
    80004784:	80e080e7          	jalr	-2034(ra) # 80001f8e <argaddr>
    return -1;
    80004788:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000478a:	00054d63          	bltz	a0,800047a4 <sys_write+0x5c>
  return filewrite(f, p, n);
    8000478e:	fe442603          	lw	a2,-28(s0)
    80004792:	fd843583          	ld	a1,-40(s0)
    80004796:	fe843503          	ld	a0,-24(s0)
    8000479a:	fffff097          	auipc	ra,0xfffff
    8000479e:	47c080e7          	jalr	1148(ra) # 80003c16 <filewrite>
    800047a2:	87aa                	mv	a5,a0
}
    800047a4:	853e                	mv	a0,a5
    800047a6:	70a2                	ld	ra,40(sp)
    800047a8:	7402                	ld	s0,32(sp)
    800047aa:	6145                	addi	sp,sp,48
    800047ac:	8082                	ret

00000000800047ae <sys_close>:
{
    800047ae:	1101                	addi	sp,sp,-32
    800047b0:	ec06                	sd	ra,24(sp)
    800047b2:	e822                	sd	s0,16(sp)
    800047b4:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800047b6:	fe040613          	addi	a2,s0,-32
    800047ba:	fec40593          	addi	a1,s0,-20
    800047be:	4501                	li	a0,0
    800047c0:	00000097          	auipc	ra,0x0
    800047c4:	cbe080e7          	jalr	-834(ra) # 8000447e <argfd>
    return -1;
    800047c8:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800047ca:	02054463          	bltz	a0,800047f2 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800047ce:	ffffc097          	auipc	ra,0xffffc
    800047d2:	6d4080e7          	jalr	1748(ra) # 80000ea2 <myproc>
    800047d6:	fec42783          	lw	a5,-20(s0)
    800047da:	07e9                	addi	a5,a5,26
    800047dc:	078e                	slli	a5,a5,0x3
    800047de:	953e                	add	a0,a0,a5
    800047e0:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800047e4:	fe043503          	ld	a0,-32(s0)
    800047e8:	fffff097          	auipc	ra,0xfffff
    800047ec:	208080e7          	jalr	520(ra) # 800039f0 <fileclose>
  return 0;
    800047f0:	4781                	li	a5,0
}
    800047f2:	853e                	mv	a0,a5
    800047f4:	60e2                	ld	ra,24(sp)
    800047f6:	6442                	ld	s0,16(sp)
    800047f8:	6105                	addi	sp,sp,32
    800047fa:	8082                	ret

00000000800047fc <sys_fstat>:
{
    800047fc:	1101                	addi	sp,sp,-32
    800047fe:	ec06                	sd	ra,24(sp)
    80004800:	e822                	sd	s0,16(sp)
    80004802:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004804:	fe840613          	addi	a2,s0,-24
    80004808:	4581                	li	a1,0
    8000480a:	4501                	li	a0,0
    8000480c:	00000097          	auipc	ra,0x0
    80004810:	c72080e7          	jalr	-910(ra) # 8000447e <argfd>
    return -1;
    80004814:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004816:	02054563          	bltz	a0,80004840 <sys_fstat+0x44>
    8000481a:	fe040593          	addi	a1,s0,-32
    8000481e:	4505                	li	a0,1
    80004820:	ffffd097          	auipc	ra,0xffffd
    80004824:	76e080e7          	jalr	1902(ra) # 80001f8e <argaddr>
    return -1;
    80004828:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000482a:	00054b63          	bltz	a0,80004840 <sys_fstat+0x44>
  return filestat(f, st);
    8000482e:	fe043583          	ld	a1,-32(s0)
    80004832:	fe843503          	ld	a0,-24(s0)
    80004836:	fffff097          	auipc	ra,0xfffff
    8000483a:	298080e7          	jalr	664(ra) # 80003ace <filestat>
    8000483e:	87aa                	mv	a5,a0
}
    80004840:	853e                	mv	a0,a5
    80004842:	60e2                	ld	ra,24(sp)
    80004844:	6442                	ld	s0,16(sp)
    80004846:	6105                	addi	sp,sp,32
    80004848:	8082                	ret

000000008000484a <sys_link>:
{
    8000484a:	7169                	addi	sp,sp,-304
    8000484c:	f606                	sd	ra,296(sp)
    8000484e:	f222                	sd	s0,288(sp)
    80004850:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004852:	08000613          	li	a2,128
    80004856:	ed040593          	addi	a1,s0,-304
    8000485a:	4501                	li	a0,0
    8000485c:	ffffd097          	auipc	ra,0xffffd
    80004860:	754080e7          	jalr	1876(ra) # 80001fb0 <argstr>
    return -1;
    80004864:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004866:	12054663          	bltz	a0,80004992 <sys_link+0x148>
    8000486a:	08000613          	li	a2,128
    8000486e:	f5040593          	addi	a1,s0,-176
    80004872:	4505                	li	a0,1
    80004874:	ffffd097          	auipc	ra,0xffffd
    80004878:	73c080e7          	jalr	1852(ra) # 80001fb0 <argstr>
    return -1;
    8000487c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000487e:	10054a63          	bltz	a0,80004992 <sys_link+0x148>
    80004882:	ee26                	sd	s1,280(sp)
  begin_op();
    80004884:	fffff097          	auipc	ra,0xfffff
    80004888:	c9c080e7          	jalr	-868(ra) # 80003520 <begin_op>
  if((ip = namei(old)) == 0){
    8000488c:	ed040513          	addi	a0,s0,-304
    80004890:	fffff097          	auipc	ra,0xfffff
    80004894:	a8a080e7          	jalr	-1398(ra) # 8000331a <namei>
    80004898:	84aa                	mv	s1,a0
    8000489a:	c949                	beqz	a0,8000492c <sys_link+0xe2>
  ilock(ip);
    8000489c:	ffffe097          	auipc	ra,0xffffe
    800048a0:	292080e7          	jalr	658(ra) # 80002b2e <ilock>
  if(ip->type == T_DIR){
    800048a4:	04449703          	lh	a4,68(s1)
    800048a8:	4785                	li	a5,1
    800048aa:	08f70863          	beq	a4,a5,8000493a <sys_link+0xf0>
    800048ae:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    800048b0:	04a4d783          	lhu	a5,74(s1)
    800048b4:	2785                	addiw	a5,a5,1
    800048b6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800048ba:	8526                	mv	a0,s1
    800048bc:	ffffe097          	auipc	ra,0xffffe
    800048c0:	1a6080e7          	jalr	422(ra) # 80002a62 <iupdate>
  iunlock(ip);
    800048c4:	8526                	mv	a0,s1
    800048c6:	ffffe097          	auipc	ra,0xffffe
    800048ca:	32e080e7          	jalr	814(ra) # 80002bf4 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800048ce:	fd040593          	addi	a1,s0,-48
    800048d2:	f5040513          	addi	a0,s0,-176
    800048d6:	fffff097          	auipc	ra,0xfffff
    800048da:	a62080e7          	jalr	-1438(ra) # 80003338 <nameiparent>
    800048de:	892a                	mv	s2,a0
    800048e0:	cd35                	beqz	a0,8000495c <sys_link+0x112>
  ilock(dp);
    800048e2:	ffffe097          	auipc	ra,0xffffe
    800048e6:	24c080e7          	jalr	588(ra) # 80002b2e <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800048ea:	00092703          	lw	a4,0(s2)
    800048ee:	409c                	lw	a5,0(s1)
    800048f0:	06f71163          	bne	a4,a5,80004952 <sys_link+0x108>
    800048f4:	40d0                	lw	a2,4(s1)
    800048f6:	fd040593          	addi	a1,s0,-48
    800048fa:	854a                	mv	a0,s2
    800048fc:	fffff097          	auipc	ra,0xfffff
    80004900:	948080e7          	jalr	-1720(ra) # 80003244 <dirlink>
    80004904:	04054763          	bltz	a0,80004952 <sys_link+0x108>
  iunlockput(dp);
    80004908:	854a                	mv	a0,s2
    8000490a:	ffffe097          	auipc	ra,0xffffe
    8000490e:	48a080e7          	jalr	1162(ra) # 80002d94 <iunlockput>
  iput(ip);
    80004912:	8526                	mv	a0,s1
    80004914:	ffffe097          	auipc	ra,0xffffe
    80004918:	3d8080e7          	jalr	984(ra) # 80002cec <iput>
  end_op();
    8000491c:	fffff097          	auipc	ra,0xfffff
    80004920:	c7e080e7          	jalr	-898(ra) # 8000359a <end_op>
  return 0;
    80004924:	4781                	li	a5,0
    80004926:	64f2                	ld	s1,280(sp)
    80004928:	6952                	ld	s2,272(sp)
    8000492a:	a0a5                	j	80004992 <sys_link+0x148>
    end_op();
    8000492c:	fffff097          	auipc	ra,0xfffff
    80004930:	c6e080e7          	jalr	-914(ra) # 8000359a <end_op>
    return -1;
    80004934:	57fd                	li	a5,-1
    80004936:	64f2                	ld	s1,280(sp)
    80004938:	a8a9                	j	80004992 <sys_link+0x148>
    iunlockput(ip);
    8000493a:	8526                	mv	a0,s1
    8000493c:	ffffe097          	auipc	ra,0xffffe
    80004940:	458080e7          	jalr	1112(ra) # 80002d94 <iunlockput>
    end_op();
    80004944:	fffff097          	auipc	ra,0xfffff
    80004948:	c56080e7          	jalr	-938(ra) # 8000359a <end_op>
    return -1;
    8000494c:	57fd                	li	a5,-1
    8000494e:	64f2                	ld	s1,280(sp)
    80004950:	a089                	j	80004992 <sys_link+0x148>
    iunlockput(dp);
    80004952:	854a                	mv	a0,s2
    80004954:	ffffe097          	auipc	ra,0xffffe
    80004958:	440080e7          	jalr	1088(ra) # 80002d94 <iunlockput>
  ilock(ip);
    8000495c:	8526                	mv	a0,s1
    8000495e:	ffffe097          	auipc	ra,0xffffe
    80004962:	1d0080e7          	jalr	464(ra) # 80002b2e <ilock>
  ip->nlink--;
    80004966:	04a4d783          	lhu	a5,74(s1)
    8000496a:	37fd                	addiw	a5,a5,-1
    8000496c:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004970:	8526                	mv	a0,s1
    80004972:	ffffe097          	auipc	ra,0xffffe
    80004976:	0f0080e7          	jalr	240(ra) # 80002a62 <iupdate>
  iunlockput(ip);
    8000497a:	8526                	mv	a0,s1
    8000497c:	ffffe097          	auipc	ra,0xffffe
    80004980:	418080e7          	jalr	1048(ra) # 80002d94 <iunlockput>
  end_op();
    80004984:	fffff097          	auipc	ra,0xfffff
    80004988:	c16080e7          	jalr	-1002(ra) # 8000359a <end_op>
  return -1;
    8000498c:	57fd                	li	a5,-1
    8000498e:	64f2                	ld	s1,280(sp)
    80004990:	6952                	ld	s2,272(sp)
}
    80004992:	853e                	mv	a0,a5
    80004994:	70b2                	ld	ra,296(sp)
    80004996:	7412                	ld	s0,288(sp)
    80004998:	6155                	addi	sp,sp,304
    8000499a:	8082                	ret

000000008000499c <sys_unlink>:
{
    8000499c:	7111                	addi	sp,sp,-256
    8000499e:	fd86                	sd	ra,248(sp)
    800049a0:	f9a2                	sd	s0,240(sp)
    800049a2:	0200                	addi	s0,sp,256
  if(argstr(0, path, MAXPATH) < 0)
    800049a4:	08000613          	li	a2,128
    800049a8:	f2040593          	addi	a1,s0,-224
    800049ac:	4501                	li	a0,0
    800049ae:	ffffd097          	auipc	ra,0xffffd
    800049b2:	602080e7          	jalr	1538(ra) # 80001fb0 <argstr>
    800049b6:	1c054063          	bltz	a0,80004b76 <sys_unlink+0x1da>
    800049ba:	f5a6                	sd	s1,232(sp)
  begin_op();
    800049bc:	fffff097          	auipc	ra,0xfffff
    800049c0:	b64080e7          	jalr	-1180(ra) # 80003520 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800049c4:	fa040593          	addi	a1,s0,-96
    800049c8:	f2040513          	addi	a0,s0,-224
    800049cc:	fffff097          	auipc	ra,0xfffff
    800049d0:	96c080e7          	jalr	-1684(ra) # 80003338 <nameiparent>
    800049d4:	84aa                	mv	s1,a0
    800049d6:	c165                	beqz	a0,80004ab6 <sys_unlink+0x11a>
  ilock(dp);
    800049d8:	ffffe097          	auipc	ra,0xffffe
    800049dc:	156080e7          	jalr	342(ra) # 80002b2e <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800049e0:	00004597          	auipc	a1,0x4
    800049e4:	c5858593          	addi	a1,a1,-936 # 80008638 <etext+0x638>
    800049e8:	fa040513          	addi	a0,s0,-96
    800049ec:	ffffe097          	auipc	ra,0xffffe
    800049f0:	618080e7          	jalr	1560(ra) # 80003004 <namecmp>
    800049f4:	16050263          	beqz	a0,80004b58 <sys_unlink+0x1bc>
    800049f8:	00004597          	auipc	a1,0x4
    800049fc:	c4858593          	addi	a1,a1,-952 # 80008640 <etext+0x640>
    80004a00:	fa040513          	addi	a0,s0,-96
    80004a04:	ffffe097          	auipc	ra,0xffffe
    80004a08:	600080e7          	jalr	1536(ra) # 80003004 <namecmp>
    80004a0c:	14050663          	beqz	a0,80004b58 <sys_unlink+0x1bc>
    80004a10:	f1ca                	sd	s2,224(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004a12:	f1c40613          	addi	a2,s0,-228
    80004a16:	fa040593          	addi	a1,s0,-96
    80004a1a:	8526                	mv	a0,s1
    80004a1c:	ffffe097          	auipc	ra,0xffffe
    80004a20:	602080e7          	jalr	1538(ra) # 8000301e <dirlookup>
    80004a24:	892a                	mv	s2,a0
    80004a26:	12050863          	beqz	a0,80004b56 <sys_unlink+0x1ba>
    80004a2a:	edce                	sd	s3,216(sp)
  ilock(ip);
    80004a2c:	ffffe097          	auipc	ra,0xffffe
    80004a30:	102080e7          	jalr	258(ra) # 80002b2e <ilock>
  if(ip->nlink < 1)
    80004a34:	04a91783          	lh	a5,74(s2)
    80004a38:	08f05663          	blez	a5,80004ac4 <sys_unlink+0x128>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004a3c:	04491703          	lh	a4,68(s2)
    80004a40:	4785                	li	a5,1
    80004a42:	08f70b63          	beq	a4,a5,80004ad8 <sys_unlink+0x13c>
  memset(&de, 0, sizeof(de));
    80004a46:	fb040993          	addi	s3,s0,-80
    80004a4a:	4641                	li	a2,16
    80004a4c:	4581                	li	a1,0
    80004a4e:	854e                	mv	a0,s3
    80004a50:	ffffb097          	auipc	ra,0xffffb
    80004a54:	72a080e7          	jalr	1834(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a58:	4741                	li	a4,16
    80004a5a:	f1c42683          	lw	a3,-228(s0)
    80004a5e:	864e                	mv	a2,s3
    80004a60:	4581                	li	a1,0
    80004a62:	8526                	mv	a0,s1
    80004a64:	ffffe097          	auipc	ra,0xffffe
    80004a68:	480080e7          	jalr	1152(ra) # 80002ee4 <writei>
    80004a6c:	47c1                	li	a5,16
    80004a6e:	0af51f63          	bne	a0,a5,80004b2c <sys_unlink+0x190>
  if(ip->type == T_DIR){
    80004a72:	04491703          	lh	a4,68(s2)
    80004a76:	4785                	li	a5,1
    80004a78:	0cf70463          	beq	a4,a5,80004b40 <sys_unlink+0x1a4>
  iunlockput(dp);
    80004a7c:	8526                	mv	a0,s1
    80004a7e:	ffffe097          	auipc	ra,0xffffe
    80004a82:	316080e7          	jalr	790(ra) # 80002d94 <iunlockput>
  ip->nlink--;
    80004a86:	04a95783          	lhu	a5,74(s2)
    80004a8a:	37fd                	addiw	a5,a5,-1
    80004a8c:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004a90:	854a                	mv	a0,s2
    80004a92:	ffffe097          	auipc	ra,0xffffe
    80004a96:	fd0080e7          	jalr	-48(ra) # 80002a62 <iupdate>
  iunlockput(ip);
    80004a9a:	854a                	mv	a0,s2
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	2f8080e7          	jalr	760(ra) # 80002d94 <iunlockput>
  end_op();
    80004aa4:	fffff097          	auipc	ra,0xfffff
    80004aa8:	af6080e7          	jalr	-1290(ra) # 8000359a <end_op>
  return 0;
    80004aac:	4501                	li	a0,0
    80004aae:	74ae                	ld	s1,232(sp)
    80004ab0:	790e                	ld	s2,224(sp)
    80004ab2:	69ee                	ld	s3,216(sp)
    80004ab4:	a86d                	j	80004b6e <sys_unlink+0x1d2>
    end_op();
    80004ab6:	fffff097          	auipc	ra,0xfffff
    80004aba:	ae4080e7          	jalr	-1308(ra) # 8000359a <end_op>
    return -1;
    80004abe:	557d                	li	a0,-1
    80004ac0:	74ae                	ld	s1,232(sp)
    80004ac2:	a075                	j	80004b6e <sys_unlink+0x1d2>
    80004ac4:	e9d2                	sd	s4,208(sp)
    80004ac6:	e5d6                	sd	s5,200(sp)
    panic("unlink: nlink < 1");
    80004ac8:	00004517          	auipc	a0,0x4
    80004acc:	ba050513          	addi	a0,a0,-1120 # 80008668 <etext+0x668>
    80004ad0:	00001097          	auipc	ra,0x1
    80004ad4:	222080e7          	jalr	546(ra) # 80005cf2 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ad8:	04c92703          	lw	a4,76(s2)
    80004adc:	02000793          	li	a5,32
    80004ae0:	f6e7f3e3          	bgeu	a5,a4,80004a46 <sys_unlink+0xaa>
    80004ae4:	e9d2                	sd	s4,208(sp)
    80004ae6:	e5d6                	sd	s5,200(sp)
    80004ae8:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004aea:	f0840a93          	addi	s5,s0,-248
    80004aee:	4a41                	li	s4,16
    80004af0:	8752                	mv	a4,s4
    80004af2:	86ce                	mv	a3,s3
    80004af4:	8656                	mv	a2,s5
    80004af6:	4581                	li	a1,0
    80004af8:	854a                	mv	a0,s2
    80004afa:	ffffe097          	auipc	ra,0xffffe
    80004afe:	2f0080e7          	jalr	752(ra) # 80002dea <readi>
    80004b02:	01451d63          	bne	a0,s4,80004b1c <sys_unlink+0x180>
    if(de.inum != 0)
    80004b06:	f0845783          	lhu	a5,-248(s0)
    80004b0a:	eba5                	bnez	a5,80004b7a <sys_unlink+0x1de>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004b0c:	29c1                	addiw	s3,s3,16
    80004b0e:	04c92783          	lw	a5,76(s2)
    80004b12:	fcf9efe3          	bltu	s3,a5,80004af0 <sys_unlink+0x154>
    80004b16:	6a4e                	ld	s4,208(sp)
    80004b18:	6aae                	ld	s5,200(sp)
    80004b1a:	b735                	j	80004a46 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004b1c:	00004517          	auipc	a0,0x4
    80004b20:	b6450513          	addi	a0,a0,-1180 # 80008680 <etext+0x680>
    80004b24:	00001097          	auipc	ra,0x1
    80004b28:	1ce080e7          	jalr	462(ra) # 80005cf2 <panic>
    80004b2c:	e9d2                	sd	s4,208(sp)
    80004b2e:	e5d6                	sd	s5,200(sp)
    panic("unlink: writei");
    80004b30:	00004517          	auipc	a0,0x4
    80004b34:	b6850513          	addi	a0,a0,-1176 # 80008698 <etext+0x698>
    80004b38:	00001097          	auipc	ra,0x1
    80004b3c:	1ba080e7          	jalr	442(ra) # 80005cf2 <panic>
    dp->nlink--;
    80004b40:	04a4d783          	lhu	a5,74(s1)
    80004b44:	37fd                	addiw	a5,a5,-1
    80004b46:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004b4a:	8526                	mv	a0,s1
    80004b4c:	ffffe097          	auipc	ra,0xffffe
    80004b50:	f16080e7          	jalr	-234(ra) # 80002a62 <iupdate>
    80004b54:	b725                	j	80004a7c <sys_unlink+0xe0>
    80004b56:	790e                	ld	s2,224(sp)
  iunlockput(dp);
    80004b58:	8526                	mv	a0,s1
    80004b5a:	ffffe097          	auipc	ra,0xffffe
    80004b5e:	23a080e7          	jalr	570(ra) # 80002d94 <iunlockput>
  end_op();
    80004b62:	fffff097          	auipc	ra,0xfffff
    80004b66:	a38080e7          	jalr	-1480(ra) # 8000359a <end_op>
  return -1;
    80004b6a:	557d                	li	a0,-1
    80004b6c:	74ae                	ld	s1,232(sp)
}
    80004b6e:	70ee                	ld	ra,248(sp)
    80004b70:	744e                	ld	s0,240(sp)
    80004b72:	6111                	addi	sp,sp,256
    80004b74:	8082                	ret
    return -1;
    80004b76:	557d                	li	a0,-1
    80004b78:	bfdd                	j	80004b6e <sys_unlink+0x1d2>
    iunlockput(ip);
    80004b7a:	854a                	mv	a0,s2
    80004b7c:	ffffe097          	auipc	ra,0xffffe
    80004b80:	218080e7          	jalr	536(ra) # 80002d94 <iunlockput>
    goto bad;
    80004b84:	790e                	ld	s2,224(sp)
    80004b86:	69ee                	ld	s3,216(sp)
    80004b88:	6a4e                	ld	s4,208(sp)
    80004b8a:	6aae                	ld	s5,200(sp)
    80004b8c:	b7f1                	j	80004b58 <sys_unlink+0x1bc>

0000000080004b8e <sys_open>:

uint64
sys_open(void)
{
    80004b8e:	7131                	addi	sp,sp,-192
    80004b90:	fd06                	sd	ra,184(sp)
    80004b92:	f922                	sd	s0,176(sp)
    80004b94:	f526                	sd	s1,168(sp)
    80004b96:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b98:	08000613          	li	a2,128
    80004b9c:	f5040593          	addi	a1,s0,-176
    80004ba0:	4501                	li	a0,0
    80004ba2:	ffffd097          	auipc	ra,0xffffd
    80004ba6:	40e080e7          	jalr	1038(ra) # 80001fb0 <argstr>
    return -1;
    80004baa:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004bac:	0c054563          	bltz	a0,80004c76 <sys_open+0xe8>
    80004bb0:	f4c40593          	addi	a1,s0,-180
    80004bb4:	4505                	li	a0,1
    80004bb6:	ffffd097          	auipc	ra,0xffffd
    80004bba:	3b6080e7          	jalr	950(ra) # 80001f6c <argint>
    80004bbe:	0a054c63          	bltz	a0,80004c76 <sys_open+0xe8>
    80004bc2:	f14a                	sd	s2,160(sp)

  begin_op();
    80004bc4:	fffff097          	auipc	ra,0xfffff
    80004bc8:	95c080e7          	jalr	-1700(ra) # 80003520 <begin_op>

  if(omode & O_CREATE){
    80004bcc:	f4c42783          	lw	a5,-180(s0)
    80004bd0:	2007f793          	andi	a5,a5,512
    80004bd4:	cfcd                	beqz	a5,80004c8e <sys_open+0x100>
    ip = create(path, T_FILE, 0, 0);
    80004bd6:	4681                	li	a3,0
    80004bd8:	4601                	li	a2,0
    80004bda:	4589                	li	a1,2
    80004bdc:	f5040513          	addi	a0,s0,-176
    80004be0:	00000097          	auipc	ra,0x0
    80004be4:	948080e7          	jalr	-1720(ra) # 80004528 <create>
    80004be8:	892a                	mv	s2,a0
    if(ip == 0){
    80004bea:	cd41                	beqz	a0,80004c82 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004bec:	04491703          	lh	a4,68(s2)
    80004bf0:	478d                	li	a5,3
    80004bf2:	00f71763          	bne	a4,a5,80004c00 <sys_open+0x72>
    80004bf6:	04695703          	lhu	a4,70(s2)
    80004bfa:	47a5                	li	a5,9
    80004bfc:	0ee7e063          	bltu	a5,a4,80004cdc <sys_open+0x14e>
    80004c00:	ed4e                	sd	s3,152(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004c02:	fffff097          	auipc	ra,0xfffff
    80004c06:	d32080e7          	jalr	-718(ra) # 80003934 <filealloc>
    80004c0a:	89aa                	mv	s3,a0
    80004c0c:	c96d                	beqz	a0,80004cfe <sys_open+0x170>
    80004c0e:	00000097          	auipc	ra,0x0
    80004c12:	8d8080e7          	jalr	-1832(ra) # 800044e6 <fdalloc>
    80004c16:	84aa                	mv	s1,a0
    80004c18:	0c054e63          	bltz	a0,80004cf4 <sys_open+0x166>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004c1c:	04491703          	lh	a4,68(s2)
    80004c20:	478d                	li	a5,3
    80004c22:	0ef70b63          	beq	a4,a5,80004d18 <sys_open+0x18a>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004c26:	4789                	li	a5,2
    80004c28:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004c2c:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004c30:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004c34:	f4c42783          	lw	a5,-180(s0)
    80004c38:	0017f713          	andi	a4,a5,1
    80004c3c:	00174713          	xori	a4,a4,1
    80004c40:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004c44:	0037f713          	andi	a4,a5,3
    80004c48:	00e03733          	snez	a4,a4
    80004c4c:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004c50:	4007f793          	andi	a5,a5,1024
    80004c54:	c791                	beqz	a5,80004c60 <sys_open+0xd2>
    80004c56:	04491703          	lh	a4,68(s2)
    80004c5a:	4789                	li	a5,2
    80004c5c:	0cf70563          	beq	a4,a5,80004d26 <sys_open+0x198>
    itrunc(ip);
  }

  iunlock(ip);
    80004c60:	854a                	mv	a0,s2
    80004c62:	ffffe097          	auipc	ra,0xffffe
    80004c66:	f92080e7          	jalr	-110(ra) # 80002bf4 <iunlock>
  end_op();
    80004c6a:	fffff097          	auipc	ra,0xfffff
    80004c6e:	930080e7          	jalr	-1744(ra) # 8000359a <end_op>
    80004c72:	790a                	ld	s2,160(sp)
    80004c74:	69ea                	ld	s3,152(sp)

  return fd;
}
    80004c76:	8526                	mv	a0,s1
    80004c78:	70ea                	ld	ra,184(sp)
    80004c7a:	744a                	ld	s0,176(sp)
    80004c7c:	74aa                	ld	s1,168(sp)
    80004c7e:	6129                	addi	sp,sp,192
    80004c80:	8082                	ret
      end_op();
    80004c82:	fffff097          	auipc	ra,0xfffff
    80004c86:	918080e7          	jalr	-1768(ra) # 8000359a <end_op>
      return -1;
    80004c8a:	790a                	ld	s2,160(sp)
    80004c8c:	b7ed                	j	80004c76 <sys_open+0xe8>
    if((ip = namei(path)) == 0){
    80004c8e:	f5040513          	addi	a0,s0,-176
    80004c92:	ffffe097          	auipc	ra,0xffffe
    80004c96:	688080e7          	jalr	1672(ra) # 8000331a <namei>
    80004c9a:	892a                	mv	s2,a0
    80004c9c:	c90d                	beqz	a0,80004cce <sys_open+0x140>
    ilock(ip);
    80004c9e:	ffffe097          	auipc	ra,0xffffe
    80004ca2:	e90080e7          	jalr	-368(ra) # 80002b2e <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004ca6:	04491703          	lh	a4,68(s2)
    80004caa:	4785                	li	a5,1
    80004cac:	f4f710e3          	bne	a4,a5,80004bec <sys_open+0x5e>
    80004cb0:	f4c42783          	lw	a5,-180(s0)
    80004cb4:	d7b1                	beqz	a5,80004c00 <sys_open+0x72>
      iunlockput(ip);
    80004cb6:	854a                	mv	a0,s2
    80004cb8:	ffffe097          	auipc	ra,0xffffe
    80004cbc:	0dc080e7          	jalr	220(ra) # 80002d94 <iunlockput>
      end_op();
    80004cc0:	fffff097          	auipc	ra,0xfffff
    80004cc4:	8da080e7          	jalr	-1830(ra) # 8000359a <end_op>
      return -1;
    80004cc8:	54fd                	li	s1,-1
    80004cca:	790a                	ld	s2,160(sp)
    80004ccc:	b76d                	j	80004c76 <sys_open+0xe8>
      end_op();
    80004cce:	fffff097          	auipc	ra,0xfffff
    80004cd2:	8cc080e7          	jalr	-1844(ra) # 8000359a <end_op>
      return -1;
    80004cd6:	54fd                	li	s1,-1
    80004cd8:	790a                	ld	s2,160(sp)
    80004cda:	bf71                	j	80004c76 <sys_open+0xe8>
    iunlockput(ip);
    80004cdc:	854a                	mv	a0,s2
    80004cde:	ffffe097          	auipc	ra,0xffffe
    80004ce2:	0b6080e7          	jalr	182(ra) # 80002d94 <iunlockput>
    end_op();
    80004ce6:	fffff097          	auipc	ra,0xfffff
    80004cea:	8b4080e7          	jalr	-1868(ra) # 8000359a <end_op>
    return -1;
    80004cee:	54fd                	li	s1,-1
    80004cf0:	790a                	ld	s2,160(sp)
    80004cf2:	b751                	j	80004c76 <sys_open+0xe8>
      fileclose(f);
    80004cf4:	854e                	mv	a0,s3
    80004cf6:	fffff097          	auipc	ra,0xfffff
    80004cfa:	cfa080e7          	jalr	-774(ra) # 800039f0 <fileclose>
    iunlockput(ip);
    80004cfe:	854a                	mv	a0,s2
    80004d00:	ffffe097          	auipc	ra,0xffffe
    80004d04:	094080e7          	jalr	148(ra) # 80002d94 <iunlockput>
    end_op();
    80004d08:	fffff097          	auipc	ra,0xfffff
    80004d0c:	892080e7          	jalr	-1902(ra) # 8000359a <end_op>
    return -1;
    80004d10:	54fd                	li	s1,-1
    80004d12:	790a                	ld	s2,160(sp)
    80004d14:	69ea                	ld	s3,152(sp)
    80004d16:	b785                	j	80004c76 <sys_open+0xe8>
    f->type = FD_DEVICE;
    80004d18:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004d1c:	04691783          	lh	a5,70(s2)
    80004d20:	02f99223          	sh	a5,36(s3)
    80004d24:	b731                	j	80004c30 <sys_open+0xa2>
    itrunc(ip);
    80004d26:	854a                	mv	a0,s2
    80004d28:	ffffe097          	auipc	ra,0xffffe
    80004d2c:	f18080e7          	jalr	-232(ra) # 80002c40 <itrunc>
    80004d30:	bf05                	j	80004c60 <sys_open+0xd2>

0000000080004d32 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004d32:	7175                	addi	sp,sp,-144
    80004d34:	e506                	sd	ra,136(sp)
    80004d36:	e122                	sd	s0,128(sp)
    80004d38:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004d3a:	ffffe097          	auipc	ra,0xffffe
    80004d3e:	7e6080e7          	jalr	2022(ra) # 80003520 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004d42:	08000613          	li	a2,128
    80004d46:	f7040593          	addi	a1,s0,-144
    80004d4a:	4501                	li	a0,0
    80004d4c:	ffffd097          	auipc	ra,0xffffd
    80004d50:	264080e7          	jalr	612(ra) # 80001fb0 <argstr>
    80004d54:	02054963          	bltz	a0,80004d86 <sys_mkdir+0x54>
    80004d58:	4681                	li	a3,0
    80004d5a:	4601                	li	a2,0
    80004d5c:	4585                	li	a1,1
    80004d5e:	f7040513          	addi	a0,s0,-144
    80004d62:	fffff097          	auipc	ra,0xfffff
    80004d66:	7c6080e7          	jalr	1990(ra) # 80004528 <create>
    80004d6a:	cd11                	beqz	a0,80004d86 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004d6c:	ffffe097          	auipc	ra,0xffffe
    80004d70:	028080e7          	jalr	40(ra) # 80002d94 <iunlockput>
  end_op();
    80004d74:	fffff097          	auipc	ra,0xfffff
    80004d78:	826080e7          	jalr	-2010(ra) # 8000359a <end_op>
  return 0;
    80004d7c:	4501                	li	a0,0
}
    80004d7e:	60aa                	ld	ra,136(sp)
    80004d80:	640a                	ld	s0,128(sp)
    80004d82:	6149                	addi	sp,sp,144
    80004d84:	8082                	ret
    end_op();
    80004d86:	fffff097          	auipc	ra,0xfffff
    80004d8a:	814080e7          	jalr	-2028(ra) # 8000359a <end_op>
    return -1;
    80004d8e:	557d                	li	a0,-1
    80004d90:	b7fd                	j	80004d7e <sys_mkdir+0x4c>

0000000080004d92 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004d92:	7135                	addi	sp,sp,-160
    80004d94:	ed06                	sd	ra,152(sp)
    80004d96:	e922                	sd	s0,144(sp)
    80004d98:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004d9a:	ffffe097          	auipc	ra,0xffffe
    80004d9e:	786080e7          	jalr	1926(ra) # 80003520 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004da2:	08000613          	li	a2,128
    80004da6:	f7040593          	addi	a1,s0,-144
    80004daa:	4501                	li	a0,0
    80004dac:	ffffd097          	auipc	ra,0xffffd
    80004db0:	204080e7          	jalr	516(ra) # 80001fb0 <argstr>
    80004db4:	04054a63          	bltz	a0,80004e08 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004db8:	f6c40593          	addi	a1,s0,-148
    80004dbc:	4505                	li	a0,1
    80004dbe:	ffffd097          	auipc	ra,0xffffd
    80004dc2:	1ae080e7          	jalr	430(ra) # 80001f6c <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004dc6:	04054163          	bltz	a0,80004e08 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004dca:	f6840593          	addi	a1,s0,-152
    80004dce:	4509                	li	a0,2
    80004dd0:	ffffd097          	auipc	ra,0xffffd
    80004dd4:	19c080e7          	jalr	412(ra) # 80001f6c <argint>
     argint(1, &major) < 0 ||
    80004dd8:	02054863          	bltz	a0,80004e08 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004ddc:	f6841683          	lh	a3,-152(s0)
    80004de0:	f6c41603          	lh	a2,-148(s0)
    80004de4:	458d                	li	a1,3
    80004de6:	f7040513          	addi	a0,s0,-144
    80004dea:	fffff097          	auipc	ra,0xfffff
    80004dee:	73e080e7          	jalr	1854(ra) # 80004528 <create>
     argint(2, &minor) < 0 ||
    80004df2:	c919                	beqz	a0,80004e08 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004df4:	ffffe097          	auipc	ra,0xffffe
    80004df8:	fa0080e7          	jalr	-96(ra) # 80002d94 <iunlockput>
  end_op();
    80004dfc:	ffffe097          	auipc	ra,0xffffe
    80004e00:	79e080e7          	jalr	1950(ra) # 8000359a <end_op>
  return 0;
    80004e04:	4501                	li	a0,0
    80004e06:	a031                	j	80004e12 <sys_mknod+0x80>
    end_op();
    80004e08:	ffffe097          	auipc	ra,0xffffe
    80004e0c:	792080e7          	jalr	1938(ra) # 8000359a <end_op>
    return -1;
    80004e10:	557d                	li	a0,-1
}
    80004e12:	60ea                	ld	ra,152(sp)
    80004e14:	644a                	ld	s0,144(sp)
    80004e16:	610d                	addi	sp,sp,160
    80004e18:	8082                	ret

0000000080004e1a <sys_chdir>:

uint64
sys_chdir(void)
{
    80004e1a:	7135                	addi	sp,sp,-160
    80004e1c:	ed06                	sd	ra,152(sp)
    80004e1e:	e922                	sd	s0,144(sp)
    80004e20:	e14a                	sd	s2,128(sp)
    80004e22:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004e24:	ffffc097          	auipc	ra,0xffffc
    80004e28:	07e080e7          	jalr	126(ra) # 80000ea2 <myproc>
    80004e2c:	892a                	mv	s2,a0
  
  begin_op();
    80004e2e:	ffffe097          	auipc	ra,0xffffe
    80004e32:	6f2080e7          	jalr	1778(ra) # 80003520 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004e36:	08000613          	li	a2,128
    80004e3a:	f6040593          	addi	a1,s0,-160
    80004e3e:	4501                	li	a0,0
    80004e40:	ffffd097          	auipc	ra,0xffffd
    80004e44:	170080e7          	jalr	368(ra) # 80001fb0 <argstr>
    80004e48:	04054d63          	bltz	a0,80004ea2 <sys_chdir+0x88>
    80004e4c:	e526                	sd	s1,136(sp)
    80004e4e:	f6040513          	addi	a0,s0,-160
    80004e52:	ffffe097          	auipc	ra,0xffffe
    80004e56:	4c8080e7          	jalr	1224(ra) # 8000331a <namei>
    80004e5a:	84aa                	mv	s1,a0
    80004e5c:	c131                	beqz	a0,80004ea0 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004e5e:	ffffe097          	auipc	ra,0xffffe
    80004e62:	cd0080e7          	jalr	-816(ra) # 80002b2e <ilock>
  if(ip->type != T_DIR){
    80004e66:	04449703          	lh	a4,68(s1)
    80004e6a:	4785                	li	a5,1
    80004e6c:	04f71163          	bne	a4,a5,80004eae <sys_chdir+0x94>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004e70:	8526                	mv	a0,s1
    80004e72:	ffffe097          	auipc	ra,0xffffe
    80004e76:	d82080e7          	jalr	-638(ra) # 80002bf4 <iunlock>
  iput(p->cwd);
    80004e7a:	15093503          	ld	a0,336(s2)
    80004e7e:	ffffe097          	auipc	ra,0xffffe
    80004e82:	e6e080e7          	jalr	-402(ra) # 80002cec <iput>
  end_op();
    80004e86:	ffffe097          	auipc	ra,0xffffe
    80004e8a:	714080e7          	jalr	1812(ra) # 8000359a <end_op>
  p->cwd = ip;
    80004e8e:	14993823          	sd	s1,336(s2)
  return 0;
    80004e92:	4501                	li	a0,0
    80004e94:	64aa                	ld	s1,136(sp)
}
    80004e96:	60ea                	ld	ra,152(sp)
    80004e98:	644a                	ld	s0,144(sp)
    80004e9a:	690a                	ld	s2,128(sp)
    80004e9c:	610d                	addi	sp,sp,160
    80004e9e:	8082                	ret
    80004ea0:	64aa                	ld	s1,136(sp)
    end_op();
    80004ea2:	ffffe097          	auipc	ra,0xffffe
    80004ea6:	6f8080e7          	jalr	1784(ra) # 8000359a <end_op>
    return -1;
    80004eaa:	557d                	li	a0,-1
    80004eac:	b7ed                	j	80004e96 <sys_chdir+0x7c>
    iunlockput(ip);
    80004eae:	8526                	mv	a0,s1
    80004eb0:	ffffe097          	auipc	ra,0xffffe
    80004eb4:	ee4080e7          	jalr	-284(ra) # 80002d94 <iunlockput>
    end_op();
    80004eb8:	ffffe097          	auipc	ra,0xffffe
    80004ebc:	6e2080e7          	jalr	1762(ra) # 8000359a <end_op>
    return -1;
    80004ec0:	557d                	li	a0,-1
    80004ec2:	64aa                	ld	s1,136(sp)
    80004ec4:	bfc9                	j	80004e96 <sys_chdir+0x7c>

0000000080004ec6 <sys_exec>:

uint64
sys_exec(void)
{
    80004ec6:	7105                	addi	sp,sp,-480
    80004ec8:	ef86                	sd	ra,472(sp)
    80004eca:	eba2                	sd	s0,464(sp)
    80004ecc:	e3ca                	sd	s2,448(sp)
    80004ece:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004ed0:	08000613          	li	a2,128
    80004ed4:	f3040593          	addi	a1,s0,-208
    80004ed8:	4501                	li	a0,0
    80004eda:	ffffd097          	auipc	ra,0xffffd
    80004ede:	0d6080e7          	jalr	214(ra) # 80001fb0 <argstr>
    return -1;
    80004ee2:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004ee4:	10054963          	bltz	a0,80004ff6 <sys_exec+0x130>
    80004ee8:	e2840593          	addi	a1,s0,-472
    80004eec:	4505                	li	a0,1
    80004eee:	ffffd097          	auipc	ra,0xffffd
    80004ef2:	0a0080e7          	jalr	160(ra) # 80001f8e <argaddr>
    80004ef6:	10054063          	bltz	a0,80004ff6 <sys_exec+0x130>
    80004efa:	e7a6                	sd	s1,456(sp)
    80004efc:	ff4e                	sd	s3,440(sp)
    80004efe:	fb52                	sd	s4,432(sp)
    80004f00:	f756                	sd	s5,424(sp)
    80004f02:	f35a                	sd	s6,416(sp)
    80004f04:	ef5e                	sd	s7,408(sp)
  }
  memset(argv, 0, sizeof(argv));
    80004f06:	e3040a13          	addi	s4,s0,-464
    80004f0a:	10000613          	li	a2,256
    80004f0e:	4581                	li	a1,0
    80004f10:	8552                	mv	a0,s4
    80004f12:	ffffb097          	auipc	ra,0xffffb
    80004f16:	268080e7          	jalr	616(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004f1a:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    80004f1c:	89d2                	mv	s3,s4
    80004f1e:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004f20:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004f24:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    80004f26:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004f2a:	00391513          	slli	a0,s2,0x3
    80004f2e:	85d6                	mv	a1,s5
    80004f30:	e2843783          	ld	a5,-472(s0)
    80004f34:	953e                	add	a0,a0,a5
    80004f36:	ffffd097          	auipc	ra,0xffffd
    80004f3a:	f9c080e7          	jalr	-100(ra) # 80001ed2 <fetchaddr>
    80004f3e:	02054a63          	bltz	a0,80004f72 <sys_exec+0xac>
    if(uarg == 0){
    80004f42:	e2043783          	ld	a5,-480(s0)
    80004f46:	cba9                	beqz	a5,80004f98 <sys_exec+0xd2>
    argv[i] = kalloc();
    80004f48:	ffffb097          	auipc	ra,0xffffb
    80004f4c:	1d2080e7          	jalr	466(ra) # 8000011a <kalloc>
    80004f50:	85aa                	mv	a1,a0
    80004f52:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004f56:	cd11                	beqz	a0,80004f72 <sys_exec+0xac>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004f58:	865a                	mv	a2,s6
    80004f5a:	e2043503          	ld	a0,-480(s0)
    80004f5e:	ffffd097          	auipc	ra,0xffffd
    80004f62:	fc6080e7          	jalr	-58(ra) # 80001f24 <fetchstr>
    80004f66:	00054663          	bltz	a0,80004f72 <sys_exec+0xac>
    if(i >= NELEM(argv)){
    80004f6a:	0905                	addi	s2,s2,1
    80004f6c:	09a1                	addi	s3,s3,8
    80004f6e:	fb791ee3          	bne	s2,s7,80004f2a <sys_exec+0x64>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f72:	100a0a13          	addi	s4,s4,256
    80004f76:	6088                	ld	a0,0(s1)
    80004f78:	c925                	beqz	a0,80004fe8 <sys_exec+0x122>
    kfree(argv[i]);
    80004f7a:	ffffb097          	auipc	ra,0xffffb
    80004f7e:	0a2080e7          	jalr	162(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f82:	04a1                	addi	s1,s1,8
    80004f84:	ff4499e3          	bne	s1,s4,80004f76 <sys_exec+0xb0>
  return -1;
    80004f88:	597d                	li	s2,-1
    80004f8a:	64be                	ld	s1,456(sp)
    80004f8c:	79fa                	ld	s3,440(sp)
    80004f8e:	7a5a                	ld	s4,432(sp)
    80004f90:	7aba                	ld	s5,424(sp)
    80004f92:	7b1a                	ld	s6,416(sp)
    80004f94:	6bfa                	ld	s7,408(sp)
    80004f96:	a085                	j	80004ff6 <sys_exec+0x130>
      argv[i] = 0;
    80004f98:	0009079b          	sext.w	a5,s2
    80004f9c:	e3040593          	addi	a1,s0,-464
    80004fa0:	078e                	slli	a5,a5,0x3
    80004fa2:	97ae                	add	a5,a5,a1
    80004fa4:	0007b023          	sd	zero,0(a5)
  int ret = exec(path, argv);
    80004fa8:	f3040513          	addi	a0,s0,-208
    80004fac:	fffff097          	auipc	ra,0xfffff
    80004fb0:	122080e7          	jalr	290(ra) # 800040ce <exec>
    80004fb4:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004fb6:	100a0a13          	addi	s4,s4,256
    80004fba:	6088                	ld	a0,0(s1)
    80004fbc:	cd19                	beqz	a0,80004fda <sys_exec+0x114>
    kfree(argv[i]);
    80004fbe:	ffffb097          	auipc	ra,0xffffb
    80004fc2:	05e080e7          	jalr	94(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004fc6:	04a1                	addi	s1,s1,8
    80004fc8:	ff4499e3          	bne	s1,s4,80004fba <sys_exec+0xf4>
    80004fcc:	64be                	ld	s1,456(sp)
    80004fce:	79fa                	ld	s3,440(sp)
    80004fd0:	7a5a                	ld	s4,432(sp)
    80004fd2:	7aba                	ld	s5,424(sp)
    80004fd4:	7b1a                	ld	s6,416(sp)
    80004fd6:	6bfa                	ld	s7,408(sp)
    80004fd8:	a839                	j	80004ff6 <sys_exec+0x130>
  return ret;
    80004fda:	64be                	ld	s1,456(sp)
    80004fdc:	79fa                	ld	s3,440(sp)
    80004fde:	7a5a                	ld	s4,432(sp)
    80004fe0:	7aba                	ld	s5,424(sp)
    80004fe2:	7b1a                	ld	s6,416(sp)
    80004fe4:	6bfa                	ld	s7,408(sp)
    80004fe6:	a801                	j	80004ff6 <sys_exec+0x130>
  return -1;
    80004fe8:	597d                	li	s2,-1
    80004fea:	64be                	ld	s1,456(sp)
    80004fec:	79fa                	ld	s3,440(sp)
    80004fee:	7a5a                	ld	s4,432(sp)
    80004ff0:	7aba                	ld	s5,424(sp)
    80004ff2:	7b1a                	ld	s6,416(sp)
    80004ff4:	6bfa                	ld	s7,408(sp)
}
    80004ff6:	854a                	mv	a0,s2
    80004ff8:	60fe                	ld	ra,472(sp)
    80004ffa:	645e                	ld	s0,464(sp)
    80004ffc:	691e                	ld	s2,448(sp)
    80004ffe:	613d                	addi	sp,sp,480
    80005000:	8082                	ret

0000000080005002 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005002:	7139                	addi	sp,sp,-64
    80005004:	fc06                	sd	ra,56(sp)
    80005006:	f822                	sd	s0,48(sp)
    80005008:	f426                	sd	s1,40(sp)
    8000500a:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000500c:	ffffc097          	auipc	ra,0xffffc
    80005010:	e96080e7          	jalr	-362(ra) # 80000ea2 <myproc>
    80005014:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005016:	fd840593          	addi	a1,s0,-40
    8000501a:	4501                	li	a0,0
    8000501c:	ffffd097          	auipc	ra,0xffffd
    80005020:	f72080e7          	jalr	-142(ra) # 80001f8e <argaddr>
    return -1;
    80005024:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005026:	0e054063          	bltz	a0,80005106 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    8000502a:	fc840593          	addi	a1,s0,-56
    8000502e:	fd040513          	addi	a0,s0,-48
    80005032:	fffff097          	auipc	ra,0xfffff
    80005036:	d32080e7          	jalr	-718(ra) # 80003d64 <pipealloc>
    return -1;
    8000503a:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    8000503c:	0c054563          	bltz	a0,80005106 <sys_pipe+0x104>
  fd0 = -1;
    80005040:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005044:	fd043503          	ld	a0,-48(s0)
    80005048:	fffff097          	auipc	ra,0xfffff
    8000504c:	49e080e7          	jalr	1182(ra) # 800044e6 <fdalloc>
    80005050:	fca42223          	sw	a0,-60(s0)
    80005054:	08054c63          	bltz	a0,800050ec <sys_pipe+0xea>
    80005058:	fc843503          	ld	a0,-56(s0)
    8000505c:	fffff097          	auipc	ra,0xfffff
    80005060:	48a080e7          	jalr	1162(ra) # 800044e6 <fdalloc>
    80005064:	fca42023          	sw	a0,-64(s0)
    80005068:	06054963          	bltz	a0,800050da <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000506c:	4691                	li	a3,4
    8000506e:	fc440613          	addi	a2,s0,-60
    80005072:	fd843583          	ld	a1,-40(s0)
    80005076:	68a8                	ld	a0,80(s1)
    80005078:	ffffc097          	auipc	ra,0xffffc
    8000507c:	ad6080e7          	jalr	-1322(ra) # 80000b4e <copyout>
    80005080:	02054063          	bltz	a0,800050a0 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005084:	4691                	li	a3,4
    80005086:	fc040613          	addi	a2,s0,-64
    8000508a:	fd843583          	ld	a1,-40(s0)
    8000508e:	95b6                	add	a1,a1,a3
    80005090:	68a8                	ld	a0,80(s1)
    80005092:	ffffc097          	auipc	ra,0xffffc
    80005096:	abc080e7          	jalr	-1348(ra) # 80000b4e <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000509a:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000509c:	06055563          	bgez	a0,80005106 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    800050a0:	fc442783          	lw	a5,-60(s0)
    800050a4:	07e9                	addi	a5,a5,26
    800050a6:	078e                	slli	a5,a5,0x3
    800050a8:	97a6                	add	a5,a5,s1
    800050aa:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800050ae:	fc042783          	lw	a5,-64(s0)
    800050b2:	07e9                	addi	a5,a5,26
    800050b4:	078e                	slli	a5,a5,0x3
    800050b6:	00f48533          	add	a0,s1,a5
    800050ba:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    800050be:	fd043503          	ld	a0,-48(s0)
    800050c2:	fffff097          	auipc	ra,0xfffff
    800050c6:	92e080e7          	jalr	-1746(ra) # 800039f0 <fileclose>
    fileclose(wf);
    800050ca:	fc843503          	ld	a0,-56(s0)
    800050ce:	fffff097          	auipc	ra,0xfffff
    800050d2:	922080e7          	jalr	-1758(ra) # 800039f0 <fileclose>
    return -1;
    800050d6:	57fd                	li	a5,-1
    800050d8:	a03d                	j	80005106 <sys_pipe+0x104>
    if(fd0 >= 0)
    800050da:	fc442783          	lw	a5,-60(s0)
    800050de:	0007c763          	bltz	a5,800050ec <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    800050e2:	07e9                	addi	a5,a5,26
    800050e4:	078e                	slli	a5,a5,0x3
    800050e6:	97a6                	add	a5,a5,s1
    800050e8:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800050ec:	fd043503          	ld	a0,-48(s0)
    800050f0:	fffff097          	auipc	ra,0xfffff
    800050f4:	900080e7          	jalr	-1792(ra) # 800039f0 <fileclose>
    fileclose(wf);
    800050f8:	fc843503          	ld	a0,-56(s0)
    800050fc:	fffff097          	auipc	ra,0xfffff
    80005100:	8f4080e7          	jalr	-1804(ra) # 800039f0 <fileclose>
    return -1;
    80005104:	57fd                	li	a5,-1
}
    80005106:	853e                	mv	a0,a5
    80005108:	70e2                	ld	ra,56(sp)
    8000510a:	7442                	ld	s0,48(sp)
    8000510c:	74a2                	ld	s1,40(sp)
    8000510e:	6121                	addi	sp,sp,64
    80005110:	8082                	ret
	...

0000000080005120 <kernelvec>:
    80005120:	7111                	addi	sp,sp,-256
    80005122:	e006                	sd	ra,0(sp)
    80005124:	e40a                	sd	sp,8(sp)
    80005126:	e80e                	sd	gp,16(sp)
    80005128:	ec12                	sd	tp,24(sp)
    8000512a:	f016                	sd	t0,32(sp)
    8000512c:	f41a                	sd	t1,40(sp)
    8000512e:	f81e                	sd	t2,48(sp)
    80005130:	fc22                	sd	s0,56(sp)
    80005132:	e0a6                	sd	s1,64(sp)
    80005134:	e4aa                	sd	a0,72(sp)
    80005136:	e8ae                	sd	a1,80(sp)
    80005138:	ecb2                	sd	a2,88(sp)
    8000513a:	f0b6                	sd	a3,96(sp)
    8000513c:	f4ba                	sd	a4,104(sp)
    8000513e:	f8be                	sd	a5,112(sp)
    80005140:	fcc2                	sd	a6,120(sp)
    80005142:	e146                	sd	a7,128(sp)
    80005144:	e54a                	sd	s2,136(sp)
    80005146:	e94e                	sd	s3,144(sp)
    80005148:	ed52                	sd	s4,152(sp)
    8000514a:	f156                	sd	s5,160(sp)
    8000514c:	f55a                	sd	s6,168(sp)
    8000514e:	f95e                	sd	s7,176(sp)
    80005150:	fd62                	sd	s8,184(sp)
    80005152:	e1e6                	sd	s9,192(sp)
    80005154:	e5ea                	sd	s10,200(sp)
    80005156:	e9ee                	sd	s11,208(sp)
    80005158:	edf2                	sd	t3,216(sp)
    8000515a:	f1f6                	sd	t4,224(sp)
    8000515c:	f5fa                	sd	t5,232(sp)
    8000515e:	f9fe                	sd	t6,240(sp)
    80005160:	c3ffc0ef          	jal	80001d9e <kerneltrap>
    80005164:	6082                	ld	ra,0(sp)
    80005166:	6122                	ld	sp,8(sp)
    80005168:	61c2                	ld	gp,16(sp)
    8000516a:	7282                	ld	t0,32(sp)
    8000516c:	7322                	ld	t1,40(sp)
    8000516e:	73c2                	ld	t2,48(sp)
    80005170:	7462                	ld	s0,56(sp)
    80005172:	6486                	ld	s1,64(sp)
    80005174:	6526                	ld	a0,72(sp)
    80005176:	65c6                	ld	a1,80(sp)
    80005178:	6666                	ld	a2,88(sp)
    8000517a:	7686                	ld	a3,96(sp)
    8000517c:	7726                	ld	a4,104(sp)
    8000517e:	77c6                	ld	a5,112(sp)
    80005180:	7866                	ld	a6,120(sp)
    80005182:	688a                	ld	a7,128(sp)
    80005184:	692a                	ld	s2,136(sp)
    80005186:	69ca                	ld	s3,144(sp)
    80005188:	6a6a                	ld	s4,152(sp)
    8000518a:	7a8a                	ld	s5,160(sp)
    8000518c:	7b2a                	ld	s6,168(sp)
    8000518e:	7bca                	ld	s7,176(sp)
    80005190:	7c6a                	ld	s8,184(sp)
    80005192:	6c8e                	ld	s9,192(sp)
    80005194:	6d2e                	ld	s10,200(sp)
    80005196:	6dce                	ld	s11,208(sp)
    80005198:	6e6e                	ld	t3,216(sp)
    8000519a:	7e8e                	ld	t4,224(sp)
    8000519c:	7f2e                	ld	t5,232(sp)
    8000519e:	7fce                	ld	t6,240(sp)
    800051a0:	6111                	addi	sp,sp,256
    800051a2:	10200073          	sret
    800051a6:	00000013          	nop
    800051aa:	00000013          	nop
    800051ae:	0001                	nop

00000000800051b0 <timervec>:
    800051b0:	34051573          	csrrw	a0,mscratch,a0
    800051b4:	e10c                	sd	a1,0(a0)
    800051b6:	e510                	sd	a2,8(a0)
    800051b8:	e914                	sd	a3,16(a0)
    800051ba:	6d0c                	ld	a1,24(a0)
    800051bc:	7110                	ld	a2,32(a0)
    800051be:	6194                	ld	a3,0(a1)
    800051c0:	96b2                	add	a3,a3,a2
    800051c2:	e194                	sd	a3,0(a1)
    800051c4:	4589                	li	a1,2
    800051c6:	14459073          	csrw	sip,a1
    800051ca:	6914                	ld	a3,16(a0)
    800051cc:	6510                	ld	a2,8(a0)
    800051ce:	610c                	ld	a1,0(a0)
    800051d0:	34051573          	csrrw	a0,mscratch,a0
    800051d4:	30200073          	mret
	...

00000000800051da <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800051da:	1141                	addi	sp,sp,-16
    800051dc:	e406                	sd	ra,8(sp)
    800051de:	e022                	sd	s0,0(sp)
    800051e0:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800051e2:	0c000737          	lui	a4,0xc000
    800051e6:	4785                	li	a5,1
    800051e8:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800051ea:	c35c                	sw	a5,4(a4)
}
    800051ec:	60a2                	ld	ra,8(sp)
    800051ee:	6402                	ld	s0,0(sp)
    800051f0:	0141                	addi	sp,sp,16
    800051f2:	8082                	ret

00000000800051f4 <plicinithart>:

void
plicinithart(void)
{
    800051f4:	1141                	addi	sp,sp,-16
    800051f6:	e406                	sd	ra,8(sp)
    800051f8:	e022                	sd	s0,0(sp)
    800051fa:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800051fc:	ffffc097          	auipc	ra,0xffffc
    80005200:	c72080e7          	jalr	-910(ra) # 80000e6e <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005204:	0085171b          	slliw	a4,a0,0x8
    80005208:	0c0027b7          	lui	a5,0xc002
    8000520c:	97ba                	add	a5,a5,a4
    8000520e:	40200713          	li	a4,1026
    80005212:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005216:	00d5151b          	slliw	a0,a0,0xd
    8000521a:	0c2017b7          	lui	a5,0xc201
    8000521e:	97aa                	add	a5,a5,a0
    80005220:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005224:	60a2                	ld	ra,8(sp)
    80005226:	6402                	ld	s0,0(sp)
    80005228:	0141                	addi	sp,sp,16
    8000522a:	8082                	ret

000000008000522c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000522c:	1141                	addi	sp,sp,-16
    8000522e:	e406                	sd	ra,8(sp)
    80005230:	e022                	sd	s0,0(sp)
    80005232:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005234:	ffffc097          	auipc	ra,0xffffc
    80005238:	c3a080e7          	jalr	-966(ra) # 80000e6e <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    8000523c:	00d5151b          	slliw	a0,a0,0xd
    80005240:	0c2017b7          	lui	a5,0xc201
    80005244:	97aa                	add	a5,a5,a0
  return irq;
}
    80005246:	43c8                	lw	a0,4(a5)
    80005248:	60a2                	ld	ra,8(sp)
    8000524a:	6402                	ld	s0,0(sp)
    8000524c:	0141                	addi	sp,sp,16
    8000524e:	8082                	ret

0000000080005250 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005250:	1101                	addi	sp,sp,-32
    80005252:	ec06                	sd	ra,24(sp)
    80005254:	e822                	sd	s0,16(sp)
    80005256:	e426                	sd	s1,8(sp)
    80005258:	1000                	addi	s0,sp,32
    8000525a:	84aa                	mv	s1,a0
  int hart = cpuid();
    8000525c:	ffffc097          	auipc	ra,0xffffc
    80005260:	c12080e7          	jalr	-1006(ra) # 80000e6e <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005264:	00d5179b          	slliw	a5,a0,0xd
    80005268:	0c201737          	lui	a4,0xc201
    8000526c:	97ba                	add	a5,a5,a4
    8000526e:	c3c4                	sw	s1,4(a5)
}
    80005270:	60e2                	ld	ra,24(sp)
    80005272:	6442                	ld	s0,16(sp)
    80005274:	64a2                	ld	s1,8(sp)
    80005276:	6105                	addi	sp,sp,32
    80005278:	8082                	ret

000000008000527a <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    8000527a:	1141                	addi	sp,sp,-16
    8000527c:	e406                	sd	ra,8(sp)
    8000527e:	e022                	sd	s0,0(sp)
    80005280:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005282:	479d                	li	a5,7
    80005284:	06a7c863          	blt	a5,a0,800052f4 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    80005288:	00019717          	auipc	a4,0x19
    8000528c:	d7870713          	addi	a4,a4,-648 # 8001e000 <disk>
    80005290:	972a                	add	a4,a4,a0
    80005292:	6789                	lui	a5,0x2
    80005294:	97ba                	add	a5,a5,a4
    80005296:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    8000529a:	e7ad                	bnez	a5,80005304 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000529c:	00451793          	slli	a5,a0,0x4
    800052a0:	0001b717          	auipc	a4,0x1b
    800052a4:	d6070713          	addi	a4,a4,-672 # 80020000 <disk+0x2000>
    800052a8:	6314                	ld	a3,0(a4)
    800052aa:	96be                	add	a3,a3,a5
    800052ac:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800052b0:	6314                	ld	a3,0(a4)
    800052b2:	96be                	add	a3,a3,a5
    800052b4:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    800052b8:	6314                	ld	a3,0(a4)
    800052ba:	96be                	add	a3,a3,a5
    800052bc:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    800052c0:	6318                	ld	a4,0(a4)
    800052c2:	97ba                	add	a5,a5,a4
    800052c4:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    800052c8:	00019717          	auipc	a4,0x19
    800052cc:	d3870713          	addi	a4,a4,-712 # 8001e000 <disk>
    800052d0:	972a                	add	a4,a4,a0
    800052d2:	6789                	lui	a5,0x2
    800052d4:	97ba                	add	a5,a5,a4
    800052d6:	4705                	li	a4,1
    800052d8:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    800052dc:	0001b517          	auipc	a0,0x1b
    800052e0:	d3c50513          	addi	a0,a0,-708 # 80020018 <disk+0x2018>
    800052e4:	ffffc097          	auipc	ra,0xffffc
    800052e8:	416080e7          	jalr	1046(ra) # 800016fa <wakeup>
}
    800052ec:	60a2                	ld	ra,8(sp)
    800052ee:	6402                	ld	s0,0(sp)
    800052f0:	0141                	addi	sp,sp,16
    800052f2:	8082                	ret
    panic("free_desc 1");
    800052f4:	00003517          	auipc	a0,0x3
    800052f8:	3b450513          	addi	a0,a0,948 # 800086a8 <etext+0x6a8>
    800052fc:	00001097          	auipc	ra,0x1
    80005300:	9f6080e7          	jalr	-1546(ra) # 80005cf2 <panic>
    panic("free_desc 2");
    80005304:	00003517          	auipc	a0,0x3
    80005308:	3b450513          	addi	a0,a0,948 # 800086b8 <etext+0x6b8>
    8000530c:	00001097          	auipc	ra,0x1
    80005310:	9e6080e7          	jalr	-1562(ra) # 80005cf2 <panic>

0000000080005314 <virtio_disk_init>:
{
    80005314:	1141                	addi	sp,sp,-16
    80005316:	e406                	sd	ra,8(sp)
    80005318:	e022                	sd	s0,0(sp)
    8000531a:	0800                	addi	s0,sp,16
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000531c:	00003597          	auipc	a1,0x3
    80005320:	3ac58593          	addi	a1,a1,940 # 800086c8 <etext+0x6c8>
    80005324:	0001b517          	auipc	a0,0x1b
    80005328:	e0450513          	addi	a0,a0,-508 # 80020128 <disk+0x2128>
    8000532c:	00001097          	auipc	ra,0x1
    80005330:	eb2080e7          	jalr	-334(ra) # 800061de <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005334:	100017b7          	lui	a5,0x10001
    80005338:	4398                	lw	a4,0(a5)
    8000533a:	2701                	sext.w	a4,a4
    8000533c:	747277b7          	lui	a5,0x74727
    80005340:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005344:	0ef71563          	bne	a4,a5,8000542e <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005348:	100017b7          	lui	a5,0x10001
    8000534c:	43dc                	lw	a5,4(a5)
    8000534e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005350:	4705                	li	a4,1
    80005352:	0ce79e63          	bne	a5,a4,8000542e <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005356:	100017b7          	lui	a5,0x10001
    8000535a:	479c                	lw	a5,8(a5)
    8000535c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000535e:	4709                	li	a4,2
    80005360:	0ce79763          	bne	a5,a4,8000542e <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005364:	100017b7          	lui	a5,0x10001
    80005368:	47d8                	lw	a4,12(a5)
    8000536a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000536c:	554d47b7          	lui	a5,0x554d4
    80005370:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005374:	0af71d63          	bne	a4,a5,8000542e <virtio_disk_init+0x11a>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005378:	100017b7          	lui	a5,0x10001
    8000537c:	4705                	li	a4,1
    8000537e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005380:	470d                	li	a4,3
    80005382:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005384:	10001737          	lui	a4,0x10001
    80005388:	4b18                	lw	a4,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    8000538a:	c7ffe6b7          	lui	a3,0xc7ffe
    8000538e:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd551f>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005392:	8f75                	and	a4,a4,a3
    80005394:	100016b7          	lui	a3,0x10001
    80005398:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000539a:	472d                	li	a4,11
    8000539c:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000539e:	473d                	li	a4,15
    800053a0:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800053a2:	6705                	lui	a4,0x1
    800053a4:	d698                	sw	a4,40(a3)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800053a6:	0206a823          	sw	zero,48(a3) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800053aa:	5adc                	lw	a5,52(a3)
    800053ac:	2781                	sext.w	a5,a5
  if(max == 0)
    800053ae:	cbc1                	beqz	a5,8000543e <virtio_disk_init+0x12a>
  if(max < NUM)
    800053b0:	471d                	li	a4,7
    800053b2:	08f77e63          	bgeu	a4,a5,8000544e <virtio_disk_init+0x13a>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800053b6:	100017b7          	lui	a5,0x10001
    800053ba:	4721                	li	a4,8
    800053bc:	df98                	sw	a4,56(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    800053be:	6609                	lui	a2,0x2
    800053c0:	4581                	li	a1,0
    800053c2:	00019517          	auipc	a0,0x19
    800053c6:	c3e50513          	addi	a0,a0,-962 # 8001e000 <disk>
    800053ca:	ffffb097          	auipc	ra,0xffffb
    800053ce:	db0080e7          	jalr	-592(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800053d2:	00019717          	auipc	a4,0x19
    800053d6:	c2e70713          	addi	a4,a4,-978 # 8001e000 <disk>
    800053da:	00c75793          	srli	a5,a4,0xc
    800053de:	2781                	sext.w	a5,a5
    800053e0:	100016b7          	lui	a3,0x10001
    800053e4:	c2bc                	sw	a5,64(a3)
  disk.desc = (struct virtq_desc *) disk.pages;
    800053e6:	0001b797          	auipc	a5,0x1b
    800053ea:	c1a78793          	addi	a5,a5,-998 # 80020000 <disk+0x2000>
    800053ee:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800053f0:	00019717          	auipc	a4,0x19
    800053f4:	c9070713          	addi	a4,a4,-880 # 8001e080 <disk+0x80>
    800053f8:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800053fa:	0001a717          	auipc	a4,0x1a
    800053fe:	c0670713          	addi	a4,a4,-1018 # 8001f000 <disk+0x1000>
    80005402:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005404:	4705                	li	a4,1
    80005406:	00e78c23          	sb	a4,24(a5)
    8000540a:	00e78ca3          	sb	a4,25(a5)
    8000540e:	00e78d23          	sb	a4,26(a5)
    80005412:	00e78da3          	sb	a4,27(a5)
    80005416:	00e78e23          	sb	a4,28(a5)
    8000541a:	00e78ea3          	sb	a4,29(a5)
    8000541e:	00e78f23          	sb	a4,30(a5)
    80005422:	00e78fa3          	sb	a4,31(a5)
}
    80005426:	60a2                	ld	ra,8(sp)
    80005428:	6402                	ld	s0,0(sp)
    8000542a:	0141                	addi	sp,sp,16
    8000542c:	8082                	ret
    panic("could not find virtio disk");
    8000542e:	00003517          	auipc	a0,0x3
    80005432:	2aa50513          	addi	a0,a0,682 # 800086d8 <etext+0x6d8>
    80005436:	00001097          	auipc	ra,0x1
    8000543a:	8bc080e7          	jalr	-1860(ra) # 80005cf2 <panic>
    panic("virtio disk has no queue 0");
    8000543e:	00003517          	auipc	a0,0x3
    80005442:	2ba50513          	addi	a0,a0,698 # 800086f8 <etext+0x6f8>
    80005446:	00001097          	auipc	ra,0x1
    8000544a:	8ac080e7          	jalr	-1876(ra) # 80005cf2 <panic>
    panic("virtio disk max queue too short");
    8000544e:	00003517          	auipc	a0,0x3
    80005452:	2ca50513          	addi	a0,a0,714 # 80008718 <etext+0x718>
    80005456:	00001097          	auipc	ra,0x1
    8000545a:	89c080e7          	jalr	-1892(ra) # 80005cf2 <panic>

000000008000545e <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    8000545e:	711d                	addi	sp,sp,-96
    80005460:	ec86                	sd	ra,88(sp)
    80005462:	e8a2                	sd	s0,80(sp)
    80005464:	e4a6                	sd	s1,72(sp)
    80005466:	e0ca                	sd	s2,64(sp)
    80005468:	fc4e                	sd	s3,56(sp)
    8000546a:	f852                	sd	s4,48(sp)
    8000546c:	f456                	sd	s5,40(sp)
    8000546e:	f05a                	sd	s6,32(sp)
    80005470:	ec5e                	sd	s7,24(sp)
    80005472:	e862                	sd	s8,16(sp)
    80005474:	1080                	addi	s0,sp,96
    80005476:	89aa                	mv	s3,a0
    80005478:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    8000547a:	00c52b83          	lw	s7,12(a0)
    8000547e:	001b9b9b          	slliw	s7,s7,0x1
    80005482:	1b82                	slli	s7,s7,0x20
    80005484:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80005488:	0001b517          	auipc	a0,0x1b
    8000548c:	ca050513          	addi	a0,a0,-864 # 80020128 <disk+0x2128>
    80005490:	00001097          	auipc	ra,0x1
    80005494:	de2080e7          	jalr	-542(ra) # 80006272 <acquire>
  for(int i = 0; i < NUM; i++){
    80005498:	44a1                	li	s1,8
      disk.free[i] = 0;
    8000549a:	00019b17          	auipc	s6,0x19
    8000549e:	b66b0b13          	addi	s6,s6,-1178 # 8001e000 <disk>
    800054a2:	6a89                	lui	s5,0x2
  for(int i = 0; i < 3; i++){
    800054a4:	4a0d                	li	s4,3
    800054a6:	a88d                	j	80005518 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    800054a8:	00fb0733          	add	a4,s6,a5
    800054ac:	9756                	add	a4,a4,s5
    800054ae:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800054b2:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800054b4:	0207c563          	bltz	a5,800054de <virtio_disk_rw+0x80>
  for(int i = 0; i < 3; i++){
    800054b8:	2905                	addiw	s2,s2,1
    800054ba:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    800054bc:	1b490063          	beq	s2,s4,8000565c <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    800054c0:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    800054c2:	0001b717          	auipc	a4,0x1b
    800054c6:	b5670713          	addi	a4,a4,-1194 # 80020018 <disk+0x2018>
    800054ca:	4781                	li	a5,0
    if(disk.free[i]){
    800054cc:	00074683          	lbu	a3,0(a4)
    800054d0:	fee1                	bnez	a3,800054a8 <virtio_disk_rw+0x4a>
  for(int i = 0; i < NUM; i++){
    800054d2:	2785                	addiw	a5,a5,1
    800054d4:	0705                	addi	a4,a4,1
    800054d6:	fe979be3          	bne	a5,s1,800054cc <virtio_disk_rw+0x6e>
    idx[i] = alloc_desc();
    800054da:	57fd                	li	a5,-1
    800054dc:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    800054de:	03205163          	blez	s2,80005500 <virtio_disk_rw+0xa2>
        free_desc(idx[j]);
    800054e2:	fa042503          	lw	a0,-96(s0)
    800054e6:	00000097          	auipc	ra,0x0
    800054ea:	d94080e7          	jalr	-620(ra) # 8000527a <free_desc>
      for(int j = 0; j < i; j++)
    800054ee:	4785                	li	a5,1
    800054f0:	0127d863          	bge	a5,s2,80005500 <virtio_disk_rw+0xa2>
        free_desc(idx[j]);
    800054f4:	fa442503          	lw	a0,-92(s0)
    800054f8:	00000097          	auipc	ra,0x0
    800054fc:	d82080e7          	jalr	-638(ra) # 8000527a <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005500:	0001b597          	auipc	a1,0x1b
    80005504:	c2858593          	addi	a1,a1,-984 # 80020128 <disk+0x2128>
    80005508:	0001b517          	auipc	a0,0x1b
    8000550c:	b1050513          	addi	a0,a0,-1264 # 80020018 <disk+0x2018>
    80005510:	ffffc097          	auipc	ra,0xffffc
    80005514:	064080e7          	jalr	100(ra) # 80001574 <sleep>
  for(int i = 0; i < 3; i++){
    80005518:	fa040613          	addi	a2,s0,-96
    8000551c:	4901                	li	s2,0
    8000551e:	b74d                	j	800054c0 <virtio_disk_rw+0x62>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005520:	0001b717          	auipc	a4,0x1b
    80005524:	ae073703          	ld	a4,-1312(a4) # 80020000 <disk+0x2000>
    80005528:	973e                	add	a4,a4,a5
    8000552a:	00071623          	sh	zero,12(a4)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000552e:	00019897          	auipc	a7,0x19
    80005532:	ad288893          	addi	a7,a7,-1326 # 8001e000 <disk>
    80005536:	0001b717          	auipc	a4,0x1b
    8000553a:	aca70713          	addi	a4,a4,-1334 # 80020000 <disk+0x2000>
    8000553e:	6314                	ld	a3,0(a4)
    80005540:	96be                	add	a3,a3,a5
    80005542:	00c6d583          	lhu	a1,12(a3) # 1000100c <_entry-0x6fffeff4>
    80005546:	0015e593          	ori	a1,a1,1
    8000554a:	00b69623          	sh	a1,12(a3)
  disk.desc[idx[1]].next = idx[2];
    8000554e:	fa842683          	lw	a3,-88(s0)
    80005552:	630c                	ld	a1,0(a4)
    80005554:	97ae                	add	a5,a5,a1
    80005556:	00d79723          	sh	a3,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    8000555a:	20050593          	addi	a1,a0,512
    8000555e:	0592                	slli	a1,a1,0x4
    80005560:	95c6                	add	a1,a1,a7
    80005562:	57fd                	li	a5,-1
    80005564:	02f58823          	sb	a5,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005568:	00469793          	slli	a5,a3,0x4
    8000556c:	00073803          	ld	a6,0(a4)
    80005570:	983e                	add	a6,a6,a5
    80005572:	6689                	lui	a3,0x2
    80005574:	03068693          	addi	a3,a3,48 # 2030 <_entry-0x7fffdfd0>
    80005578:	96b2                	add	a3,a3,a2
    8000557a:	96c6                	add	a3,a3,a7
    8000557c:	00d83023          	sd	a3,0(a6)
  disk.desc[idx[2]].len = 1;
    80005580:	6314                	ld	a3,0(a4)
    80005582:	96be                	add	a3,a3,a5
    80005584:	4605                	li	a2,1
    80005586:	c690                	sw	a2,8(a3)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005588:	6314                	ld	a3,0(a4)
    8000558a:	96be                	add	a3,a3,a5
    8000558c:	4809                	li	a6,2
    8000558e:	01069623          	sh	a6,12(a3)
  disk.desc[idx[2]].next = 0;
    80005592:	6314                	ld	a3,0(a4)
    80005594:	97b6                	add	a5,a5,a3
    80005596:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000559a:	00c9a223          	sw	a2,4(s3)
  disk.info[idx[0]].b = b;
    8000559e:	0335b423          	sd	s3,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800055a2:	6714                	ld	a3,8(a4)
    800055a4:	0026d783          	lhu	a5,2(a3)
    800055a8:	8b9d                	andi	a5,a5,7
    800055aa:	0786                	slli	a5,a5,0x1
    800055ac:	96be                	add	a3,a3,a5
    800055ae:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    800055b2:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800055b6:	6718                	ld	a4,8(a4)
    800055b8:	00275783          	lhu	a5,2(a4)
    800055bc:	2785                	addiw	a5,a5,1
    800055be:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800055c2:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800055c6:	100017b7          	lui	a5,0x10001
    800055ca:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800055ce:	0049a783          	lw	a5,4(s3)
    800055d2:	02c79163          	bne	a5,a2,800055f4 <virtio_disk_rw+0x196>
    sleep(b, &disk.vdisk_lock);
    800055d6:	0001b917          	auipc	s2,0x1b
    800055da:	b5290913          	addi	s2,s2,-1198 # 80020128 <disk+0x2128>
  while(b->disk == 1) {
    800055de:	84b2                	mv	s1,a2
    sleep(b, &disk.vdisk_lock);
    800055e0:	85ca                	mv	a1,s2
    800055e2:	854e                	mv	a0,s3
    800055e4:	ffffc097          	auipc	ra,0xffffc
    800055e8:	f90080e7          	jalr	-112(ra) # 80001574 <sleep>
  while(b->disk == 1) {
    800055ec:	0049a783          	lw	a5,4(s3)
    800055f0:	fe9788e3          	beq	a5,s1,800055e0 <virtio_disk_rw+0x182>
  }

  disk.info[idx[0]].b = 0;
    800055f4:	fa042903          	lw	s2,-96(s0)
    800055f8:	20090713          	addi	a4,s2,512
    800055fc:	0712                	slli	a4,a4,0x4
    800055fe:	00019797          	auipc	a5,0x19
    80005602:	a0278793          	addi	a5,a5,-1534 # 8001e000 <disk>
    80005606:	97ba                	add	a5,a5,a4
    80005608:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    8000560c:	0001b997          	auipc	s3,0x1b
    80005610:	9f498993          	addi	s3,s3,-1548 # 80020000 <disk+0x2000>
    80005614:	00491713          	slli	a4,s2,0x4
    80005618:	0009b783          	ld	a5,0(s3)
    8000561c:	97ba                	add	a5,a5,a4
    8000561e:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005622:	854a                	mv	a0,s2
    80005624:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005628:	00000097          	auipc	ra,0x0
    8000562c:	c52080e7          	jalr	-942(ra) # 8000527a <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005630:	8885                	andi	s1,s1,1
    80005632:	f0ed                	bnez	s1,80005614 <virtio_disk_rw+0x1b6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005634:	0001b517          	auipc	a0,0x1b
    80005638:	af450513          	addi	a0,a0,-1292 # 80020128 <disk+0x2128>
    8000563c:	00001097          	auipc	ra,0x1
    80005640:	ce6080e7          	jalr	-794(ra) # 80006322 <release>
}
    80005644:	60e6                	ld	ra,88(sp)
    80005646:	6446                	ld	s0,80(sp)
    80005648:	64a6                	ld	s1,72(sp)
    8000564a:	6906                	ld	s2,64(sp)
    8000564c:	79e2                	ld	s3,56(sp)
    8000564e:	7a42                	ld	s4,48(sp)
    80005650:	7aa2                	ld	s5,40(sp)
    80005652:	7b02                	ld	s6,32(sp)
    80005654:	6be2                	ld	s7,24(sp)
    80005656:	6c42                	ld	s8,16(sp)
    80005658:	6125                	addi	sp,sp,96
    8000565a:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000565c:	fa042503          	lw	a0,-96(s0)
    80005660:	00451613          	slli	a2,a0,0x4
  if(write)
    80005664:	00019597          	auipc	a1,0x19
    80005668:	99c58593          	addi	a1,a1,-1636 # 8001e000 <disk>
    8000566c:	20050793          	addi	a5,a0,512
    80005670:	0792                	slli	a5,a5,0x4
    80005672:	97ae                	add	a5,a5,a1
    80005674:	01803733          	snez	a4,s8
    80005678:	0ae7a423          	sw	a4,168(a5)
  buf0->reserved = 0;
    8000567c:	0a07a623          	sw	zero,172(a5)
  buf0->sector = sector;
    80005680:	0b77b823          	sd	s7,176(a5)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005684:	0001b717          	auipc	a4,0x1b
    80005688:	97c70713          	addi	a4,a4,-1668 # 80020000 <disk+0x2000>
    8000568c:	6314                	ld	a3,0(a4)
    8000568e:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005690:	6789                	lui	a5,0x2
    80005692:	0a878793          	addi	a5,a5,168 # 20a8 <_entry-0x7fffdf58>
    80005696:	97b2                	add	a5,a5,a2
    80005698:	97ae                	add	a5,a5,a1
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000569a:	e29c                	sd	a5,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000569c:	631c                	ld	a5,0(a4)
    8000569e:	97b2                	add	a5,a5,a2
    800056a0:	46c1                	li	a3,16
    800056a2:	c794                	sw	a3,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800056a4:	631c                	ld	a5,0(a4)
    800056a6:	97b2                	add	a5,a5,a2
    800056a8:	4685                	li	a3,1
    800056aa:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[0]].next = idx[1];
    800056ae:	fa442783          	lw	a5,-92(s0)
    800056b2:	6314                	ld	a3,0(a4)
    800056b4:	96b2                	add	a3,a3,a2
    800056b6:	00f69723          	sh	a5,14(a3)
  disk.desc[idx[1]].addr = (uint64) b->data;
    800056ba:	0792                	slli	a5,a5,0x4
    800056bc:	6314                	ld	a3,0(a4)
    800056be:	96be                	add	a3,a3,a5
    800056c0:	05898593          	addi	a1,s3,88
    800056c4:	e28c                	sd	a1,0(a3)
  disk.desc[idx[1]].len = BSIZE;
    800056c6:	6318                	ld	a4,0(a4)
    800056c8:	973e                	add	a4,a4,a5
    800056ca:	40000693          	li	a3,1024
    800056ce:	c714                	sw	a3,8(a4)
  if(write)
    800056d0:	e40c18e3          	bnez	s8,80005520 <virtio_disk_rw+0xc2>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800056d4:	0001b717          	auipc	a4,0x1b
    800056d8:	92c73703          	ld	a4,-1748(a4) # 80020000 <disk+0x2000>
    800056dc:	973e                	add	a4,a4,a5
    800056de:	4689                	li	a3,2
    800056e0:	00d71623          	sh	a3,12(a4)
    800056e4:	b5a9                	j	8000552e <virtio_disk_rw+0xd0>

00000000800056e6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800056e6:	1101                	addi	sp,sp,-32
    800056e8:	ec06                	sd	ra,24(sp)
    800056ea:	e822                	sd	s0,16(sp)
    800056ec:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800056ee:	0001b517          	auipc	a0,0x1b
    800056f2:	a3a50513          	addi	a0,a0,-1478 # 80020128 <disk+0x2128>
    800056f6:	00001097          	auipc	ra,0x1
    800056fa:	b7c080e7          	jalr	-1156(ra) # 80006272 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800056fe:	100017b7          	lui	a5,0x10001
    80005702:	53bc                	lw	a5,96(a5)
    80005704:	8b8d                	andi	a5,a5,3
    80005706:	10001737          	lui	a4,0x10001
    8000570a:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    8000570c:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005710:	0001b797          	auipc	a5,0x1b
    80005714:	8f078793          	addi	a5,a5,-1808 # 80020000 <disk+0x2000>
    80005718:	6b94                	ld	a3,16(a5)
    8000571a:	0207d703          	lhu	a4,32(a5)
    8000571e:	0026d783          	lhu	a5,2(a3)
    80005722:	06f70563          	beq	a4,a5,8000578c <virtio_disk_intr+0xa6>
    80005726:	e426                	sd	s1,8(sp)
    80005728:	e04a                	sd	s2,0(sp)
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000572a:	00019917          	auipc	s2,0x19
    8000572e:	8d690913          	addi	s2,s2,-1834 # 8001e000 <disk>
    80005732:	0001b497          	auipc	s1,0x1b
    80005736:	8ce48493          	addi	s1,s1,-1842 # 80020000 <disk+0x2000>
    __sync_synchronize();
    8000573a:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000573e:	6898                	ld	a4,16(s1)
    80005740:	0204d783          	lhu	a5,32(s1)
    80005744:	8b9d                	andi	a5,a5,7
    80005746:	078e                	slli	a5,a5,0x3
    80005748:	97ba                	add	a5,a5,a4
    8000574a:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000574c:	20078713          	addi	a4,a5,512
    80005750:	0712                	slli	a4,a4,0x4
    80005752:	974a                	add	a4,a4,s2
    80005754:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005758:	e731                	bnez	a4,800057a4 <virtio_disk_intr+0xbe>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000575a:	20078793          	addi	a5,a5,512
    8000575e:	0792                	slli	a5,a5,0x4
    80005760:	97ca                	add	a5,a5,s2
    80005762:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005764:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005768:	ffffc097          	auipc	ra,0xffffc
    8000576c:	f92080e7          	jalr	-110(ra) # 800016fa <wakeup>

    disk.used_idx += 1;
    80005770:	0204d783          	lhu	a5,32(s1)
    80005774:	2785                	addiw	a5,a5,1
    80005776:	17c2                	slli	a5,a5,0x30
    80005778:	93c1                	srli	a5,a5,0x30
    8000577a:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000577e:	6898                	ld	a4,16(s1)
    80005780:	00275703          	lhu	a4,2(a4)
    80005784:	faf71be3          	bne	a4,a5,8000573a <virtio_disk_intr+0x54>
    80005788:	64a2                	ld	s1,8(sp)
    8000578a:	6902                	ld	s2,0(sp)
  }

  release(&disk.vdisk_lock);
    8000578c:	0001b517          	auipc	a0,0x1b
    80005790:	99c50513          	addi	a0,a0,-1636 # 80020128 <disk+0x2128>
    80005794:	00001097          	auipc	ra,0x1
    80005798:	b8e080e7          	jalr	-1138(ra) # 80006322 <release>
}
    8000579c:	60e2                	ld	ra,24(sp)
    8000579e:	6442                	ld	s0,16(sp)
    800057a0:	6105                	addi	sp,sp,32
    800057a2:	8082                	ret
      panic("virtio_disk_intr status");
    800057a4:	00003517          	auipc	a0,0x3
    800057a8:	f9450513          	addi	a0,a0,-108 # 80008738 <etext+0x738>
    800057ac:	00000097          	auipc	ra,0x0
    800057b0:	546080e7          	jalr	1350(ra) # 80005cf2 <panic>

00000000800057b4 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800057b4:	1141                	addi	sp,sp,-16
    800057b6:	e406                	sd	ra,8(sp)
    800057b8:	e022                	sd	s0,0(sp)
    800057ba:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800057bc:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800057c0:	2781                	sext.w	a5,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800057c2:	0037961b          	slliw	a2,a5,0x3
    800057c6:	02004737          	lui	a4,0x2004
    800057ca:	963a                	add	a2,a2,a4
    800057cc:	0200c737          	lui	a4,0x200c
    800057d0:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800057d4:	000f46b7          	lui	a3,0xf4
    800057d8:	24068693          	addi	a3,a3,576 # f4240 <_entry-0x7ff0bdc0>
    800057dc:	9736                	add	a4,a4,a3
    800057de:	e218                	sd	a4,0(a2)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800057e0:	00279713          	slli	a4,a5,0x2
    800057e4:	973e                	add	a4,a4,a5
    800057e6:	070e                	slli	a4,a4,0x3
    800057e8:	0001c797          	auipc	a5,0x1c
    800057ec:	81878793          	addi	a5,a5,-2024 # 80021000 <timer_scratch>
    800057f0:	97ba                	add	a5,a5,a4
  scratch[3] = CLINT_MTIMECMP(id);
    800057f2:	ef90                	sd	a2,24(a5)
  scratch[4] = interval;
    800057f4:	f394                	sd	a3,32(a5)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    800057f6:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800057fa:	00000797          	auipc	a5,0x0
    800057fe:	9b678793          	addi	a5,a5,-1610 # 800051b0 <timervec>
    80005802:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005806:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    8000580a:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    8000580e:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005812:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005816:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    8000581a:	30479073          	csrw	mie,a5
}
    8000581e:	60a2                	ld	ra,8(sp)
    80005820:	6402                	ld	s0,0(sp)
    80005822:	0141                	addi	sp,sp,16
    80005824:	8082                	ret

0000000080005826 <start>:
{
    80005826:	1141                	addi	sp,sp,-16
    80005828:	e406                	sd	ra,8(sp)
    8000582a:	e022                	sd	s0,0(sp)
    8000582c:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    8000582e:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005832:	7779                	lui	a4,0xffffe
    80005834:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd55bf>
    80005838:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    8000583a:	6705                	lui	a4,0x1
    8000583c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005840:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005842:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005846:	ffffb797          	auipc	a5,0xffffb
    8000584a:	aee78793          	addi	a5,a5,-1298 # 80000334 <main>
    8000584e:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005852:	4781                	li	a5,0
    80005854:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005858:	67c1                	lui	a5,0x10
    8000585a:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000585c:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005860:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005864:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005868:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    8000586c:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005870:	57fd                	li	a5,-1
    80005872:	83a9                	srli	a5,a5,0xa
    80005874:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005878:	47bd                	li	a5,15
    8000587a:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    8000587e:	00000097          	auipc	ra,0x0
    80005882:	f36080e7          	jalr	-202(ra) # 800057b4 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005886:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    8000588a:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    8000588c:	823e                	mv	tp,a5
  asm volatile("mret");
    8000588e:	30200073          	mret
}
    80005892:	60a2                	ld	ra,8(sp)
    80005894:	6402                	ld	s0,0(sp)
    80005896:	0141                	addi	sp,sp,16
    80005898:	8082                	ret

000000008000589a <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    8000589a:	711d                	addi	sp,sp,-96
    8000589c:	ec86                	sd	ra,88(sp)
    8000589e:	e8a2                	sd	s0,80(sp)
    800058a0:	e0ca                	sd	s2,64(sp)
    800058a2:	1080                	addi	s0,sp,96
  int i;

  for(i = 0; i < n; i++){
    800058a4:	04c05c63          	blez	a2,800058fc <consolewrite+0x62>
    800058a8:	e4a6                	sd	s1,72(sp)
    800058aa:	fc4e                	sd	s3,56(sp)
    800058ac:	f852                	sd	s4,48(sp)
    800058ae:	f456                	sd	s5,40(sp)
    800058b0:	f05a                	sd	s6,32(sp)
    800058b2:	ec5e                	sd	s7,24(sp)
    800058b4:	8a2a                	mv	s4,a0
    800058b6:	84ae                	mv	s1,a1
    800058b8:	89b2                	mv	s3,a2
    800058ba:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800058bc:	faf40b93          	addi	s7,s0,-81
    800058c0:	4b05                	li	s6,1
    800058c2:	5afd                	li	s5,-1
    800058c4:	86da                	mv	a3,s6
    800058c6:	8626                	mv	a2,s1
    800058c8:	85d2                	mv	a1,s4
    800058ca:	855e                	mv	a0,s7
    800058cc:	ffffc097          	auipc	ra,0xffffc
    800058d0:	09c080e7          	jalr	156(ra) # 80001968 <either_copyin>
    800058d4:	03550663          	beq	a0,s5,80005900 <consolewrite+0x66>
      break;
    uartputc(c);
    800058d8:	faf44503          	lbu	a0,-81(s0)
    800058dc:	00000097          	auipc	ra,0x0
    800058e0:	7d4080e7          	jalr	2004(ra) # 800060b0 <uartputc>
  for(i = 0; i < n; i++){
    800058e4:	2905                	addiw	s2,s2,1
    800058e6:	0485                	addi	s1,s1,1
    800058e8:	fd299ee3          	bne	s3,s2,800058c4 <consolewrite+0x2a>
    800058ec:	894e                	mv	s2,s3
    800058ee:	64a6                	ld	s1,72(sp)
    800058f0:	79e2                	ld	s3,56(sp)
    800058f2:	7a42                	ld	s4,48(sp)
    800058f4:	7aa2                	ld	s5,40(sp)
    800058f6:	7b02                	ld	s6,32(sp)
    800058f8:	6be2                	ld	s7,24(sp)
    800058fa:	a809                	j	8000590c <consolewrite+0x72>
    800058fc:	4901                	li	s2,0
    800058fe:	a039                	j	8000590c <consolewrite+0x72>
    80005900:	64a6                	ld	s1,72(sp)
    80005902:	79e2                	ld	s3,56(sp)
    80005904:	7a42                	ld	s4,48(sp)
    80005906:	7aa2                	ld	s5,40(sp)
    80005908:	7b02                	ld	s6,32(sp)
    8000590a:	6be2                	ld	s7,24(sp)
  }

  return i;
}
    8000590c:	854a                	mv	a0,s2
    8000590e:	60e6                	ld	ra,88(sp)
    80005910:	6446                	ld	s0,80(sp)
    80005912:	6906                	ld	s2,64(sp)
    80005914:	6125                	addi	sp,sp,96
    80005916:	8082                	ret

0000000080005918 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005918:	711d                	addi	sp,sp,-96
    8000591a:	ec86                	sd	ra,88(sp)
    8000591c:	e8a2                	sd	s0,80(sp)
    8000591e:	e4a6                	sd	s1,72(sp)
    80005920:	e0ca                	sd	s2,64(sp)
    80005922:	fc4e                	sd	s3,56(sp)
    80005924:	f852                	sd	s4,48(sp)
    80005926:	f456                	sd	s5,40(sp)
    80005928:	f05a                	sd	s6,32(sp)
    8000592a:	1080                	addi	s0,sp,96
    8000592c:	8aaa                	mv	s5,a0
    8000592e:	8a2e                	mv	s4,a1
    80005930:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005932:	8b32                	mv	s6,a2
  acquire(&cons.lock);
    80005934:	00024517          	auipc	a0,0x24
    80005938:	80c50513          	addi	a0,a0,-2036 # 80029140 <cons>
    8000593c:	00001097          	auipc	ra,0x1
    80005940:	936080e7          	jalr	-1738(ra) # 80006272 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005944:	00023497          	auipc	s1,0x23
    80005948:	7fc48493          	addi	s1,s1,2044 # 80029140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    8000594c:	00024917          	auipc	s2,0x24
    80005950:	88c90913          	addi	s2,s2,-1908 # 800291d8 <cons+0x98>
  while(n > 0){
    80005954:	0d305263          	blez	s3,80005a18 <consoleread+0x100>
    while(cons.r == cons.w){
    80005958:	0984a783          	lw	a5,152(s1)
    8000595c:	09c4a703          	lw	a4,156(s1)
    80005960:	0af71763          	bne	a4,a5,80005a0e <consoleread+0xf6>
      if(myproc()->killed){
    80005964:	ffffb097          	auipc	ra,0xffffb
    80005968:	53e080e7          	jalr	1342(ra) # 80000ea2 <myproc>
    8000596c:	551c                	lw	a5,40(a0)
    8000596e:	e7ad                	bnez	a5,800059d8 <consoleread+0xc0>
      sleep(&cons.r, &cons.lock);
    80005970:	85a6                	mv	a1,s1
    80005972:	854a                	mv	a0,s2
    80005974:	ffffc097          	auipc	ra,0xffffc
    80005978:	c00080e7          	jalr	-1024(ra) # 80001574 <sleep>
    while(cons.r == cons.w){
    8000597c:	0984a783          	lw	a5,152(s1)
    80005980:	09c4a703          	lw	a4,156(s1)
    80005984:	fef700e3          	beq	a4,a5,80005964 <consoleread+0x4c>
    80005988:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    8000598a:	00023717          	auipc	a4,0x23
    8000598e:	7b670713          	addi	a4,a4,1974 # 80029140 <cons>
    80005992:	0017869b          	addiw	a3,a5,1
    80005996:	08d72c23          	sw	a3,152(a4)
    8000599a:	07f7f693          	andi	a3,a5,127
    8000599e:	9736                	add	a4,a4,a3
    800059a0:	01874703          	lbu	a4,24(a4)
    800059a4:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    800059a8:	4691                	li	a3,4
    800059aa:	04db8a63          	beq	s7,a3,800059fe <consoleread+0xe6>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    800059ae:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800059b2:	4685                	li	a3,1
    800059b4:	faf40613          	addi	a2,s0,-81
    800059b8:	85d2                	mv	a1,s4
    800059ba:	8556                	mv	a0,s5
    800059bc:	ffffc097          	auipc	ra,0xffffc
    800059c0:	f56080e7          	jalr	-170(ra) # 80001912 <either_copyout>
    800059c4:	57fd                	li	a5,-1
    800059c6:	04f50863          	beq	a0,a5,80005a16 <consoleread+0xfe>
      break;

    dst++;
    800059ca:	0a05                	addi	s4,s4,1
    --n;
    800059cc:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    800059ce:	47a9                	li	a5,10
    800059d0:	04fb8f63          	beq	s7,a5,80005a2e <consoleread+0x116>
    800059d4:	6be2                	ld	s7,24(sp)
    800059d6:	bfbd                	j	80005954 <consoleread+0x3c>
        release(&cons.lock);
    800059d8:	00023517          	auipc	a0,0x23
    800059dc:	76850513          	addi	a0,a0,1896 # 80029140 <cons>
    800059e0:	00001097          	auipc	ra,0x1
    800059e4:	942080e7          	jalr	-1726(ra) # 80006322 <release>
        return -1;
    800059e8:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    800059ea:	60e6                	ld	ra,88(sp)
    800059ec:	6446                	ld	s0,80(sp)
    800059ee:	64a6                	ld	s1,72(sp)
    800059f0:	6906                	ld	s2,64(sp)
    800059f2:	79e2                	ld	s3,56(sp)
    800059f4:	7a42                	ld	s4,48(sp)
    800059f6:	7aa2                	ld	s5,40(sp)
    800059f8:	7b02                	ld	s6,32(sp)
    800059fa:	6125                	addi	sp,sp,96
    800059fc:	8082                	ret
      if(n < target){
    800059fe:	0169fa63          	bgeu	s3,s6,80005a12 <consoleread+0xfa>
        cons.r--;
    80005a02:	00023717          	auipc	a4,0x23
    80005a06:	7cf72b23          	sw	a5,2006(a4) # 800291d8 <cons+0x98>
    80005a0a:	6be2                	ld	s7,24(sp)
    80005a0c:	a031                	j	80005a18 <consoleread+0x100>
    80005a0e:	ec5e                	sd	s7,24(sp)
    80005a10:	bfad                	j	8000598a <consoleread+0x72>
    80005a12:	6be2                	ld	s7,24(sp)
    80005a14:	a011                	j	80005a18 <consoleread+0x100>
    80005a16:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80005a18:	00023517          	auipc	a0,0x23
    80005a1c:	72850513          	addi	a0,a0,1832 # 80029140 <cons>
    80005a20:	00001097          	auipc	ra,0x1
    80005a24:	902080e7          	jalr	-1790(ra) # 80006322 <release>
  return target - n;
    80005a28:	413b053b          	subw	a0,s6,s3
    80005a2c:	bf7d                	j	800059ea <consoleread+0xd2>
    80005a2e:	6be2                	ld	s7,24(sp)
    80005a30:	b7e5                	j	80005a18 <consoleread+0x100>

0000000080005a32 <consputc>:
{
    80005a32:	1141                	addi	sp,sp,-16
    80005a34:	e406                	sd	ra,8(sp)
    80005a36:	e022                	sd	s0,0(sp)
    80005a38:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005a3a:	10000793          	li	a5,256
    80005a3e:	00f50a63          	beq	a0,a5,80005a52 <consputc+0x20>
    uartputc_sync(c);
    80005a42:	00000097          	auipc	ra,0x0
    80005a46:	590080e7          	jalr	1424(ra) # 80005fd2 <uartputc_sync>
}
    80005a4a:	60a2                	ld	ra,8(sp)
    80005a4c:	6402                	ld	s0,0(sp)
    80005a4e:	0141                	addi	sp,sp,16
    80005a50:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005a52:	4521                	li	a0,8
    80005a54:	00000097          	auipc	ra,0x0
    80005a58:	57e080e7          	jalr	1406(ra) # 80005fd2 <uartputc_sync>
    80005a5c:	02000513          	li	a0,32
    80005a60:	00000097          	auipc	ra,0x0
    80005a64:	572080e7          	jalr	1394(ra) # 80005fd2 <uartputc_sync>
    80005a68:	4521                	li	a0,8
    80005a6a:	00000097          	auipc	ra,0x0
    80005a6e:	568080e7          	jalr	1384(ra) # 80005fd2 <uartputc_sync>
    80005a72:	bfe1                	j	80005a4a <consputc+0x18>

0000000080005a74 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005a74:	7179                	addi	sp,sp,-48
    80005a76:	f406                	sd	ra,40(sp)
    80005a78:	f022                	sd	s0,32(sp)
    80005a7a:	ec26                	sd	s1,24(sp)
    80005a7c:	1800                	addi	s0,sp,48
    80005a7e:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005a80:	00023517          	auipc	a0,0x23
    80005a84:	6c050513          	addi	a0,a0,1728 # 80029140 <cons>
    80005a88:	00000097          	auipc	ra,0x0
    80005a8c:	7ea080e7          	jalr	2026(ra) # 80006272 <acquire>

  switch(c){
    80005a90:	47d5                	li	a5,21
    80005a92:	0af48463          	beq	s1,a5,80005b3a <consoleintr+0xc6>
    80005a96:	0297c963          	blt	a5,s1,80005ac8 <consoleintr+0x54>
    80005a9a:	47a1                	li	a5,8
    80005a9c:	10f48063          	beq	s1,a5,80005b9c <consoleintr+0x128>
    80005aa0:	47c1                	li	a5,16
    80005aa2:	12f49363          	bne	s1,a5,80005bc8 <consoleintr+0x154>
  case C('P'):  // Print process list.
    procdump();
    80005aa6:	ffffc097          	auipc	ra,0xffffc
    80005aaa:	f18080e7          	jalr	-232(ra) # 800019be <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005aae:	00023517          	auipc	a0,0x23
    80005ab2:	69250513          	addi	a0,a0,1682 # 80029140 <cons>
    80005ab6:	00001097          	auipc	ra,0x1
    80005aba:	86c080e7          	jalr	-1940(ra) # 80006322 <release>
}
    80005abe:	70a2                	ld	ra,40(sp)
    80005ac0:	7402                	ld	s0,32(sp)
    80005ac2:	64e2                	ld	s1,24(sp)
    80005ac4:	6145                	addi	sp,sp,48
    80005ac6:	8082                	ret
  switch(c){
    80005ac8:	07f00793          	li	a5,127
    80005acc:	0cf48863          	beq	s1,a5,80005b9c <consoleintr+0x128>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005ad0:	00023717          	auipc	a4,0x23
    80005ad4:	67070713          	addi	a4,a4,1648 # 80029140 <cons>
    80005ad8:	0a072783          	lw	a5,160(a4)
    80005adc:	09872703          	lw	a4,152(a4)
    80005ae0:	9f99                	subw	a5,a5,a4
    80005ae2:	07f00713          	li	a4,127
    80005ae6:	fcf764e3          	bltu	a4,a5,80005aae <consoleintr+0x3a>
      c = (c == '\r') ? '\n' : c;
    80005aea:	47b5                	li	a5,13
    80005aec:	0ef48163          	beq	s1,a5,80005bce <consoleintr+0x15a>
      consputc(c);
    80005af0:	8526                	mv	a0,s1
    80005af2:	00000097          	auipc	ra,0x0
    80005af6:	f40080e7          	jalr	-192(ra) # 80005a32 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005afa:	00023797          	auipc	a5,0x23
    80005afe:	64678793          	addi	a5,a5,1606 # 80029140 <cons>
    80005b02:	0a07a703          	lw	a4,160(a5)
    80005b06:	0017069b          	addiw	a3,a4,1
    80005b0a:	8636                	mv	a2,a3
    80005b0c:	0ad7a023          	sw	a3,160(a5)
    80005b10:	07f77713          	andi	a4,a4,127
    80005b14:	97ba                	add	a5,a5,a4
    80005b16:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005b1a:	47a9                	li	a5,10
    80005b1c:	0cf48f63          	beq	s1,a5,80005bfa <consoleintr+0x186>
    80005b20:	4791                	li	a5,4
    80005b22:	0cf48c63          	beq	s1,a5,80005bfa <consoleintr+0x186>
    80005b26:	00023797          	auipc	a5,0x23
    80005b2a:	6b27a783          	lw	a5,1714(a5) # 800291d8 <cons+0x98>
    80005b2e:	0807879b          	addiw	a5,a5,128
    80005b32:	f6f69ee3          	bne	a3,a5,80005aae <consoleintr+0x3a>
    80005b36:	863e                	mv	a2,a5
    80005b38:	a0c9                	j	80005bfa <consoleintr+0x186>
    80005b3a:	e84a                	sd	s2,16(sp)
    80005b3c:	e44e                	sd	s3,8(sp)
    while(cons.e != cons.w &&
    80005b3e:	00023717          	auipc	a4,0x23
    80005b42:	60270713          	addi	a4,a4,1538 # 80029140 <cons>
    80005b46:	0a072783          	lw	a5,160(a4)
    80005b4a:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005b4e:	00023497          	auipc	s1,0x23
    80005b52:	5f248493          	addi	s1,s1,1522 # 80029140 <cons>
    while(cons.e != cons.w &&
    80005b56:	4929                	li	s2,10
      consputc(BACKSPACE);
    80005b58:	10000993          	li	s3,256
    while(cons.e != cons.w &&
    80005b5c:	02f70a63          	beq	a4,a5,80005b90 <consoleintr+0x11c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005b60:	37fd                	addiw	a5,a5,-1
    80005b62:	07f7f713          	andi	a4,a5,127
    80005b66:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005b68:	01874703          	lbu	a4,24(a4)
    80005b6c:	03270563          	beq	a4,s2,80005b96 <consoleintr+0x122>
      cons.e--;
    80005b70:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005b74:	854e                	mv	a0,s3
    80005b76:	00000097          	auipc	ra,0x0
    80005b7a:	ebc080e7          	jalr	-324(ra) # 80005a32 <consputc>
    while(cons.e != cons.w &&
    80005b7e:	0a04a783          	lw	a5,160(s1)
    80005b82:	09c4a703          	lw	a4,156(s1)
    80005b86:	fcf71de3          	bne	a4,a5,80005b60 <consoleintr+0xec>
    80005b8a:	6942                	ld	s2,16(sp)
    80005b8c:	69a2                	ld	s3,8(sp)
    80005b8e:	b705                	j	80005aae <consoleintr+0x3a>
    80005b90:	6942                	ld	s2,16(sp)
    80005b92:	69a2                	ld	s3,8(sp)
    80005b94:	bf29                	j	80005aae <consoleintr+0x3a>
    80005b96:	6942                	ld	s2,16(sp)
    80005b98:	69a2                	ld	s3,8(sp)
    80005b9a:	bf11                	j	80005aae <consoleintr+0x3a>
    if(cons.e != cons.w){
    80005b9c:	00023717          	auipc	a4,0x23
    80005ba0:	5a470713          	addi	a4,a4,1444 # 80029140 <cons>
    80005ba4:	0a072783          	lw	a5,160(a4)
    80005ba8:	09c72703          	lw	a4,156(a4)
    80005bac:	f0f701e3          	beq	a4,a5,80005aae <consoleintr+0x3a>
      cons.e--;
    80005bb0:	37fd                	addiw	a5,a5,-1
    80005bb2:	00023717          	auipc	a4,0x23
    80005bb6:	62f72723          	sw	a5,1582(a4) # 800291e0 <cons+0xa0>
      consputc(BACKSPACE);
    80005bba:	10000513          	li	a0,256
    80005bbe:	00000097          	auipc	ra,0x0
    80005bc2:	e74080e7          	jalr	-396(ra) # 80005a32 <consputc>
    80005bc6:	b5e5                	j	80005aae <consoleintr+0x3a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005bc8:	ee0483e3          	beqz	s1,80005aae <consoleintr+0x3a>
    80005bcc:	b711                	j	80005ad0 <consoleintr+0x5c>
      consputc(c);
    80005bce:	4529                	li	a0,10
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	e62080e7          	jalr	-414(ra) # 80005a32 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005bd8:	00023797          	auipc	a5,0x23
    80005bdc:	56878793          	addi	a5,a5,1384 # 80029140 <cons>
    80005be0:	0a07a703          	lw	a4,160(a5)
    80005be4:	0017069b          	addiw	a3,a4,1
    80005be8:	8636                	mv	a2,a3
    80005bea:	0ad7a023          	sw	a3,160(a5)
    80005bee:	07f77713          	andi	a4,a4,127
    80005bf2:	97ba                	add	a5,a5,a4
    80005bf4:	4729                	li	a4,10
    80005bf6:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005bfa:	00023797          	auipc	a5,0x23
    80005bfe:	5ec7a123          	sw	a2,1506(a5) # 800291dc <cons+0x9c>
        wakeup(&cons.r);
    80005c02:	00023517          	auipc	a0,0x23
    80005c06:	5d650513          	addi	a0,a0,1494 # 800291d8 <cons+0x98>
    80005c0a:	ffffc097          	auipc	ra,0xffffc
    80005c0e:	af0080e7          	jalr	-1296(ra) # 800016fa <wakeup>
    80005c12:	bd71                	j	80005aae <consoleintr+0x3a>

0000000080005c14 <consoleinit>:

void
consoleinit(void)
{
    80005c14:	1141                	addi	sp,sp,-16
    80005c16:	e406                	sd	ra,8(sp)
    80005c18:	e022                	sd	s0,0(sp)
    80005c1a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005c1c:	00003597          	auipc	a1,0x3
    80005c20:	b3458593          	addi	a1,a1,-1228 # 80008750 <etext+0x750>
    80005c24:	00023517          	auipc	a0,0x23
    80005c28:	51c50513          	addi	a0,a0,1308 # 80029140 <cons>
    80005c2c:	00000097          	auipc	ra,0x0
    80005c30:	5b2080e7          	jalr	1458(ra) # 800061de <initlock>

  uartinit();
    80005c34:	00000097          	auipc	ra,0x0
    80005c38:	344080e7          	jalr	836(ra) # 80005f78 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005c3c:	00016797          	auipc	a5,0x16
    80005c40:	68c78793          	addi	a5,a5,1676 # 8001c2c8 <devsw>
    80005c44:	00000717          	auipc	a4,0x0
    80005c48:	cd470713          	addi	a4,a4,-812 # 80005918 <consoleread>
    80005c4c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005c4e:	00000717          	auipc	a4,0x0
    80005c52:	c4c70713          	addi	a4,a4,-948 # 8000589a <consolewrite>
    80005c56:	ef98                	sd	a4,24(a5)
}
    80005c58:	60a2                	ld	ra,8(sp)
    80005c5a:	6402                	ld	s0,0(sp)
    80005c5c:	0141                	addi	sp,sp,16
    80005c5e:	8082                	ret

0000000080005c60 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005c60:	7179                	addi	sp,sp,-48
    80005c62:	f406                	sd	ra,40(sp)
    80005c64:	f022                	sd	s0,32(sp)
    80005c66:	ec26                	sd	s1,24(sp)
    80005c68:	e84a                	sd	s2,16(sp)
    80005c6a:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005c6c:	c219                	beqz	a2,80005c72 <printint+0x12>
    80005c6e:	06054e63          	bltz	a0,80005cea <printint+0x8a>
    x = -xx;
  else
    x = xx;
    80005c72:	4e01                	li	t3,0

  i = 0;
    80005c74:	fd040313          	addi	t1,s0,-48
    x = xx;
    80005c78:	869a                	mv	a3,t1
  i = 0;
    80005c7a:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    80005c7c:	00003817          	auipc	a6,0x3
    80005c80:	cf480813          	addi	a6,a6,-780 # 80008970 <digits>
    80005c84:	88be                	mv	a7,a5
    80005c86:	0017861b          	addiw	a2,a5,1
    80005c8a:	87b2                	mv	a5,a2
    80005c8c:	02b5773b          	remuw	a4,a0,a1
    80005c90:	1702                	slli	a4,a4,0x20
    80005c92:	9301                	srli	a4,a4,0x20
    80005c94:	9742                	add	a4,a4,a6
    80005c96:	00074703          	lbu	a4,0(a4)
    80005c9a:	00e68023          	sb	a4,0(a3)
  } while((x /= base) != 0);
    80005c9e:	872a                	mv	a4,a0
    80005ca0:	02b5553b          	divuw	a0,a0,a1
    80005ca4:	0685                	addi	a3,a3,1
    80005ca6:	fcb77fe3          	bgeu	a4,a1,80005c84 <printint+0x24>

  if(sign)
    80005caa:	000e0c63          	beqz	t3,80005cc2 <printint+0x62>
    buf[i++] = '-';
    80005cae:	fe060793          	addi	a5,a2,-32
    80005cb2:	00878633          	add	a2,a5,s0
    80005cb6:	02d00793          	li	a5,45
    80005cba:	fef60823          	sb	a5,-16(a2)
    80005cbe:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    80005cc2:	fff7891b          	addiw	s2,a5,-1
    80005cc6:	006784b3          	add	s1,a5,t1
    consputc(buf[i]);
    80005cca:	fff4c503          	lbu	a0,-1(s1)
    80005cce:	00000097          	auipc	ra,0x0
    80005cd2:	d64080e7          	jalr	-668(ra) # 80005a32 <consputc>
  while(--i >= 0)
    80005cd6:	397d                	addiw	s2,s2,-1
    80005cd8:	14fd                	addi	s1,s1,-1
    80005cda:	fe0958e3          	bgez	s2,80005cca <printint+0x6a>
}
    80005cde:	70a2                	ld	ra,40(sp)
    80005ce0:	7402                	ld	s0,32(sp)
    80005ce2:	64e2                	ld	s1,24(sp)
    80005ce4:	6942                	ld	s2,16(sp)
    80005ce6:	6145                	addi	sp,sp,48
    80005ce8:	8082                	ret
    x = -xx;
    80005cea:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005cee:	4e05                	li	t3,1
    x = -xx;
    80005cf0:	b751                	j	80005c74 <printint+0x14>

0000000080005cf2 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005cf2:	1101                	addi	sp,sp,-32
    80005cf4:	ec06                	sd	ra,24(sp)
    80005cf6:	e822                	sd	s0,16(sp)
    80005cf8:	e426                	sd	s1,8(sp)
    80005cfa:	1000                	addi	s0,sp,32
    80005cfc:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005cfe:	00023797          	auipc	a5,0x23
    80005d02:	5007a123          	sw	zero,1282(a5) # 80029200 <pr+0x18>
  printf("panic: ");
    80005d06:	00003517          	auipc	a0,0x3
    80005d0a:	a5250513          	addi	a0,a0,-1454 # 80008758 <etext+0x758>
    80005d0e:	00000097          	auipc	ra,0x0
    80005d12:	02e080e7          	jalr	46(ra) # 80005d3c <printf>
  printf(s);
    80005d16:	8526                	mv	a0,s1
    80005d18:	00000097          	auipc	ra,0x0
    80005d1c:	024080e7          	jalr	36(ra) # 80005d3c <printf>
  printf("\n");
    80005d20:	00002517          	auipc	a0,0x2
    80005d24:	2f850513          	addi	a0,a0,760 # 80008018 <etext+0x18>
    80005d28:	00000097          	auipc	ra,0x0
    80005d2c:	014080e7          	jalr	20(ra) # 80005d3c <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005d30:	4785                	li	a5,1
    80005d32:	00006717          	auipc	a4,0x6
    80005d36:	2ef72523          	sw	a5,746(a4) # 8000c01c <panicked>
  for(;;)
    80005d3a:	a001                	j	80005d3a <panic+0x48>

0000000080005d3c <printf>:
{
    80005d3c:	7131                	addi	sp,sp,-192
    80005d3e:	fc86                	sd	ra,120(sp)
    80005d40:	f8a2                	sd	s0,112(sp)
    80005d42:	e8d2                	sd	s4,80(sp)
    80005d44:	ec6e                	sd	s11,24(sp)
    80005d46:	0100                	addi	s0,sp,128
    80005d48:	8a2a                	mv	s4,a0
    80005d4a:	e40c                	sd	a1,8(s0)
    80005d4c:	e810                	sd	a2,16(s0)
    80005d4e:	ec14                	sd	a3,24(s0)
    80005d50:	f018                	sd	a4,32(s0)
    80005d52:	f41c                	sd	a5,40(s0)
    80005d54:	03043823          	sd	a6,48(s0)
    80005d58:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005d5c:	00023d97          	auipc	s11,0x23
    80005d60:	4a4dad83          	lw	s11,1188(s11) # 80029200 <pr+0x18>
  if(locking)
    80005d64:	040d9463          	bnez	s11,80005dac <printf+0x70>
  if (fmt == 0)
    80005d68:	040a0b63          	beqz	s4,80005dbe <printf+0x82>
  va_start(ap, fmt);
    80005d6c:	00840793          	addi	a5,s0,8
    80005d70:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005d74:	000a4503          	lbu	a0,0(s4)
    80005d78:	18050c63          	beqz	a0,80005f10 <printf+0x1d4>
    80005d7c:	f4a6                	sd	s1,104(sp)
    80005d7e:	f0ca                	sd	s2,96(sp)
    80005d80:	ecce                	sd	s3,88(sp)
    80005d82:	e4d6                	sd	s5,72(sp)
    80005d84:	e0da                	sd	s6,64(sp)
    80005d86:	fc5e                	sd	s7,56(sp)
    80005d88:	f862                	sd	s8,48(sp)
    80005d8a:	f466                	sd	s9,40(sp)
    80005d8c:	f06a                	sd	s10,32(sp)
    80005d8e:	4981                	li	s3,0
    if(c != '%'){
    80005d90:	02500b13          	li	s6,37
    switch(c){
    80005d94:	07000b93          	li	s7,112
  consputc('x');
    80005d98:	07800c93          	li	s9,120
    80005d9c:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005d9e:	00003a97          	auipc	s5,0x3
    80005da2:	bd2a8a93          	addi	s5,s5,-1070 # 80008970 <digits>
    switch(c){
    80005da6:	07300c13          	li	s8,115
    80005daa:	a0b9                	j	80005df8 <printf+0xbc>
    acquire(&pr.lock);
    80005dac:	00023517          	auipc	a0,0x23
    80005db0:	43c50513          	addi	a0,a0,1084 # 800291e8 <pr>
    80005db4:	00000097          	auipc	ra,0x0
    80005db8:	4be080e7          	jalr	1214(ra) # 80006272 <acquire>
    80005dbc:	b775                	j	80005d68 <printf+0x2c>
    80005dbe:	f4a6                	sd	s1,104(sp)
    80005dc0:	f0ca                	sd	s2,96(sp)
    80005dc2:	ecce                	sd	s3,88(sp)
    80005dc4:	e4d6                	sd	s5,72(sp)
    80005dc6:	e0da                	sd	s6,64(sp)
    80005dc8:	fc5e                	sd	s7,56(sp)
    80005dca:	f862                	sd	s8,48(sp)
    80005dcc:	f466                	sd	s9,40(sp)
    80005dce:	f06a                	sd	s10,32(sp)
    panic("null fmt");
    80005dd0:	00003517          	auipc	a0,0x3
    80005dd4:	99850513          	addi	a0,a0,-1640 # 80008768 <etext+0x768>
    80005dd8:	00000097          	auipc	ra,0x0
    80005ddc:	f1a080e7          	jalr	-230(ra) # 80005cf2 <panic>
      consputc(c);
    80005de0:	00000097          	auipc	ra,0x0
    80005de4:	c52080e7          	jalr	-942(ra) # 80005a32 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005de8:	0019879b          	addiw	a5,s3,1
    80005dec:	89be                	mv	s3,a5
    80005dee:	97d2                	add	a5,a5,s4
    80005df0:	0007c503          	lbu	a0,0(a5)
    80005df4:	10050563          	beqz	a0,80005efe <printf+0x1c2>
    if(c != '%'){
    80005df8:	ff6514e3          	bne	a0,s6,80005de0 <printf+0xa4>
    c = fmt[++i] & 0xff;
    80005dfc:	0019879b          	addiw	a5,s3,1
    80005e00:	89be                	mv	s3,a5
    80005e02:	97d2                	add	a5,a5,s4
    80005e04:	0007c783          	lbu	a5,0(a5)
    80005e08:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005e0c:	10078a63          	beqz	a5,80005f20 <printf+0x1e4>
    switch(c){
    80005e10:	05778a63          	beq	a5,s7,80005e64 <printf+0x128>
    80005e14:	02fbf463          	bgeu	s7,a5,80005e3c <printf+0x100>
    80005e18:	09878763          	beq	a5,s8,80005ea6 <printf+0x16a>
    80005e1c:	0d979663          	bne	a5,s9,80005ee8 <printf+0x1ac>
      printint(va_arg(ap, int), 16, 1);
    80005e20:	f8843783          	ld	a5,-120(s0)
    80005e24:	00878713          	addi	a4,a5,8
    80005e28:	f8e43423          	sd	a4,-120(s0)
    80005e2c:	4605                	li	a2,1
    80005e2e:	85ea                	mv	a1,s10
    80005e30:	4388                	lw	a0,0(a5)
    80005e32:	00000097          	auipc	ra,0x0
    80005e36:	e2e080e7          	jalr	-466(ra) # 80005c60 <printint>
      break;
    80005e3a:	b77d                	j	80005de8 <printf+0xac>
    switch(c){
    80005e3c:	0b678063          	beq	a5,s6,80005edc <printf+0x1a0>
    80005e40:	06400713          	li	a4,100
    80005e44:	0ae79263          	bne	a5,a4,80005ee8 <printf+0x1ac>
      printint(va_arg(ap, int), 10, 1);
    80005e48:	f8843783          	ld	a5,-120(s0)
    80005e4c:	00878713          	addi	a4,a5,8
    80005e50:	f8e43423          	sd	a4,-120(s0)
    80005e54:	4605                	li	a2,1
    80005e56:	45a9                	li	a1,10
    80005e58:	4388                	lw	a0,0(a5)
    80005e5a:	00000097          	auipc	ra,0x0
    80005e5e:	e06080e7          	jalr	-506(ra) # 80005c60 <printint>
      break;
    80005e62:	b759                	j	80005de8 <printf+0xac>
      printptr(va_arg(ap, uint64));
    80005e64:	f8843783          	ld	a5,-120(s0)
    80005e68:	00878713          	addi	a4,a5,8
    80005e6c:	f8e43423          	sd	a4,-120(s0)
    80005e70:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005e74:	03000513          	li	a0,48
    80005e78:	00000097          	auipc	ra,0x0
    80005e7c:	bba080e7          	jalr	-1094(ra) # 80005a32 <consputc>
  consputc('x');
    80005e80:	8566                	mv	a0,s9
    80005e82:	00000097          	auipc	ra,0x0
    80005e86:	bb0080e7          	jalr	-1104(ra) # 80005a32 <consputc>
    80005e8a:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005e8c:	03c95793          	srli	a5,s2,0x3c
    80005e90:	97d6                	add	a5,a5,s5
    80005e92:	0007c503          	lbu	a0,0(a5)
    80005e96:	00000097          	auipc	ra,0x0
    80005e9a:	b9c080e7          	jalr	-1124(ra) # 80005a32 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005e9e:	0912                	slli	s2,s2,0x4
    80005ea0:	34fd                	addiw	s1,s1,-1
    80005ea2:	f4ed                	bnez	s1,80005e8c <printf+0x150>
    80005ea4:	b791                	j	80005de8 <printf+0xac>
      if((s = va_arg(ap, char*)) == 0)
    80005ea6:	f8843783          	ld	a5,-120(s0)
    80005eaa:	00878713          	addi	a4,a5,8
    80005eae:	f8e43423          	sd	a4,-120(s0)
    80005eb2:	6384                	ld	s1,0(a5)
    80005eb4:	cc89                	beqz	s1,80005ece <printf+0x192>
      for(; *s; s++)
    80005eb6:	0004c503          	lbu	a0,0(s1)
    80005eba:	d51d                	beqz	a0,80005de8 <printf+0xac>
        consputc(*s);
    80005ebc:	00000097          	auipc	ra,0x0
    80005ec0:	b76080e7          	jalr	-1162(ra) # 80005a32 <consputc>
      for(; *s; s++)
    80005ec4:	0485                	addi	s1,s1,1
    80005ec6:	0004c503          	lbu	a0,0(s1)
    80005eca:	f96d                	bnez	a0,80005ebc <printf+0x180>
    80005ecc:	bf31                	j	80005de8 <printf+0xac>
        s = "(null)";
    80005ece:	00003497          	auipc	s1,0x3
    80005ed2:	89248493          	addi	s1,s1,-1902 # 80008760 <etext+0x760>
      for(; *s; s++)
    80005ed6:	02800513          	li	a0,40
    80005eda:	b7cd                	j	80005ebc <printf+0x180>
      consputc('%');
    80005edc:	855a                	mv	a0,s6
    80005ede:	00000097          	auipc	ra,0x0
    80005ee2:	b54080e7          	jalr	-1196(ra) # 80005a32 <consputc>
      break;
    80005ee6:	b709                	j	80005de8 <printf+0xac>
      consputc('%');
    80005ee8:	855a                	mv	a0,s6
    80005eea:	00000097          	auipc	ra,0x0
    80005eee:	b48080e7          	jalr	-1208(ra) # 80005a32 <consputc>
      consputc(c);
    80005ef2:	8526                	mv	a0,s1
    80005ef4:	00000097          	auipc	ra,0x0
    80005ef8:	b3e080e7          	jalr	-1218(ra) # 80005a32 <consputc>
      break;
    80005efc:	b5f5                	j	80005de8 <printf+0xac>
    80005efe:	74a6                	ld	s1,104(sp)
    80005f00:	7906                	ld	s2,96(sp)
    80005f02:	69e6                	ld	s3,88(sp)
    80005f04:	6aa6                	ld	s5,72(sp)
    80005f06:	6b06                	ld	s6,64(sp)
    80005f08:	7be2                	ld	s7,56(sp)
    80005f0a:	7c42                	ld	s8,48(sp)
    80005f0c:	7ca2                	ld	s9,40(sp)
    80005f0e:	7d02                	ld	s10,32(sp)
  if(locking)
    80005f10:	020d9263          	bnez	s11,80005f34 <printf+0x1f8>
}
    80005f14:	70e6                	ld	ra,120(sp)
    80005f16:	7446                	ld	s0,112(sp)
    80005f18:	6a46                	ld	s4,80(sp)
    80005f1a:	6de2                	ld	s11,24(sp)
    80005f1c:	6129                	addi	sp,sp,192
    80005f1e:	8082                	ret
    80005f20:	74a6                	ld	s1,104(sp)
    80005f22:	7906                	ld	s2,96(sp)
    80005f24:	69e6                	ld	s3,88(sp)
    80005f26:	6aa6                	ld	s5,72(sp)
    80005f28:	6b06                	ld	s6,64(sp)
    80005f2a:	7be2                	ld	s7,56(sp)
    80005f2c:	7c42                	ld	s8,48(sp)
    80005f2e:	7ca2                	ld	s9,40(sp)
    80005f30:	7d02                	ld	s10,32(sp)
    80005f32:	bff9                	j	80005f10 <printf+0x1d4>
    release(&pr.lock);
    80005f34:	00023517          	auipc	a0,0x23
    80005f38:	2b450513          	addi	a0,a0,692 # 800291e8 <pr>
    80005f3c:	00000097          	auipc	ra,0x0
    80005f40:	3e6080e7          	jalr	998(ra) # 80006322 <release>
}
    80005f44:	bfc1                	j	80005f14 <printf+0x1d8>

0000000080005f46 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005f46:	1101                	addi	sp,sp,-32
    80005f48:	ec06                	sd	ra,24(sp)
    80005f4a:	e822                	sd	s0,16(sp)
    80005f4c:	e426                	sd	s1,8(sp)
    80005f4e:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80005f50:	00023497          	auipc	s1,0x23
    80005f54:	29848493          	addi	s1,s1,664 # 800291e8 <pr>
    80005f58:	00003597          	auipc	a1,0x3
    80005f5c:	82058593          	addi	a1,a1,-2016 # 80008778 <etext+0x778>
    80005f60:	8526                	mv	a0,s1
    80005f62:	00000097          	auipc	ra,0x0
    80005f66:	27c080e7          	jalr	636(ra) # 800061de <initlock>
  pr.locking = 1;
    80005f6a:	4785                	li	a5,1
    80005f6c:	cc9c                	sw	a5,24(s1)
}
    80005f6e:	60e2                	ld	ra,24(sp)
    80005f70:	6442                	ld	s0,16(sp)
    80005f72:	64a2                	ld	s1,8(sp)
    80005f74:	6105                	addi	sp,sp,32
    80005f76:	8082                	ret

0000000080005f78 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005f78:	1141                	addi	sp,sp,-16
    80005f7a:	e406                	sd	ra,8(sp)
    80005f7c:	e022                	sd	s0,0(sp)
    80005f7e:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005f80:	100007b7          	lui	a5,0x10000
    80005f84:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005f88:	10000737          	lui	a4,0x10000
    80005f8c:	f8000693          	li	a3,-128
    80005f90:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005f94:	468d                	li	a3,3
    80005f96:	10000637          	lui	a2,0x10000
    80005f9a:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005f9e:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005fa2:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005fa6:	8732                	mv	a4,a2
    80005fa8:	461d                	li	a2,7
    80005faa:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005fae:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005fb2:	00002597          	auipc	a1,0x2
    80005fb6:	7ce58593          	addi	a1,a1,1998 # 80008780 <etext+0x780>
    80005fba:	00023517          	auipc	a0,0x23
    80005fbe:	24e50513          	addi	a0,a0,590 # 80029208 <uart_tx_lock>
    80005fc2:	00000097          	auipc	ra,0x0
    80005fc6:	21c080e7          	jalr	540(ra) # 800061de <initlock>
}
    80005fca:	60a2                	ld	ra,8(sp)
    80005fcc:	6402                	ld	s0,0(sp)
    80005fce:	0141                	addi	sp,sp,16
    80005fd0:	8082                	ret

0000000080005fd2 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005fd2:	1101                	addi	sp,sp,-32
    80005fd4:	ec06                	sd	ra,24(sp)
    80005fd6:	e822                	sd	s0,16(sp)
    80005fd8:	e426                	sd	s1,8(sp)
    80005fda:	1000                	addi	s0,sp,32
    80005fdc:	84aa                	mv	s1,a0
  push_off();
    80005fde:	00000097          	auipc	ra,0x0
    80005fe2:	248080e7          	jalr	584(ra) # 80006226 <push_off>

  if(panicked){
    80005fe6:	00006797          	auipc	a5,0x6
    80005fea:	0367a783          	lw	a5,54(a5) # 8000c01c <panicked>
    80005fee:	eb85                	bnez	a5,8000601e <uartputc_sync+0x4c>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005ff0:	10000737          	lui	a4,0x10000
    80005ff4:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80005ff6:	00074783          	lbu	a5,0(a4)
    80005ffa:	0207f793          	andi	a5,a5,32
    80005ffe:	dfe5                	beqz	a5,80005ff6 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006000:	0ff4f513          	zext.b	a0,s1
    80006004:	100007b7          	lui	a5,0x10000
    80006008:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    8000600c:	00000097          	auipc	ra,0x0
    80006010:	2ba080e7          	jalr	698(ra) # 800062c6 <pop_off>
}
    80006014:	60e2                	ld	ra,24(sp)
    80006016:	6442                	ld	s0,16(sp)
    80006018:	64a2                	ld	s1,8(sp)
    8000601a:	6105                	addi	sp,sp,32
    8000601c:	8082                	ret
    for(;;)
    8000601e:	a001                	j	8000601e <uartputc_sync+0x4c>

0000000080006020 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006020:	00006797          	auipc	a5,0x6
    80006024:	0007b783          	ld	a5,0(a5) # 8000c020 <uart_tx_r>
    80006028:	00006717          	auipc	a4,0x6
    8000602c:	00073703          	ld	a4,0(a4) # 8000c028 <uart_tx_w>
    80006030:	06f70f63          	beq	a4,a5,800060ae <uartstart+0x8e>
{
    80006034:	7139                	addi	sp,sp,-64
    80006036:	fc06                	sd	ra,56(sp)
    80006038:	f822                	sd	s0,48(sp)
    8000603a:	f426                	sd	s1,40(sp)
    8000603c:	f04a                	sd	s2,32(sp)
    8000603e:	ec4e                	sd	s3,24(sp)
    80006040:	e852                	sd	s4,16(sp)
    80006042:	e456                	sd	s5,8(sp)
    80006044:	e05a                	sd	s6,0(sp)
    80006046:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006048:	10000937          	lui	s2,0x10000
    8000604c:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000604e:	00023a97          	auipc	s5,0x23
    80006052:	1baa8a93          	addi	s5,s5,442 # 80029208 <uart_tx_lock>
    uart_tx_r += 1;
    80006056:	00006497          	auipc	s1,0x6
    8000605a:	fca48493          	addi	s1,s1,-54 # 8000c020 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    8000605e:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    80006062:	00006997          	auipc	s3,0x6
    80006066:	fc698993          	addi	s3,s3,-58 # 8000c028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000606a:	00094703          	lbu	a4,0(s2)
    8000606e:	02077713          	andi	a4,a4,32
    80006072:	c705                	beqz	a4,8000609a <uartstart+0x7a>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006074:	01f7f713          	andi	a4,a5,31
    80006078:	9756                	add	a4,a4,s5
    8000607a:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    8000607e:	0785                	addi	a5,a5,1
    80006080:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    80006082:	8526                	mv	a0,s1
    80006084:	ffffb097          	auipc	ra,0xffffb
    80006088:	676080e7          	jalr	1654(ra) # 800016fa <wakeup>
    WriteReg(THR, c);
    8000608c:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    80006090:	609c                	ld	a5,0(s1)
    80006092:	0009b703          	ld	a4,0(s3)
    80006096:	fcf71ae3          	bne	a4,a5,8000606a <uartstart+0x4a>
  }
}
    8000609a:	70e2                	ld	ra,56(sp)
    8000609c:	7442                	ld	s0,48(sp)
    8000609e:	74a2                	ld	s1,40(sp)
    800060a0:	7902                	ld	s2,32(sp)
    800060a2:	69e2                	ld	s3,24(sp)
    800060a4:	6a42                	ld	s4,16(sp)
    800060a6:	6aa2                	ld	s5,8(sp)
    800060a8:	6b02                	ld	s6,0(sp)
    800060aa:	6121                	addi	sp,sp,64
    800060ac:	8082                	ret
    800060ae:	8082                	ret

00000000800060b0 <uartputc>:
{
    800060b0:	7179                	addi	sp,sp,-48
    800060b2:	f406                	sd	ra,40(sp)
    800060b4:	f022                	sd	s0,32(sp)
    800060b6:	e052                	sd	s4,0(sp)
    800060b8:	1800                	addi	s0,sp,48
    800060ba:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800060bc:	00023517          	auipc	a0,0x23
    800060c0:	14c50513          	addi	a0,a0,332 # 80029208 <uart_tx_lock>
    800060c4:	00000097          	auipc	ra,0x0
    800060c8:	1ae080e7          	jalr	430(ra) # 80006272 <acquire>
  if(panicked){
    800060cc:	00006797          	auipc	a5,0x6
    800060d0:	f507a783          	lw	a5,-176(a5) # 8000c01c <panicked>
    800060d4:	c391                	beqz	a5,800060d8 <uartputc+0x28>
    for(;;)
    800060d6:	a001                	j	800060d6 <uartputc+0x26>
    800060d8:	ec26                	sd	s1,24(sp)
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800060da:	00006717          	auipc	a4,0x6
    800060de:	f4e73703          	ld	a4,-178(a4) # 8000c028 <uart_tx_w>
    800060e2:	00006797          	auipc	a5,0x6
    800060e6:	f3e7b783          	ld	a5,-194(a5) # 8000c020 <uart_tx_r>
    800060ea:	02078793          	addi	a5,a5,32
    800060ee:	02e79f63          	bne	a5,a4,8000612c <uartputc+0x7c>
    800060f2:	e84a                	sd	s2,16(sp)
    800060f4:	e44e                	sd	s3,8(sp)
      sleep(&uart_tx_r, &uart_tx_lock);
    800060f6:	00023997          	auipc	s3,0x23
    800060fa:	11298993          	addi	s3,s3,274 # 80029208 <uart_tx_lock>
    800060fe:	00006497          	auipc	s1,0x6
    80006102:	f2248493          	addi	s1,s1,-222 # 8000c020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006106:	00006917          	auipc	s2,0x6
    8000610a:	f2290913          	addi	s2,s2,-222 # 8000c028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    8000610e:	85ce                	mv	a1,s3
    80006110:	8526                	mv	a0,s1
    80006112:	ffffb097          	auipc	ra,0xffffb
    80006116:	462080e7          	jalr	1122(ra) # 80001574 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000611a:	00093703          	ld	a4,0(s2)
    8000611e:	609c                	ld	a5,0(s1)
    80006120:	02078793          	addi	a5,a5,32
    80006124:	fee785e3          	beq	a5,a4,8000610e <uartputc+0x5e>
    80006128:	6942                	ld	s2,16(sp)
    8000612a:	69a2                	ld	s3,8(sp)
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    8000612c:	00023497          	auipc	s1,0x23
    80006130:	0dc48493          	addi	s1,s1,220 # 80029208 <uart_tx_lock>
    80006134:	01f77793          	andi	a5,a4,31
    80006138:	97a6                	add	a5,a5,s1
    8000613a:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    8000613e:	0705                	addi	a4,a4,1
    80006140:	00006797          	auipc	a5,0x6
    80006144:	eee7b423          	sd	a4,-280(a5) # 8000c028 <uart_tx_w>
      uartstart();
    80006148:	00000097          	auipc	ra,0x0
    8000614c:	ed8080e7          	jalr	-296(ra) # 80006020 <uartstart>
      release(&uart_tx_lock);
    80006150:	8526                	mv	a0,s1
    80006152:	00000097          	auipc	ra,0x0
    80006156:	1d0080e7          	jalr	464(ra) # 80006322 <release>
    8000615a:	64e2                	ld	s1,24(sp)
}
    8000615c:	70a2                	ld	ra,40(sp)
    8000615e:	7402                	ld	s0,32(sp)
    80006160:	6a02                	ld	s4,0(sp)
    80006162:	6145                	addi	sp,sp,48
    80006164:	8082                	ret

0000000080006166 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006166:	1141                	addi	sp,sp,-16
    80006168:	e406                	sd	ra,8(sp)
    8000616a:	e022                	sd	s0,0(sp)
    8000616c:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000616e:	100007b7          	lui	a5,0x10000
    80006172:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006176:	8b85                	andi	a5,a5,1
    80006178:	cb89                	beqz	a5,8000618a <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000617a:	100007b7          	lui	a5,0x10000
    8000617e:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80006182:	60a2                	ld	ra,8(sp)
    80006184:	6402                	ld	s0,0(sp)
    80006186:	0141                	addi	sp,sp,16
    80006188:	8082                	ret
    return -1;
    8000618a:	557d                	li	a0,-1
    8000618c:	bfdd                	j	80006182 <uartgetc+0x1c>

000000008000618e <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    8000618e:	1101                	addi	sp,sp,-32
    80006190:	ec06                	sd	ra,24(sp)
    80006192:	e822                	sd	s0,16(sp)
    80006194:	e426                	sd	s1,8(sp)
    80006196:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006198:	54fd                	li	s1,-1
    int c = uartgetc();
    8000619a:	00000097          	auipc	ra,0x0
    8000619e:	fcc080e7          	jalr	-52(ra) # 80006166 <uartgetc>
    if(c == -1)
    800061a2:	00950763          	beq	a0,s1,800061b0 <uartintr+0x22>
      break;
    consoleintr(c);
    800061a6:	00000097          	auipc	ra,0x0
    800061aa:	8ce080e7          	jalr	-1842(ra) # 80005a74 <consoleintr>
  while(1){
    800061ae:	b7f5                	j	8000619a <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800061b0:	00023497          	auipc	s1,0x23
    800061b4:	05848493          	addi	s1,s1,88 # 80029208 <uart_tx_lock>
    800061b8:	8526                	mv	a0,s1
    800061ba:	00000097          	auipc	ra,0x0
    800061be:	0b8080e7          	jalr	184(ra) # 80006272 <acquire>
  uartstart();
    800061c2:	00000097          	auipc	ra,0x0
    800061c6:	e5e080e7          	jalr	-418(ra) # 80006020 <uartstart>
  release(&uart_tx_lock);
    800061ca:	8526                	mv	a0,s1
    800061cc:	00000097          	auipc	ra,0x0
    800061d0:	156080e7          	jalr	342(ra) # 80006322 <release>
}
    800061d4:	60e2                	ld	ra,24(sp)
    800061d6:	6442                	ld	s0,16(sp)
    800061d8:	64a2                	ld	s1,8(sp)
    800061da:	6105                	addi	sp,sp,32
    800061dc:	8082                	ret

00000000800061de <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800061de:	1141                	addi	sp,sp,-16
    800061e0:	e406                	sd	ra,8(sp)
    800061e2:	e022                	sd	s0,0(sp)
    800061e4:	0800                	addi	s0,sp,16
  lk->name = name;
    800061e6:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800061e8:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800061ec:	00053823          	sd	zero,16(a0)
}
    800061f0:	60a2                	ld	ra,8(sp)
    800061f2:	6402                	ld	s0,0(sp)
    800061f4:	0141                	addi	sp,sp,16
    800061f6:	8082                	ret

00000000800061f8 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800061f8:	411c                	lw	a5,0(a0)
    800061fa:	e399                	bnez	a5,80006200 <holding+0x8>
    800061fc:	4501                	li	a0,0
  return r;
}
    800061fe:	8082                	ret
{
    80006200:	1101                	addi	sp,sp,-32
    80006202:	ec06                	sd	ra,24(sp)
    80006204:	e822                	sd	s0,16(sp)
    80006206:	e426                	sd	s1,8(sp)
    80006208:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    8000620a:	6904                	ld	s1,16(a0)
    8000620c:	ffffb097          	auipc	ra,0xffffb
    80006210:	c76080e7          	jalr	-906(ra) # 80000e82 <mycpu>
    80006214:	40a48533          	sub	a0,s1,a0
    80006218:	00153513          	seqz	a0,a0
}
    8000621c:	60e2                	ld	ra,24(sp)
    8000621e:	6442                	ld	s0,16(sp)
    80006220:	64a2                	ld	s1,8(sp)
    80006222:	6105                	addi	sp,sp,32
    80006224:	8082                	ret

0000000080006226 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006226:	1101                	addi	sp,sp,-32
    80006228:	ec06                	sd	ra,24(sp)
    8000622a:	e822                	sd	s0,16(sp)
    8000622c:	e426                	sd	s1,8(sp)
    8000622e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006230:	100024f3          	csrr	s1,sstatus
    80006234:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006238:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000623a:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    8000623e:	ffffb097          	auipc	ra,0xffffb
    80006242:	c44080e7          	jalr	-956(ra) # 80000e82 <mycpu>
    80006246:	5d3c                	lw	a5,120(a0)
    80006248:	cf89                	beqz	a5,80006262 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    8000624a:	ffffb097          	auipc	ra,0xffffb
    8000624e:	c38080e7          	jalr	-968(ra) # 80000e82 <mycpu>
    80006252:	5d3c                	lw	a5,120(a0)
    80006254:	2785                	addiw	a5,a5,1
    80006256:	dd3c                	sw	a5,120(a0)
}
    80006258:	60e2                	ld	ra,24(sp)
    8000625a:	6442                	ld	s0,16(sp)
    8000625c:	64a2                	ld	s1,8(sp)
    8000625e:	6105                	addi	sp,sp,32
    80006260:	8082                	ret
    mycpu()->intena = old;
    80006262:	ffffb097          	auipc	ra,0xffffb
    80006266:	c20080e7          	jalr	-992(ra) # 80000e82 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000626a:	8085                	srli	s1,s1,0x1
    8000626c:	8885                	andi	s1,s1,1
    8000626e:	dd64                	sw	s1,124(a0)
    80006270:	bfe9                	j	8000624a <push_off+0x24>

0000000080006272 <acquire>:
{
    80006272:	1101                	addi	sp,sp,-32
    80006274:	ec06                	sd	ra,24(sp)
    80006276:	e822                	sd	s0,16(sp)
    80006278:	e426                	sd	s1,8(sp)
    8000627a:	1000                	addi	s0,sp,32
    8000627c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000627e:	00000097          	auipc	ra,0x0
    80006282:	fa8080e7          	jalr	-88(ra) # 80006226 <push_off>
  if(holding(lk))
    80006286:	8526                	mv	a0,s1
    80006288:	00000097          	auipc	ra,0x0
    8000628c:	f70080e7          	jalr	-144(ra) # 800061f8 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006290:	4705                	li	a4,1
  if(holding(lk))
    80006292:	e115                	bnez	a0,800062b6 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006294:	87ba                	mv	a5,a4
    80006296:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    8000629a:	2781                	sext.w	a5,a5
    8000629c:	ffe5                	bnez	a5,80006294 <acquire+0x22>
  __sync_synchronize();
    8000629e:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    800062a2:	ffffb097          	auipc	ra,0xffffb
    800062a6:	be0080e7          	jalr	-1056(ra) # 80000e82 <mycpu>
    800062aa:	e888                	sd	a0,16(s1)
}
    800062ac:	60e2                	ld	ra,24(sp)
    800062ae:	6442                	ld	s0,16(sp)
    800062b0:	64a2                	ld	s1,8(sp)
    800062b2:	6105                	addi	sp,sp,32
    800062b4:	8082                	ret
    panic("acquire");
    800062b6:	00002517          	auipc	a0,0x2
    800062ba:	4d250513          	addi	a0,a0,1234 # 80008788 <etext+0x788>
    800062be:	00000097          	auipc	ra,0x0
    800062c2:	a34080e7          	jalr	-1484(ra) # 80005cf2 <panic>

00000000800062c6 <pop_off>:

void
pop_off(void)
{
    800062c6:	1141                	addi	sp,sp,-16
    800062c8:	e406                	sd	ra,8(sp)
    800062ca:	e022                	sd	s0,0(sp)
    800062cc:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800062ce:	ffffb097          	auipc	ra,0xffffb
    800062d2:	bb4080e7          	jalr	-1100(ra) # 80000e82 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800062d6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800062da:	8b89                	andi	a5,a5,2
  if(intr_get())
    800062dc:	e39d                	bnez	a5,80006302 <pop_off+0x3c>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800062de:	5d3c                	lw	a5,120(a0)
    800062e0:	02f05963          	blez	a5,80006312 <pop_off+0x4c>
    panic("pop_off");
  c->noff -= 1;
    800062e4:	37fd                	addiw	a5,a5,-1
    800062e6:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800062e8:	eb89                	bnez	a5,800062fa <pop_off+0x34>
    800062ea:	5d7c                	lw	a5,124(a0)
    800062ec:	c799                	beqz	a5,800062fa <pop_off+0x34>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800062ee:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800062f2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800062f6:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800062fa:	60a2                	ld	ra,8(sp)
    800062fc:	6402                	ld	s0,0(sp)
    800062fe:	0141                	addi	sp,sp,16
    80006300:	8082                	ret
    panic("pop_off - interruptible");
    80006302:	00002517          	auipc	a0,0x2
    80006306:	48e50513          	addi	a0,a0,1166 # 80008790 <etext+0x790>
    8000630a:	00000097          	auipc	ra,0x0
    8000630e:	9e8080e7          	jalr	-1560(ra) # 80005cf2 <panic>
    panic("pop_off");
    80006312:	00002517          	auipc	a0,0x2
    80006316:	49650513          	addi	a0,a0,1174 # 800087a8 <etext+0x7a8>
    8000631a:	00000097          	auipc	ra,0x0
    8000631e:	9d8080e7          	jalr	-1576(ra) # 80005cf2 <panic>

0000000080006322 <release>:
{
    80006322:	1101                	addi	sp,sp,-32
    80006324:	ec06                	sd	ra,24(sp)
    80006326:	e822                	sd	s0,16(sp)
    80006328:	e426                	sd	s1,8(sp)
    8000632a:	1000                	addi	s0,sp,32
    8000632c:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000632e:	00000097          	auipc	ra,0x0
    80006332:	eca080e7          	jalr	-310(ra) # 800061f8 <holding>
    80006336:	c115                	beqz	a0,8000635a <release+0x38>
  lk->cpu = 0;
    80006338:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8000633c:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80006340:	0310000f          	fence	rw,w
    80006344:	0004a023          	sw	zero,0(s1)
  pop_off();
    80006348:	00000097          	auipc	ra,0x0
    8000634c:	f7e080e7          	jalr	-130(ra) # 800062c6 <pop_off>
}
    80006350:	60e2                	ld	ra,24(sp)
    80006352:	6442                	ld	s0,16(sp)
    80006354:	64a2                	ld	s1,8(sp)
    80006356:	6105                	addi	sp,sp,32
    80006358:	8082                	ret
    panic("release");
    8000635a:	00002517          	auipc	a0,0x2
    8000635e:	45650513          	addi	a0,a0,1110 # 800087b0 <etext+0x7b0>
    80006362:	00000097          	auipc	ra,0x0
    80006366:	990080e7          	jalr	-1648(ra) # 80005cf2 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
