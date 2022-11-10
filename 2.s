# 2. counts the frequency of values in particular ranges in a
#    given array of 32-bit integers. In addition to the
#    array, you are given 3 values. You should count the
#    number of values in the array smaller than all 3 values,
#    larger than all 3 values, and in both of the ranges
#    between the values.
#    Assume that the lower end of each range is inclusive,
#    and the upper end of each range is exclusive. You should
#    store the results of the counting in $s0, $s1, $s2, and
#    $s3. Assume that the array is stored in $a0 and its
#    length is stored in $a1. Assume that the 3 values are
#    stored in $t0, $t1, and $t2, and that they are stored in
#    ascending order.

# test

.data
arr:
    .word   1
    .word   2
    .word   3
    .word   4
    .word   5

.text
.globl main
main:
li		$t0, 1		# $t0 = 1
li		$t1, 3		# $t1 = 3
li		$t2, 4		# $t2 = 4
la		$a0, arr		# 
li		$a1, 5		# $a1 = 5


# program

li		$s0, 0		# $s0 = 0
li		$s1, 0		# $s1 = 0
li		$s2, 0		# $s2 = 0
li		$s3, 0		# $s3 = 0

li		$t5, 0		# $t0 = 0
j		Cond				# jump to Cond
Loop:
lw		$t3, 0($a0)		# 
blt		$t3, $t0, C1	# if $t1 < $t0 then C1
bgt		$t3, $t2, C2	# if $t1 > $t2 then C2
blt		$t3, $t0, I4	# if $t1 < $t0 then I4
blt		$t3, $t1, C3	# if $t1 < $t1 then C3
I4:
blt		$t3, $t1, Cont	# if $t3 < $t1 then Cont
blt		$t3, $t2, C4	# if $t3 < $t2 then C4
j Cont


C1:
addi	$s0, $s0, 1			# $s0 = $s0 + 1
j		Cont				# jump to Cont

C2:
addi	$s1, $s1, 1			# $s1 = $s1 + 1
j		Cont				# jump to Cont

C3:
addi	$s2, $s2, 1			# $s2 = $s2 + 1
j		Cont				# jump to Cont

C4:
addi	$s3, $s3, 1			# $s3 = $s3 + 1
j		Cont				# jump to Cont


Cont:
addi	$a0, $a0, 4			# $a0 = $a0 + 4
addi	$t5, $t5, 1			# $t5 = $t5 + 1


Cond:
blt		$t5, $a1, Loop	# if $t5 < $a1 then Loop


# test
move 	$a0, $s0		# $a0 = $s0
li		$v0, 1		# $v0 = 1
syscall # print int
move 	$a0, $s1		# $a0 = $s1
li		$v0, 1		# $v0 = 1
syscall # print int
move 	$a0, $s2		# $a0 = $s2
li		$v0, 1		# $v0 = 1
syscall # print int
move 	$a0, $s3		# $a0 = $s3
li		$v0, 1		# $v0 = 1
syscall # print int


li		$v0, 10		# $v0 = 10
syscall # exit