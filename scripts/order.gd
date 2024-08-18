class_name Order
extends RefCounted

## Item which has been ordered
var item: Item

## Reference time in milliseconds when order was created
var order_time: int

func _new(order_item: Item):
	item = order_item
	order_time = Time.get_ticks_msec()
