extends Node2D


var secreto
var link = "http://narutin.freevar.com/"

func _ready():
	$PopupDialog.visible = false
	$Som.pressed = true
	$Barra_atras3/CheckBox.pressed = true
	$TextSenha.secret = true
	if(ScriptGlobal.Status_music == true):
		$Music.play()
	else:
		$Music.stop()
	
	
	
func press():
	if(ScriptGlobal.Status_som == true):
		$Press.play()
	else:
		$Press.stop()
	
func selec():
	if(ScriptGlobal.Status_som == true):
		$Selec.play()
	else:
		$Selec.stop()


func _process(delta):
	$lblBemvindo/Player.text = ScriptGlobal.player
	if(Input.is_action_just_pressed("enter")):
		_on_Button_pressed()

func _on_Button_pressed(): #importante
	var url = "http://narutin.freevar.com/consultar.php?";
	var data = "email=" + $TextEmail.text + "&password=" + $TextSenha.text;
	var headers = []
	var use_ssl = false
	$HTTPRequest.request(url + data, headers, use_ssl, HTTPClient.METHOD_GET)
	press()
	
func _on_Button_mouse_entered():
	selec()

func _on_HTTPRequest_request_completed(result, response_code, headers, body): #importante
	print ("body = " + body.get_string_from_utf8())
	var resultado = body.get_string_from_utf8()
	
	if(resultado != ""):
		ScriptGlobal.player = resultado
		$Camera2D.limit_left = 1033  #ignora
		$Timer.start() #ignora
#		get_tree().change_scene("res://cena_inicio.tscn")
	else: #treco de mostrar a senhor invalida
		$PopupDialog.visible = true
		$Button.disabled = true
		
#		Som de popup // Ignora
		if(ScriptGlobal.Status_som == true):
			$Som_popup.play()
		else:
			$Som_popup.stop()
		
func _on_Butt_pressed():
	$PopupDialog.visible = false
	$Button.disabled = false
	press()
	
func _on_Butt_mouse_entered():
	selec()

func _on_music_finished():
	if(ScriptGlobal.Status_music == true and not $Music.playing):
		$Music.play()
	else: 
		$Music.stop()
	
#Mostrar Senha
func _on_CheckBox_pressed():
	press()
	if($Barra_atras3/CheckBox.pressed == true):
		$TextSenha.secret = true
	else:
		$TextSenha.secret = false
#	print($Barra_atras3/CheckBox.pressed)



func _on_Som_pressed():
	if ($Som.pressed == true):
		$AnimationPlayer.play("BotaoON")
		$Music.stream_paused = false
		ScriptGlobal.Status_music = true
		
	else:
		$AnimationPlayer.play("BotaoOFF")
		$Music.stream_paused = true
		ScriptGlobal.Status_music = false


func _on_Timer_timeout():
	get_tree().change_scene("res://cena_inicio.tscn")

func _on_LinkButton_mouse_entered():
	selec()

func _on_LinkButton_pressed():
	press()
#	tag pra abrir algum link
	OS.shell_open("http://narutin.freevar.com/")
