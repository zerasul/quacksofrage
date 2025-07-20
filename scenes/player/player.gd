extends CharacterBody2D

const DEFAULT_SPEED:float = 100.0

@export_category("Resource")
@export
var character:Character

@export_category("Player stats")
@export
var health:int


var score:int

var speed: int 
@export
var special:int

@export_category("Player")
@export
var player_n:int = 1

var isAttacking:bool = false
var attack_combo:int =0



func _ready():
	health = character.max_health
	score=0
	special = 1
	speed = DEFAULT_SPEED+(character.speed*10)
	$AnimatedSprite2D.sprite_frames= character.animations
	$AnimatedSprite2D.play("idle")
	$marcador/VBoxContainer/Label.text="%s P"%player_n
	$marcador/disableMarker.start()

func _physics_process(delta: float) -> void:
	handleInput()
	move_and_slide()
	updateAnimations()
	

func attack()->void:
	isAttacking=true
	match  attack_combo:
		0:
			$AnimatedSprite2D.play("attack1")
		1:
			$AnimatedSprite2D.play("attack2")
		2:
			$AnimatedSprite2D.play("attack3")
	await $AnimatedSprite2D.animation_finished
	isAttacking=false
	attack_combo=attack_combo+1
	attack_combo%=3



func handleInput():
	var moveDirection=0
	if player_n==1:
		moveDirection = Input.get_vector("p1_move_left","p1_move_rigth","p1_move_up","p1_move_down")
		if Input.is_action_just_pressed("p1_attack_a") and not isAttacking:
			attack()
	elif player_n==2:
		moveDirection = Input.get_vector("p2_move_left","p2_move_rigth","p2_move_up","p2_move_down")
		if Input.is_action_just_pressed("p2_attack_a") and not isAttacking:
			attack()
	velocity = moveDirection * speed

func updateAnimations()->void:
	if isAttacking:
		return
	if velocity.length()==0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")
		if velocity.x<0:
			$AnimatedSprite2D.flip_h=true
		elif velocity.x>0:
			$AnimatedSprite2D.flip_h=false



func _on_disable_marker_timeout() -> void:
	$marcador.visible=false 
