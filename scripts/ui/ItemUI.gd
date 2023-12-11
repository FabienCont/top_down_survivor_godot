extends VBoxContainer
@onready var texture_rect = $TextureRect
var item:Item

func _ready():
	if item :
		texture_rect.texture = item.texture
