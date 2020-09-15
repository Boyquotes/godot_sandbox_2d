extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 400
const FRICTION = 500
const ROLL_MULTIPLIER = 1.5

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var swordHitBox = $HitboxPivot/SwordHitbox
onready var animationState = animationTree.get("parameters/playback");

func _ready():
	PlayerStats.connect("no_health", self, "no_health")
	animationTree.active = true
	
func get_input_vector(): 
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	return input_vector
	
func _physics_process(delta):
	var input = get_input_vector()
	match state:
		MOVE:
			move_state(delta, input)
		ATTACK:
			attack_state(delta, input)
		ROLL:
			roll_state(delta, input)
			
	if state != ATTACK && Input.is_action_just_pressed("attack"):
		if input != Vector2.ZERO:
			animationTree.set("parameters/Attack/blend_position", input)
		velocity = Vector2.ZERO
		state = ATTACK
		
	velocity = move_and_slide(velocity)
	
	if state != ROLL && Input.is_action_just_pressed("dodge") && input.length() > 0:
		animationTree.set("parameters/Roll/blend_position", input)
		velocity = input * MAX_SPEED * ROLL_MULTIPLIER
		state = ROLL
	
func _on_HurtBox_hurt(area):
	PlayerStats.health -= 1
	
func attack_state(delta, input):
	animationState.travel("Attack")
	
func roll_state(delta, input):
	animationState.travel("Roll")
	
func move_state(delta, input):
	if input != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input)
		animationTree.set("parameters/Run/blend_position", input)
		animationTree.set("parameters/Attack/blend_position", input)
		swordHitBox.knockback_vector = input
		animationState.travel("Run")
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
func attack_animation_finished():
	state = MOVE
	
func roll_animation_finished():
	velocity = Vector2.ZERO
	state = MOVE

func no_health():
	queue_free()
