extends Node3D

func play_song():
	$AudioStreamPlayer.stream = preload("res://cds moosic (2).mp3")
	$AudioStreamPlayer.play()
