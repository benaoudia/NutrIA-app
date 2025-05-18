from rec_sys import model, my_app
from flask import jsonify, request, send_file
import os


@my_app.route("/", methods=["GET"])
def root():
    return "<h1>Welcome to the main page</h1>"


@my_app.route("/recommand", methods=["POST"])
def predict_image():
    """
    Takes the answers of the quiz and returns a recommentation
    """
    Answers = request.get_json()

    if not Answers:
        return jsonify({"error": "No answers uploaded"}), 400

    try:
        Restrictions: str = Answers.get("Restrictions", "")
        Allergies: list[str] = Answers.get("Allergies", [])
        Meal_type: str = Answers.get("Meal_type", "")
        Time: int = int(Answers.get("Time", 0))
        Cooking_skills: str = Answers.get("Cooking_skills", "")
        Cuisine: str = Answers.get("Cuisine", "")
        flavor: str = Answers.get("flavor", "")
        Spicy_level: str = Answers.get("Spicy_level", "")
        Height: int = int(Answers.get("Height", 0))
        Weight: int = int(Answers.get("Weight", 0))
        Activity_Level: str = Answers.get("Activity_Level", "")
        Gender: str = Answers.get("Gender", "")
        Age: int = int(Answers.get("Age", 0))
        n_meals: int = int(Answers.get("n_meals", 0))
        Goal: str = Answers.get("Goal", "")
    except (ValueError, TypeError) as e:
        return jsonify({"error": f"Invalid input data: {str(e)}"}), 400

    recommender = model.recommender_system(
    Restrictions,
    Allergies,
    Meal_type,
    Time,
    Cooking_skills,
    Cuisine,
    flavor,
    Spicy_level,
    Height,
    Weight,
    Activity_Level,
    Gender,
    Age,
    n_meals,
    Goal
    )
    recommender.mapping()

    recommendation = recommender.return_recommendation()
    return jsonify(recommendation.to_dict())


