extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Sair_pressed():
	get_tree().change_scene("res://Cenas/Login/cena_login.tscn")
	pass # Replace with function body.


func _on_Sair_mouse_entered():
	pass # Replace with function body.
