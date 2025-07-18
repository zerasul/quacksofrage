extends CharacterBody2D

const DEFAULT_SPEED:int = 100.0

@export_category("Resource")
@export
var character:Character

@export_category("Player stats")
@export
var health:int

@export
var score:int

var speed: int 
@export
var special:int

@export
var player_n:int = 1

var attack_combo:int = 0




func _ready():
	health = character.max_health
	score=0
	special = 1
	speed = DEFAULT_SPEED+(character.speed*10)
	$AnimatedSprite2D.sprite_frames= character.animations
	$AnimatedSprite2D.play("idle")
	$marcador/VBoxContainer/Label.text="%s P"%player_n

func _process(delta: float) -> void:
	var vel:Vector2 = Vector2.ZERO
	if player_n == 1:
		vel=_process_p1(delta)
	else:
		vel=_process_p2(delta)

	velocity = vel * speed
	move_and_slide()


func _process_p1(delta:float)->Vector2:
	var vel:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("p1_move_down"):
		vel.y=1
	if Input.is_action_pressed("p1_move_up"):
		vel.y=-1
	if Input.is_action_pressed("p1_move_rigth"):
		vel.x=1
		$AnimatedSprite2D.flip_h=false
	if Input.is_action_pressed("p1_move_left"):
		vel.x=-1
		$AnimatedSprite2D.flip_h=true
	return vel


func _process_p2(delta:float)->Vector2:
	var vel:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("p2_move_down"):
		vel.y=1
	if Input.is_action_pressed("p2_move_up"):
		vel.y=-1
	if Input.is_action_pressed("p2_move_rigth"):
		vel.x=1
		$AnimatedSprite2D.flip_h=false
	if Input.is_action_pressed("p2_move_left"):
		vel.x=-1
		$AnimatedSprite2D.flip_h=true
		
	return vel
