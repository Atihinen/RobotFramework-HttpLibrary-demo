RobotFramework-HttpLibrary-demo
===============================

Demo how to use [robotframework](http://www.robotframework.org) and [httplibrary](https://github.com/bulkan/robotframework-requests/#readme) to test API


# Requirements for Robot Framework & HTTPLibrary
Check [requirements](https://github.com/Atihinen/RobotFramework-HttpLibrary-demo/blob/master/requirements.txt)

Or you can just run on repository root:
```shell
pip install -r requirements.txt
```

# API application
API is written in python using bottlepy library.

To run application just cd to root folder of the git repository:
```shell
python app.py
```

When API is running open browser [http://localhost:8080](http://localhost:8080)

#Running tests

cd to [tests/acceptance](https://github.com/Atihinen/RobotFramework-HttpLibrary-demo/tree/master/tests/acceptance) and run following command:
```shell
pybot .
```

##API documentation

HTTP method | url | params | returns
------------|-----|--------|--------
GET | / | None | [{id:0, name:"...", description:"..."}, ...]
GET | /blog/`<id>` | None | {id:0, name:"...", description: "...", content:"..."} / 404
PUT | /blog/`<id>`/update | name (string), description (string), content (string) | 200 / 404
POST | /new_blog | name (string), description (string), content (string) | 200
DELETE | /delete_blog/`<id>` | None | 200 / 404