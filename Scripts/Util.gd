extends Node

func get_child_by_class(start_node: Node, class_type: Variant):
	for child in start_node.get_children():
		if is_instance_of(child, class_type):
			return child
	return null
