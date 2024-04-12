extends EffectHandler

const attackDamageParticule = preload("./../../../particules/attack/AttackDamageParticule.tscn")

static func trigger_effect(node :Node2D,attack :AttackInterface = null)->Variant:
	var attackDamageParticuleScene = attackDamageParticule.instantiate()
	attackDamageParticuleScene.attack_number=attack.attack_damage
	node.add_child(attackDamageParticuleScene)
	attackDamageParticuleScene.global_transform.origin = attack.attack_position
	return
