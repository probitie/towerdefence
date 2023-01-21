extends Node

var tower_data = {
	"GunT1": {"damage": 15, "rof": 0.3, "range": 350, "category": "Projectile", "price": 50},
	"MissleT1": {"damage": 100, "rof": 3, "range": 550, "category": "Missile", "price": 400}	
}

var user_data = null # TODO
var tank_data = null
var map_data = null

# test waves
var wave_data = [
	{"tanks": 
		[
			{"type": "HeavyTank", "delay": 0.5, "repeat": 1},
		]
	},
	{"tanks": 
		[
			{"type": "BlueTank", "delay": 0.5, "repeat": 2},
		]
	},
	{"tanks": 
		[
			{"type": "BlueTank", "delay": 0.5, "repeat": 3},
		]
	},
	{"tanks": 
		[
			{"type": "RedTank", "delay": 0.5, "repeat": 1},
		]
	},
	{"tanks": 
		[
			{"type": "RedTank", "delay": 0.5, "repeat": 1},
		]
	}
]


# actual waves REMOVE UNDERSCORE _ from NAME
var wave_data_ = [
	{"tanks": 
		[
			{"type": "BlueTank", "delay": 2.5, "repeat": 1},
			{"type": "BlueTank", "delay": 1, "repeat": 6}
		]
	},
	{"tanks": 
		[
			{"type": "BlueTank", "delay": 0.8, "repeat": 8},
			{"type": "RedTank", "delay": 3, "repeat": 1}
		]
	},
	{"tanks": 
		[
			{"type": "RedTank", "delay": 0.8, "repeat": 5},
			{"type": "BlueTank", "delay": 0.2, "repeat": 10}			
		]
	},
	{"tanks": 
		[
			{"type": "RedTank", "delay": 0.2, "repeat": 2},
			{"type": "BlueTank", "delay": 0.2, "repeat": 20},
			{"type": "RedTank", "delay": 0.2, "repeat": 2},
			{"type": "BlueTank", "delay": 0.2, "repeat": 20}		
		]
	},
	{"tanks": 
		[
			{"type": "RedTank", "delay": 0.2, "repeat": 20},
			{"type": "RedTank", "delay": 1, "repeat": 1},
			{"type": "BlueTank", "delay": 0.1, "repeat": 50},
		]
	}
]
