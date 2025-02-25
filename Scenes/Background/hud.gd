extends CanvasLayer

func setHealth(val: int):
	$HealthBar.value = val
func setShieldBar(val: int):
	$ShieldBar.value = val


func _on_ship_update_health(hlth: int) -> void:
	setHealth(hlth)


func _on_ship_update_shield(val: int) -> void:
	setShieldBar(val)
