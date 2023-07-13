extends Node

signal level_loaded()
signal player_died(player: Player)
signal stats_update(player: Player)

signal stats_update_ui(player: Player)

signal start_level_up(player:Player)
signal end_level_up()

signal start_pause_menu()
signal end_pause_menu()

signal upgrade_selected(player:Player ,upgrade:Upgrade)
