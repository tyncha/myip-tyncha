from flask import Flask
from flask import request
from flask import jsonify

app = Flask(__name__)


@app.route("/", methods=["GET"])
def get_my_ip():
    info = {}

    info = {
        'IP' : request.environ.get('HTTP_X_REAL_IP')
        }
    
    # for key, value in request.environ.items():
    #     info[f"{key}"] = f"{value}"
        
    return jsonify(info), 200


if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
