import os
import dotenv
import flask
import requests


dotenv.load_dotenv()


print(os.environ)

if os.environ.get("ENV") == "vm":
    host = "0.0.0.0"
    port = 80
else:
    host = "localhost"
    port = 8080


app = flask.Flask(__name__)

app.config["OAUTH2"] = {
    "google": {
        "client_id": os.environ.get("GOOGLE_CLIENT_ID"),
        "data": {
            "url": "https://www.googleapis.com/oauth2/v3/userinfo",
            "email": lambda json: json["email"],
        },
    }
}


def oauth2_verify() -> str:
    access_token = flask.request.headers.get("Authorization")

    if not access_token:
        return None

    provider = flask.request.args.get("provider")

    if provider not in app.config["OAUTH2"]:
        return None

    metadata = app.config["OAUTH2"][provider]["data"]

    response = requests.get(
        metadata["url"],
        headers={
            "Authorization": access_token,
            "Accept": "application/json",
        },
    )
    if response.status_code != 200:
        return None

    return metadata["email"](response.json())


@app.route("/restricted/endpoint")
def restricted_endpoint():
    email = oauth2_verify()

    if email:
        return flask.jsonify({"email": email})
    else:
        return flask.jsonify({"error": "Unauthorized"}), 401


if __name__ == "__main__":
    app.run(host=host, port=port)
