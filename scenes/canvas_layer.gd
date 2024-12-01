extends CanvasLayer

@onready var button_start = $Button_Start
@onready var button_controls = $Button_Controls
@onready var button_about = $Button_About
@onready var panel_controls = $Panel_Controls
@onready var panel_about = $Panel_About

func _ready():
	# Verstecke die Panels zu Beginn
	panel_controls.visible = false
	panel_about.visible = false

	# Verknüpfe die Buttons mit ihren Funktionen
	button_start.callable("pressed", self, "_on_Button_Start_pressed")
	button_controls.callable("pressed", self, "_on_Button_Controls_pressed")
	button_about.callable("pressed", self, "_on_Button_About_pressed")

# Funktion, die beim Klicken des "Start"-Buttons ausgeführt wird
func _on_Button_Start_pressed():
	get_tree().change_scene("res://path_to_your_game_scene.tscn")  # Hier die Spielszene einfügen

# Funktion, die beim Klicken des "Controls"-Buttons ausgeführt wird
func _on_Button_Controls_pressed():
	panel_controls.visible = true  # Zeige das Steuerungsfenster an
	panel_about.visible = false  # Verstecke das "About"-Fenster

# Funktion, die beim Klicken des "About"-Buttons ausgeführt wird
func _on_Button_About_pressed():
	panel_about.visible = true  # Zeige das "About"-Fenster an
	panel_controls.visible = false  # Verstecke das Steuerungsfenster
