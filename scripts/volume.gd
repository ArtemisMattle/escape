extends PanelContainer

var busses: Dictionary = {"Master" = 0, "music" = 0, "sfx" = 0}

@onready var volume: Array[VSlider] = [$volume/audioMaster/volume, $volume/audioSFX/volume, $volume/audioMusic/volume]

func _ready() -> void:
	for i: String in busses:
		busses[i] = AudioServer.get_bus_index(i)
	volume[0].value = db_to_linear(AudioServer.get_bus_volume_db(busses["Master"]))
	volume[1].value = db_to_linear(AudioServer.get_bus_volume_db(busses["sfx"]))
	volume[2].value = db_to_linear(AudioServer.get_bus_volume_db(busses["music"]))
	$volume/audioMaster/masterMute.button_pressed = AudioServer.is_bus_mute(busses["Master"])
	$volume/audioSFX/sfxMute.button_pressed = AudioServer.is_bus_mute(busses["sfx"])
	$volume/audioMusic/musicMute.button_pressed = AudioServer.is_bus_mute(busses["music"])

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busses["Master"], linear_to_db(value))

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busses["sfx"], linear_to_db(value))

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(busses["music"], linear_to_db(value))

func _on_masterMute_toggled(toggled_on: bool) -> void:
	volume[0].editable = not toggled_on
	AudioServer.set_bus_mute(busses["Master"], toggled_on)

func _on_sfxMute_toggled(toggled_on: bool) -> void:
	volume[1].editable = not toggled_on
	AudioServer.set_bus_mute(busses["sfx"], toggled_on)

func _on_musicMute_toggled(toggled_on: bool) -> void:
	volume[2].editable = not toggled_on
	AudioServer.set_bus_mute(busses["music"], toggled_on)
