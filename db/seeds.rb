# fill DB with group, material, and task data
groups = [
	{ 
		name: 'Fabric', 
		materials: [
			{ name: 'Metallic', quantity: 'no', cost: 5 },
			{ name: 'Spandex', quantity: 'no', cost: 2 },
			{ name: 'Spandex Print', quantity: 'no', cost: 7 }
		]
	},
	{ 
		name: 'Fabric Upgrade', 
		materials: [
			{ name: 'Mesh Top, Lined', quantity: 'no', cost: 5 },
			{ name: 'Mesh Sleeves, Unlined', quantity: 'no', cost: 2 }
		]
	},
	{ 
		name: 'Rhinestones', 
		materials: [
			{ name: 'Small Motif', quantity: 'yes', cost: 5 },
			{ name: 'Medium Motif', quantity: 'yes', cost: 10 },
			{ name: 'Large Motif', quantity: 'yes', cost: 15 }
		]
	},
	{ 
		name: 'Enhancement', 
		materials: [
			{ name: 'Sublimation', quantity: 'no', cost: 20 }
		]
	}
]

tasks = [
	{ name: 'Coverstitch', minutes: 3, seconds: 0, rate: 20},
	{ name: 'Cut Out Body', minutes: 2, seconds: 0, rate: 20},
	{ name: 'Cut Out Liner', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Cut Out Mesh', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Cut Out Sleeves', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Elastic', minutes: 5, seconds: 0, rate: 20},
	{ name: 'Hand Set Rhinestones Body', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Hand Set Rhinestones Sleeves', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Heat Press Applique', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Heat Press Motif Body', minutes: 2, seconds: 0, rate: 20},
	{ name: 'Heat Press Motif Sleeves', minutes: 2, seconds: 0, rate: 20},
	{ name: 'Pin Front', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Pin Back', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Seams', minutes: 5, seconds: 0, rate: 20},
	{ name: 'Sleeves On', minutes: 3, seconds: 0, rate: 20},
	{ name: 'Topstitch Applique Massive', minutes: 15, seconds: 0, rate: 20},
	{ name: 'Topstitch Applique Straight Line', minutes: 2, seconds: 0, rate: 20},
	{ name: 'Topstitch Applique Swirly', minutes: 5, seconds: 0, rate: 20},
	{ name: 'Topstitch Front/Back', minutes: 1, seconds: 0, rate: 20},
	{ name: 'Topstitch Lavish', minutes: 20, seconds: 0, rate: 20}
]

groups.each do |group|
	g = Group.create!(
		name: group[:name]
	)
	
	group[:materials].each do |material|
		g.materials.create!(
			name: material[:name], 
			quantity: material[:quantity], 
			cost: material[:cost]
		)
	end
end

tasks.each do |task|
	Task.create!(
		name:    task[:name],
		minutes: task[:minutes],
		seconds: task[:seconds],
		rate:    task[:rate]
	)
end