from rapidfuzz import fuzz
import pandas as pd
import numpy as np
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import ast

class recommender_system:
    #allergies is a list he can have many allergies
    #height cm, weight in kg

    def __init__(self, Restrictions : str , Allergies : list[str] , Meal_type: str, Time: int, Cooking_skills: str, Cuisine: str, flavor : str, Spicy_level : str , Height : int , Weight : int, Activity_Level: str, Gender : str, Age : int, n_meals : int, Goal: str):
        self.Restrictions = Restrictions #
        self.Allergies = Allergies #
        self.Meal_type = Meal_type #
        self.Time = Time #
        ########################################
        self.Cooking_skills = Cooking_skills #handle cooking skills
        #######################################
        self.Cuisine = Cuisine #
        self.flavor = flavor #
        self.Spicy_level = Spicy_level #
        self.Height = Height #
        self.Weight = Weight #
        self.Activity_Level = Activity_Level #
        self.Gender = Gender #
        self.Age = Age #
        self.n_meals = n_meals #
        self.Goal = Goal #
        self.query = {}
        self.embeddings_object = np.load('embeddings.npy',  allow_pickle=True)
        self.embeddings = self.embeddings_object[:, -1]


        file_path = 'RAW_recipes.csv'

        columns_to_use = [
            "name", "id", "minutes", 
            "nutrition", "n_steps", "steps", 
            "ingredients", "n_ingredients"
        ]



        try:
            df = pd.read_csv(file_path, usecols=columns_to_use, quotechar='"')
        except pd.errors.ParserError as e:
            print(f"Error reading CSV: {e}")
            # Attempt to read the CSV with error handling
            df = pd.read_csv(
                file_path,
                usecols=columns_to_use,
                on_bad_lines='skip',       
                quotechar='"',             
                engine='python'            
            )
            print("CSV read with error handling (skipping bad lines).")
        df.head()

        df['nutrition'] = df['nutrition'].apply(lambda x: ast.literal_eval(x) if isinstance(x, str) else x)
        df['steps'] = df['steps'].apply(lambda x: ast.literal_eval(x) if isinstance(x, str) else x)
        df['ingredients'] = df['ingredients'].apply(lambda x: ast.literal_eval(x) if isinstance(x, str) else x)
        df['n_steps'] = df['n_steps'].astype(int)
        df['n_ingredients'] = df['n_ingredients'].astype(int)
        df['minutes'] = df['minutes'].astype(int)
        
        self.dataset = df





    def mapping(self):
        self.query['text_similarity_input'] = self.Restrictions + " " + self.Meal_type + " " + self.Cuisine + " " + self.flavor + " " + self.Spicy_level + " "
        model = SentenceTransformer('nli-distilroberta-base-v2')
        self.query['embeddings'] =  model.encode(self.query['text_similarity_input'])
        if self.Gender == "male":
            calories = 88.4 + 13.4 * self.Weight  + 4.8 * self.Height  - 5.68 * self.Age

        else:
            calories = 447.6 + 9.25 * self.Weight  + 3.10 * self.Height - 4.33 * self.Age
        
        activity_levels = {
            "Less active": 1.2,
            "Lightly active": 1.375,
            "Moderately active": 1.55,
            "Very active": 1.725,
            "Extra active": 1.9
        }

        calories *= activity_levels[self.Activity_Level]
        self.query["Time"] = self.Time
        #calories, total fat , sugar , sodium , protein , saturated fat
        self.query["nutrients"] = [calories*1/self.n_meals , 1/self.n_meals , 1/self.n_meals , 1/self.n_meals , 1/self.n_meals , 1/self.n_meals , 1/self.n_meals ]

        if self.Goal == "Weight loss":
            self.query["nutrients"][0] -= 500
        elif self.Goal == "Weight gain":
            self.query["nutrients"][0] += 500
        elif self.Goal == "Muscle building":
            self.query["nutrients"][4] *= 1.5
        elif self.Goal == "Heart health":
            self.query["nutrients"][5] = 0
        elif self.Goal == "Diabetes management":
            self.query["nutrients"][2] = 0
        elif self.Goal == "Athletic performance":
            self.query["nutrients"][4] *= 1.5
            self.query["nutrients"][3] *= 1.5

    #implement the logic to filter the candidates
    def is_allergen(self, ingredient , threshold=85 ):
        for allergy in self.Allergies:
            if fuzz.partial_ratio(ingredient.lower(), allergy.lower()) > threshold:
                return True
        return False

    def distance(self, query, row, row_embedding): 
        distance = 0
        distance_score = 1 - cosine_similarity([query['embeddings']], [row_embedding]).flatten()[0]
        distance += abs(distance_score)
        time_distance = np.linalg.norm([query["Time"] - row["minutes"]])
        distance += abs(time_distance)
        nutrients_distance = np.linalg.norm(np.array(query["nutrients"]) - np.array(row["nutrition"]))
        distance += abs(nutrients_distance)
        return distance
    
    def return_recommendation(self):
        distances = []
        for (_, row), row_emb in zip(self.dataset.iterrows(), self.embeddings):
            dist = self.distance(self.query, row, row_emb)
            distances.append(dist)
        
        nearest_index = np.argmin(distances)    
        nearest_instance = self.dataset.iloc[nearest_index]
        return nearest_instance
