extends Node

var tower_data = {
	"GunT1": {"damage": 20, "rof": 0.3, "range": 350, "category": "Projectile", "price": 100},
	"MissleT1": {"damage": 100, "rof": 3, "range": 550, "category": "Missile", "price": 400}	
}

var user_data = null # TODO

var wave_data = [
	{"tanks": 
		[
			{"type": "BlueTank", "delay": 1.5, "repeat": 1},
			{"type": "BlueTank", "delay": 0.5, "repeat": 4}
		]
	},
	{"tanks": 
		[
			{"type": "BlueTank", "delay": 0.4, "repeat": 8},
			{"type": "RedTank", "delay": 2.5, "repeat": 1}
		]
	},
]
