class_name TerrainGenerator
extends Resource

# Can't be "Chunk.CHUNK_SIZE" due to cyclic dependency issues.
# https://github.com/godotengine/godot/issues/21461
const CHUNK_SIZE = 8

static func empty():
	return {}


static func get_noise():
	var noise = OpenSimplexNoise.new()
	noise.seed = "world".hash()
	noise.octaves = 2
	noise.period = 16.0
	noise.persistence = 0.5
	return noise

static func random_blocks():
	var random_data = {}
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			for z in range(CHUNK_SIZE):
				var vec = Vector3(x, y, z) # TODO: Vector3i
				if randf() < 0.01:
					random_data[vec] = randi() % 29 + 1
	return random_data


static func flat(chunk_position):
	var data = {}
	if abs(chunk_position.x) > 2 || abs(chunk_position.y) > 2 || abs(chunk_position.z) > 2:
		return data
	
	var noise = get_noise()
	
	var chunk_world_position = chunk_position * CHUNK_SIZE
	
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			for z in range(CHUNK_SIZE):
				var block_position = Vector3(x, y, z)
				if noise.get_noise_2d(chunk_world_position.x + x, chunk_world_position.z + z) * CHUNK_SIZE > chunk_world_position.y + y:
					data[block_position] = 3

	return data


# Used to create the project icon.
static func origin_grass(chunk_position):
	if chunk_position == Vector3.ZERO:
		return {Vector3.ZERO: 3}
	
	return {}
