extends Control

var link = "http://narutin.freevar.com/"

func _press():
	if(ScriptGlobal.status_som == true):
		$Som_press.play()
	else:
		$Som_press.stop()
	pass

func _selec():
	if(ScriptGlobal.status_som == true):
		$Som_selec.play()
	else:
		$Som_selec.stop()

# Controla o som dos checks
func _check():
	if(ScriptGlobal.checks == true):
		$ContoleTelaDeBemVindo/Tx_senha.secret = true
		$ContoleTelaDeBemVindo/Senha_visivel.pressed = true
		$ContoleTelaDeBemVindo/Caixinha/Check_som.pressed = true
	else: 
		$ContoleTelaDeBemVindo/Tx_senha.secret = false
		$ContoleTelaDeBemVindo/Senha_visivel.pressed = false
		$ContoleTelaDeBemVindo/Caixinha/Check_som.pressed = false
		
func _ready():
	$ContoleTelaDeBemVindo.visible = true
	$BemVindo.visible = false
	_check()




func _telaBemVindo():
	$ContoleTelaDeBemVindo.visible = false
	$BemVindo.visible = true
	$Timer.start()



#func _process(delta):
func _process(delta):
	$BemVindo/Nome_player.text = ScriptGlobal.player
	if(Input.is_action_just_pressed("enter")):
		_on_Logar_pressed()
	
#	Controlando a musica 
	if(ScriptGlobal.status_music == true):
		$Music.stream_paused = false
		if(not $Music.playing):
			$Music.play()
	else:
		$Music.stream_paused = true

#		Controle do checkbox de senha
	if($ContoleTelaDeBemVindo/Senha_visivel.pressed == true):
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = false
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = true
		$ContoleTelaDeBemVindo/Tx_senha.secret = true
	else:
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = true
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = false
		$ContoleTelaDeBemVindo/Tx_senha.secret = false

#	Controle do checkbox de som
	if($ContoleTelaDeBemVindo/Caixinha/Check_som.pressed == true):
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Com_som.visible = true
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Sem_som.visible = false
		ScriptGlobal.status_som = true
		ScriptGlobal.status_music = true
		ScriptGlobal.checks = true
		
	else:
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Com_som.visible = false
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Sem_som.visible = true
		ScriptGlobal.status_som = false
		ScriptGlobal.status_music = false
		ScriptGlobal.checks = false
		
		
#	


# Verifica com o banco de dados os dados
func _verificacao_Login(): #importante
	var url = "http://narutin.freevar.com/consultar.php?";
	var data = "email=" + $ContoleTelaDeBemVindo/Tx_email.text + "&password=" + $ContoleTelaDeBemVindo/Tx_senha.text;
	var headers = []
	var use_ssl = false
	$HTTPRequest.request(url + data, headers, use_ssl, HTTPClient.METHOD_GET)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print ("body = " + body.get_string_from_utf8())
	var resultado = body.get_string_from_utf8()
	
	if(resultado != ""):
		ScriptGlobal.player = resultado
		_telaBemVindo()
	else: #treco de mostrar a senhor invalida (fazer ainda)
		if(ScriptGlobal.status_som == true):
			$Som_popup.play()
		else:
			$Som_popup.stop()
		$Popup.visible = true
		$ContoleTelaDeBemVindo/Logar.disabled = true
		$ContoleTelaDeBemVindo/Offline.disabled = true


# Quando clicar (som e ação)
func _on_LogarToutch_pressed():
	_press()
	print("identificou")
	_verificacao_Login()


# Quando clicar no botão para logar
func _on_Logar_pressed():
	_press()
	_verificacao_Login()

# Quando o tempo acabar
func _on_Timer_timeout():
	get_tree().change_scene("res://Cenas/Menu/cena_menu.tscn")


# Quando clicar no botão para jogar offline
func _on_Offline_pressed():
	_press()
	ScriptGlobal.player = "Ninja"
	_telaBemVindo()
	

# Quando clicar no botão para jogar offline
func _on_OfflineToutch_pressed():
	_press()
	print("identificou")
	ScriptGlobal.player = "Ninja"
	_telaBemVindo()


# Controlar se a senha fica visivel 
func _on_Senha_visivel_pressed():
	_press()
	if($ContoleTelaDeBemVindo/Senha_visivel.pressed == true):
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = false
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = true
		$ContoleTelaDeBemVindo/Tx_senha.secret = true
	else:
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = true
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = false
		$ContoleTelaDeBemVindo/Tx_senha.secret = false
		

# Quando clicar para fazer o cadastro
func _on_SiteCadastro_pressed():
	_press()
	OS.shell_open("http://narutin.freevar.com/")


#  -----Sons de mouse passando por cima-------
func _on_SiteCadastro_mouse_entered():
	_selec()
func _on_Logar_mouse_entered():
	_selec()
func _on_Fechar_popup_mouse_entered():
	_selec()
func _on_Offline_mouse_entered():
	_selec()


# Fechar popup
func _on_Fechar_popup_pressed():
	_press()
	$Popup.visible = false
	$ContoleTelaDeBemVindo/Logar.disabled = false
	$ContoleTelaDeBemVindo/Offline.disabled = false
	pass # Replace with function body.



# Controla o som da tela de inicio pelo icone
func _on_Check_som_pressed():
	_press()
	if($ContoleTelaDeBemVindo/Caixinha/Check_som.pressed == true):
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Com_som.visible = true
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Sem_som.visible = false
		ScriptGlobal.status_som = true
		ScriptGlobal.status_music = true
		ScriptGlobal.checks = true
		
	else:
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Com_som.visible = false
		$ContoleTelaDeBemVindo/Caixinha/Check_som/Sem_som.visible = true
		ScriptGlobal.status_som = false
		ScriptGlobal.status_music = false
		ScriptGlobal.checks = false
