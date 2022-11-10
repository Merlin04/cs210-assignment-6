# computes the sum of all values in a linked list. Assume that
# the nodes in the list consist of a 16-bit integer and a
# pointer to the next node, stored in that order. Assume that
# the final node's pointer contains the value 0. Remember that
# pointers in MIPS are 32 bits. You should store the result in
# #v0. Assume that a pointer to the first node in the list is
# stored in $a0.

.data

node1:
    .space 2 # value
    .space 4 # address of next

node2:
    .space 2 # value
    .space 4 # address of next

node3:
    .space 2 # value
    .space 4 # address of next

node4:
    .space 2 # value
    .space 4 # address of next

.text
.globl main
main:

# testing: construct the linked list
# by loading the address, then storing values

la		$t0, node1		# 
la      $t1, node2		#
la      $t2, node3		#
la      $t3, node4		#

# store the values
li      $t4, 1			#
sw      $t4, 0($t0)		#
li      $t4, 2			#
sw      $t4, 0($t1)		#
li      $t4, 3			#
sw      $t4, 0($t2)		#
li      $t4, 4			#
sw      $t4, 0($t3)		#

# link the nodes together
sw      $t1, 2($t0)		#
sw      $t2, 2($t1)		#
sw      $t3, 2($t2)		#
sw      $zero, 2($t3)		#

# store the address of the first node in $a0
la      $a0, node1		#

# program

li		$v0, 0		# $v0 = 0

Loop:
lw		$t0, 0($a0)	# $t0 = value
add		$v0, $v0, $t0	# $v0 = $v0 + $t0
lw		$a0, 2($a0)	# $a0 = address of next node
bne		$a0, $zero, Loop	# if $a0 != 0, go to Loop

# test
# print result
li		$v0, 1		# $v0 = 1
syscall