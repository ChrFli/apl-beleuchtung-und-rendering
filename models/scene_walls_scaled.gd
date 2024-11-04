extends Node3D  # oder Spatial für Godot 3.x

# Die Skalierungsfaktor
var scale_factor: Vector3 = Vector3(0.5, 0.5, 0.5)  # Beispiel für Verdopplung

func _ready():
	scale_model(scale_factor)

func scale_model(factor: Vector3):
	# Durchlaufe alle Kinder des Knotens
	for child in get_children():
		if child is MeshInstance3D:  # oder MeshInstance für Godot 3.x
			# Speichere die aktuelle Position und Skalierung
			var original_position = child.global_transform.origin
			var original_scale = child.scale
			
			# Setze die neue Skalierung des Kindes
			child.scale *= factor
			
			# Berechne die neue Position basierend auf der Skalierung
			var new_position = original_position * factor
			
			# Setze die neue Position
			child.global_transform.origin = new_position

	# Skalierung des Elternknotens
	self.scale *= factor
