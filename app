import tkinter as tk
from tkinter import messagebox
import requests

# Replace with your own OpenWeatherMap API key
API_KEY = "your_api_key_here"
BASE_URL = "http://api.openweathermap.org/data/2.5/weather"

def get_weather(city):
    params = {
        'q': city,
        'appid': API_KEY,
        'units': 'metric'
    }
    try:
        response = requests.get(BASE_URL, params=params)
        response.raise_for_status()
        data = response.json()

        weather = data['weather'][0]['description'].title()
        temp = data['main']['temp']
        humidity = data['main']['humidity']
        wind = data['wind']['speed']

        result = f"Weather: {weather}\nTemperature: {temp}°C\nHumidity: {humidity}%\nWind Speed: {wind} m/s"
        return result
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"
    except KeyError:
        return "City not found. Please check the name and try again."

def show_weather():
    city = city_entry.get()
    if city:
        result = get_weather(city)
        result_label.config(text=result)
    else:
        messagebox.showwarning("Input Error", "Please enter a city name.")

# GUI setup
root = tk.Tk()
root.title("Weather App")
root.geometry("300x250")

tk.Label(root, text="Enter City Name:", font=("Helvetica", 12)).pack(pady=10)
city_entry = tk.Entry(root, width=25, font=("Helvetica", 12))
city_entry.pack()

tk.Button(root, text="Get Weather", command=show_weather, font=("Helvetica", 12)).pack(pady=10)

result_label = tk.Label(root, text="", font=("Helvetica", 12), justify="left")
result_label.pack(pady=10)

root.mainloop()
