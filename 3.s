# performs the same functionality as the following C code:
# for(int i = 0; i < length; i++) {
#     swap(&array[i], &array[permutations[i]]);
# }
# Assume that `array` and `permutation` both consist of
# 32-bit integers and that each values in permutations is
# between 0 and length. Assume that `array`, `permutations`,
# and `length` are stored in $a0, $a1, and $a2 respectively.

# test
.data
# [0,3,2,5,2,1,1],[3,5,3,4,5,5,6],7
array:
    .word 0
    .word 3
    .word 2
    .word 5
    .word 2
    .word 1
    .word 1
permutations:
    .word 3
    .word 5
    .word 3
    .word 4
    .word 5
    .word 5
    .word 6
length: .word 7

# strings for printing arrays
sep: .asciiz ", "
newline: .asciiz "\n"

.text
.globl main
main:

# test
la $a0, array
la $a1, permutations
la $a2, length
lw $a2, 0($a2)

li		$t0, 0		# $t0 = 0
j		Cond				# jump to Cond

Loop:
# load array[i] into $t2
sll		$t1, $t0, 2			# $t1 = $t0 << 2
add		$t1, $t1, $a0		# $t1 = $t1 + $a0
lw		$t2, 0($t1)		# 

# load permutations[i] into $t4
sll		$t3, $t0, 2			# $t3 = $t0 << 2
add		$t3, $t3, $a1		# $t3 = $t3 + $a1
lw		$t4, 0($t3)		# 

# load array[permutations[i]] into $t6
sll		$t5, $t4, 2			# $t5 = $t4 << 2
add		$t5, $t5, $a0		# $t5 = $t5 + $a0
lw		$t6, 0($t5)		# 

sw		$t2, 0($t5)		# 
sw		$t6, 0($t1)		# 

addi	$t0, $t0, 1			# $t0 = $t0 + 1


Cond:
blt		$t0, $a2, Loop	# if $t0 < $a2 then Loop


# print out the arrays with the function from below
la $t0 array
move 	$t1, $a2		# $t1 = $a2
jal print_array

la $t0 permutations
jal print_array


li		$v0, 10		# $v0 = 10
syscall # exit


print_array: # put arr in $t0, length in $t1
li		$t4, 1			# $t4 = 1
sub		$t4, $t1, $t4		# $t4 = $t1 - 1
li		$t2, 0		# $t2 = 0
bge		$t2, $t1, PAExit	# if $t2 >= $t1 then PAExit

PALoop:
# load array[i] into $t4
sll		$t3, $t2, 2			# $t3 = $t2 << 2
add		$t3, $t3, $t0		# $t3 = $t3 + $t0
lw		$a0, 0($t3)		#

li		$v0, 1		# $v0 = 1
syscall # print

beq     $t2, $t4, PAExit	# if $t2 == $t4 then PAExit
li		$v0, 4		# $v0 = 4
la		$a0, sep		# $a0 = space
syscall # print

addi	$t2, $t2, 1			# $t2 = $t2 + 1
j		PALoop				# jump to PALoop

PAExit:
li		$v0, 4		# $v0 = 4
la		$a0, newline		# $a0 = newline
syscall # print
jr		$ra					# return


