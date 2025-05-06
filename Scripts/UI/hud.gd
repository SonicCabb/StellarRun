extends CanvasLayer

class_name Hud


func setHealth(val: float):
	$HealthBar.value = val
func setShieldBar(val: float):
	$ShieldBar.value = val


func _on_ship_update_health(hlth: float) -> void:
	setHealth(hlth)


func _on_ship_update_shield(val: float) -> void:
	setShieldBar(val)
