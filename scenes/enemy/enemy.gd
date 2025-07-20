extends CharacterBody2D

const DEFAULT_FOE_SPEED:float = 75.0

@export_category("Resource")
@export
var foe:Foe

@export_category("stats")
@export
var health:int
var speed:float

func _ready():
	health=foe.max_health
	$AnimatedSprite2D.sprite_frames=foe.animations
	$AnimatedSprite2D.play("croak")
