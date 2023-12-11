extends Node

signal level_loaded()
signal player_died(player_info: PlayerInfo)
signal stats_update(player_info: PlayerInfo)

signal entity_died(entity: Entity)

signal stats_update_ui(player_info: PlayerInfo)
signal stats_update_node(player_info: PlayerInfo)
signal inventory_update(player_info: PlayerInfo)

signal start_level_up(player_info:PlayerInfo)
signal end_level_up()

signal start_pause_menu()
signal end_pause_menu()

signal item_selected(player_info:PlayerInfo ,upgrade:Upgrade)
