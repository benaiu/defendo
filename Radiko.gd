extends Node2D

var kaptitajxo = null
var vivo = 999
var Pistoloj = []
var mono = 350
var ondo = 0
var ondo_kreita = false
onready var Mono = get_node("Mono")
onready var Ondo = get_node("Ondo")
onready var Kanono = preload("res://Defendiloj/Pistoloj/Kanono/Kanono.tscn")
onready var Ondilo = preload("res://Defendiloj/Pistoloj/Ondilo/Ondilo.tscn")
onready var M0 = preload("res://Malamikoj/Malamiko_0_.tscn")
onready var Mj = get_node("Malamikoj")
onready var Pj = get_node("Pistoloj")
onready var Vivo = get_node("Bazo/Vivo")

func _ready():
	set_process(true)
	
func _process(delta):
	if vivo <= 0:
		get_tree().change_scene("res://Kontroloj/Malvenkigxi.tscn")
	Mono.set_text(str(mono))
	Ondo.set_text(str(ondo))
	Vivo.set_text(str(vivo))
	if not ondo_kreita:
		if ondo == 0:
			var M0_ = M0.instance()
			M0_.set_global_pos(Vector2(320, -100))
			Mj.add_child(M0_)
			ondo_kreita = true
		elif ondo == 1:
			for i in range(3):
				var M0_ = M0.instance()
				M0_.set_global_pos(Vector2(120+i*200, -100))
				Mj.add_child(M0_)
			ondo_kreita = true
		elif ondo == 2:
			for i in range(3):
				for j in range(4):
					var M0_ = M0.instance()
					M0_.set_global_pos(Vector2(120+i*200, -100+j*-200))
					Mj.add_child(M0_)
			ondo_kreita = true
		else:
			ondo = 0
			ondo_kreita = false
	if Mj.get_child_count() == 0:
		ondo += 1
		ondo_kreita = false
	
func _on_Area2D_body_enter( korpo ):
	Pistoloj.append(korpo)
	if Pistoloj.size() == 2:
		if Pistoloj[0].get_name() == "Kanono" and Pistoloj[1].get_name() == "Kanono":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()
		elif Pistoloj[0].get_name() == "Ondilo" and Pistoloj[1].get_name() == "Ondilo":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()
		elif Pistoloj[0].get_name() == "Lasero" and Pistoloj[1].get_name() == "Lasero":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()

func _on_Area2D_body_exit( korpo ):
	Pistoloj.erase(korpo)

func _on_Aldoni_Kanonon_button_up():
	if mono >= 10:
		mono -= 10
		var Kanono_ = Kanono.instance()
		Kanono_.set_global_pos(Vector2(400, 600))
		Pj.add_child(Kanono_)

func _on_Aldoni_Ondilo_button_up():
	if mono >= 20:
		mono -= 20
		var Ondilo_ = Ondilo.instance()
		Ondilo_.set_global_pos(Vector2(260, 600))
		Pj.add_child(Ondilo_)
