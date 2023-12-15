extends Node3D

func play_song():
	$AudioStreamPlayer.stream = preload("res://Geoxor & poixone - I'm Here.mp3")
	$AudioStreamPlayer.play()
