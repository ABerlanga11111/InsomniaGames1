extends Node

const TRACKS = [
	preload("res://audio/Aerosol of my Love.mp3"),
	preload("res://audio/Burn The World Waltz .mp3"),
	preload("res://audio/Cloud Dancer.mp3"),
	preload("res://audio/Galactic Rap.mp3"),
	preload("res://audio/Mesmerizing Galaxy Loop.mp3")
] 
#too add more music, copy paste the above format for the name of the song
#and put the .mp3 file in the audio file. Case senstive
#the original 5 songs come from https://incompetech.com/music/royalty-free/music.html

const TRACK_NAMES = [
	"Aerosol of my love",
	"Burn the world waltz",
	"Cloud dancer",
	"Galactic rap",
    "Mesmerizing galaxy"
] 
#Then add the song name here. not case sensitive. this is what shows in the settings menu 
var music_player
var current_track = 0

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Master"
	add_child(music_player)
	music_player.finished.connect(loop_music)
	play_track(0) #default song is first in list

func play_track(track_number):
	if track_number < 0 or track_number >= TRACKS.size():
		return

	current_track = track_number
	music_player.stream = TRACKS[current_track]
	music_player.play()
	
func loop_music():
	music_player.play()
