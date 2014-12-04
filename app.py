from bottle import route, run, template, response, request, HTTPResponse
import json
from blog import Blog

blogs = []
cur_id = 1

def get_blogs():
	return blogs

def parse_content(request):
	name = request.forms.get('name')
	description = request.forms.get('description')
	content = request.forms.get('content')
	return name, description, content

@route('/hello/<name>')
def hello(name):
    return template('<b>Hello {{name}}</b>!', name=name)


@route('/')
def index():
	data = []
	for blog in blogs:
		data.append(blog.get_index())
	json_val = json.dumps(data)
	response.content_type = "application/json"
	return json_val


@route('/blog/new', method='POST')
def new_blog():
	global cur_id
	name, description, content = parse_content(request)
	blogs.append(Blog(cur_id,name,description,content))
	cur_id+=1
	return HTTPResponse(status=200)

@route('/blog/<id>/delete', method='DELETE')
def delete_blog(id):
	if isinstance(id, str):
		id = int(id)
	ind = id-1
	blog = None
	try:
		blogs.pop(ind)
		return HTTPResponse(status=200)
	except:
		return HTTPResponse(status=404)

@route('/blog/<id>')
def blog_info(id):
	if isinstance(id, str):
		id = int(id)
	try:
		blog = blogs[id]
		response.content_type = "application/json"
		return json.dumps(blog.get_blog())
	except:
		return HTTPResponse(status=404)

@route('/blog/<id>/update', method="PUT")
def update_blog(id):
	name, description, content = parse_content(request)
	if isinstance(id, str):
		id = int(id)
	try:
		blogs[id].update_blog(name, description, content)
		return HTTPResponse(status=200)
	except:
		return HTTPResponse(status=404)


run(host='localhost', port=8080)

