# 📌 AWS Personalize: Movie Recommendation System

## **Overview**
AWS Personalize provides machine learning-based recommendation systems for applications. This guide explains how to create a **movie recommendation system** using AWS Personalize.

---

## **1️⃣ Components of AWS Personalize**
AWS Personalize consists of the following key components:

### **1. Datasets**
AWS Personalize requires three types of datasets:
- **User Data**: Contains user-related details (e.g., user ID, age, gender).
- **Item Data**: Contains item-related details (e.g., movie ID, genre, release date).
- **User Interaction Data**: Contains interactions between users and items (e.g., user watched a movie, ratings, clicks).

### **2. Recommenders**
Pre-configured recommendation models for common use cases:
| **Recommender** | **Description** |
|---------------|----------------|
| **"Because You Watched"** | Recommends movies based on past views |
| **"Most Popular"** | Shows trending movies |
| **"Similar Items"** | Finds movies similar to user preferences |

✅ **Best for Quick Deployment** with optimized settings.

### **3. Solutions**
A custom-trained **machine learning model** for personalized recommendations. It allows:
- Selecting specific algorithms
- Customizing training settings

✅ **More flexibility compared to Recommenders.**

### **4. Campaigns**
A **deployed version** of a solution that provides an API for real-time recommendations.

✅ **Allows apps to fetch movie recommendations via API.**

---

## **2️⃣ Types of AWS Personalize Recipes**
AWS Personalize offers different recipes based on recommendation types:

| **Recipe Name** | **Purpose** |
|---------------|------------|
| **User-Personalization** | Suggests movies based on user history |
| **Popularity-Count** | Recommends most popular movies |
| **SIMS (Similar Items)** | Suggests movies similar to a selected movie |
| **Personalized-Ranking** | Re-ranks a given list based on user preferences |

### **Which Recipe Should You Use?**
- **For Personalized Recommendations:** `User-Personalization`
- **For Trending Movies:** `Popularity-Count`
- **For Similar Movie Suggestions:** `SIMS`
- **For Re-ranking Existing Lists:** `Personalized-Ranking`

---

## **3️⃣ Steps to Build a Movie Recommendation System**

### **Step 1: Upload Data to S3**
Ensure your movie dataset (Users, Items, Interactions) is stored in an S3 bucket.

### **Step 2: Create Dataset Group & Import Data**
1. Create a **Dataset Group** in AWS Personalize.
2. Import **User, Item, and Interaction data** from S3.

### **Step 3: Train a Model (Solution)**
1. Choose a recipe (e.g., `User-Personalization`).
2. Train the solution on the dataset.

### **Step 4: Deploy a Campaign**
1. Deploy the trained **solution** as a **campaign**.
2. AWS provides an **API endpoint** to request recommendations.

### **Step 5: Get Movie Recommendations via API**
Use Python Boto3 to fetch recommendations from AWS Personalize.

#### **Example: Fetching Recommendations in Python**
```python
import boto3

# Initialize AWS Personalize client
personalize_runtime = boto3.client('personalize-runtime', region_name='us-east-1')

# Campaign ARN (Replace with your ARN)
campaign_arn = "arn:aws:personalize:us-east-1:123456789012:campaign/movie-recommendation"

# User ID for recommendation
user_id = "U123"

# Get recommendations
response = personalize_runtime.get_recommendations(
    campaignArn=campaign_arn,
    userId=user_id
)

# Print recommended movies
recommended_movies = [item['itemId'] for item in response['itemList']]
print("Recommended Movies:", recommended_movies)
```

✅ **Example Output:**
```bash
Recommended Movies: ['I202', 'I303', 'I505']
```

---

## **4️⃣ AWS Personalize Console Sections**
AWS Personalize Console includes the following sections:

| **Section** | **Purpose** |
|-----------|------------|
| **Dataset Groups** | Organizes datasets for different projects |
| **Datasets** | Stores User, Item, and Interaction data |
| **Recommenders** | Pre-built recommendation engines |
| **Solutions** | Custom-trained recommendation models |
| **Campaigns** | Deploys solutions to get real-time recommendations |
| **Batch Inference Jobs** | Generates recommendations in bulk |
| **Event Trackers** | Tracks user interactions in real-time |

---

## **5️⃣ Summary**
| **Component** | **Function** | **Example** |
|-------------|-------------|-------------|
| **Recommender** | Pre-configured model for recommendations | "Because You Watched" suggests movies |
| **Solution** | Custom ML model for recommendations | User-Personalization algorithm |
| **Campaign** | Deploys model as an API | Allows apps to get real-time recommendations |

🎯 **Final Notes:**
- Use **Recommenders** for quick results.
- Use **Solutions & Campaigns** for advanced customization.
- Integrate with **Boto3 API** to fetch recommendations in real-time.

🚀 **Now you're ready to build a Movie Recommendation System using AWS Personalize!**