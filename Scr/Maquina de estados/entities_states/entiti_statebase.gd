class_name EntytiStateBase
extends StateBase

var Maid:maid:
	set (value):
		controlled_node = value
	get:
		return controlled_node
