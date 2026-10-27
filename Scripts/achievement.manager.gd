
extends Node

signal achievement_unlocked(achievement_name: String)

var unlocked_achievements: Dictionary = {
	"first_blood": false,
	"survivor": false,
	"untouchable": false,
	"space_legend": false
}

func unlock_achievement(achievement_id: String) -> void:
	if not unlocked_achievements.has(achievement_id):
		return

	if unlocked_achievements[achievement_id]:
		return

	unlocked_achievements[achievement_id] = true
	achievement_unlocked.emit(achievement_id)
	print("Achievement unlocked: ", achievement_id)

func is_unlocked(achievement_id: String) -> bool:
	return unlocked_achievements.get(achievement_id, false)
