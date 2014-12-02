class Blog(object):

	def __init__(self, id, name, description, content):
		self.id = id
		self.update_blog(name, description, content)

	def get_blog(self):
		data = {
			'id': self.id,
			'name': self.name,
			'description': self.description,
			'content': self.content
		}
		return data

	def get_index(self):
		data = {
			'id': self.id,
			'name': self.name,
			'description': self.description,
		}
		return data

	def update_blog(self, name, description, content):
		self.name = name
		self.description = description
		self.content = content
