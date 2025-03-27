import requests as fetch
import pandas as pd 
import random
import csv 
# Fetching products from fakestore
response = fetch.get("https://fakestoreapi.com/products")
products = response.json()

# function to generate images
def generate_images(count=4):
    return [f"https://picsum.photos/200/300?random={random.randint(0,1000)}" for  _ in range(count)]

#Creating DataFrames with s_no,product_name and input_images

df = pd.DataFrame({
    "S_No": range(1,len(products) +1),
    "product_name":[product["title"] for product in products],
    "input_images" : [generate_images() for _ in range(len(products))]
})

df.to_csv("test_data_image_service.csv",index=False,quoting=csv.QUOTE_MINIMAL)

print("CSV file with valid product data and input image urls generated")