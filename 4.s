# computes the sum of all values in a linked list. Assume that
# the nodes in the list consist of a 16-bit integer and a
# pointer to the next node, stored in that order. Assume that
# the final node's pointer contains the value 0. Remember that
# pointers in MIPS are 32 bits. You should store the result in
# #v0. Assume that a pointer to the first node in the list is
# stored in $a0.

.data

node4:
    .half 4
    .align 2
    .word 0

node3:
    .half 3
    .align 2
    .word node4

node2:
    .half 2
    .align 2
    .word node3

node1:
    .half 1
    .align 2
    .word node2

.text
.globl main
main:

# testing
# store the address of the first node in $a0
la      $a0, node1		#

# program

li		$v0, 0		# $v0 = 0

Loop:
lh		$t0, 0($a0)	# $t0 = value
add		$v0, $v0, $t0	# $v0 = $v0 + $t0
lw		$a0, 4($a0)	# $a0 = address of next node
bne		$a0, $zero, Loop	# if $a0 != 0, go to Loop

# test
# print result
move        $a0, $v0	# $a0 = $v0
li		$v0, 1		# $v0 = 1
syscall

# exit
li		$v0, 10		# $v0 = 10
syscall