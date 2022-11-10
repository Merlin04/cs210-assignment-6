.text
.globl main
main:


# 1. computes the nth Fibonacci number. You should use loops
#    rather than recursion. You should store the result in
#    $v0. Assume that n is stored in $a0.

# test
li		$a0, 6		# $a0 = 6


# program
li		$v0, 0		# val  $v0 = 0
li		$t0, 1		# prev $t0 = 1

li		$t1, 0		# $t1 = 0
j		Cond				# jump to Cond
Loop:
move 	$t2, $v0		# $t2 = $v0
add		$v0, $v0, $t0		# $v0 = $v0 + $t0
move 	$t0, $t2		# $t0 = $t2
addi	$t1, $t1, 1			# $t1 = $t1 + 1

Cond:
blt		$t1, $a0, Loop	# if $t1 < $a0 then Loop


# test
move 	$a0, $v0		# $a0 = $v0
li		$v0, 1		# $v0 = 1
syscall # print int

li		$v0, 10		# $v0 = 10
syscall # exit