extends Node
class_name MovementController

var linear_loss: float
var mult_loss: float
var length: float
var velocity: Vector2


func _init(_linear_loss, _mult_loss, _length, _velocity):
	self.linear_loss = _linear_loss
	self.mult_loss = _mult_loss
	self.length = _length
	self.velocity = _velocity
	
func lose_speed(delta: float) -> Vector2:
	if velocity==Vector2.ZERO:
		return Vector2.ZERO
	var old_vel = velocity
	velocity = velocity.normalized() * max(0, (velocity.length() - linear_loss * delta))
	var loss_vel = old_vel - velocity
	loss_vel += mult_loss*velocity*delta
	velocity *= 1-mult_loss*delta
	return loss_vel
