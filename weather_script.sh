

Paper View
#!/bin/bash

API_KEY="YOUR_API_KEY"  # Replace with your OpenWeatherMap API key
LOCATION="$1"           # The location parameter passed as an argument

# Check if a location parameter is provided
if [ -z "$LOCATION" ]; then
  echo "Please provide a location."
  exit 1
fi

# Make a request to the OpenWeatherMap API
response=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$LOCATION&appid=$API_KEY&units=metric")

# Check if the request was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to retrieve weather information."
  exit 1
fi

# Parse the response to extract relevant information
weather=$(echo "$response" | jq -r '.weather[0].description')
temperature=$(echo "$response" | jq -r '.main.temp')
humidity=$(echo "$response" | jq -r '.main.humidity')
temp_max=$(echo "$response" | jq -r '.main.temp_max')
temp_min=$(echo "$response" | jq -r '.main.temp_min')
wind_speed=$(echo "$response" | jq -r '.wind.speed')
wind_deg=$(echo "$response" | jq -r '.wind.deg')
wind_gust=$(echo "$response" | jq -r '.wind.gust')

echo
while :
do
    clear
    cat<<EOF
    ==============================
    Weather Info Menu
    ------------------------------
    Please enter your choice:

    Press 1 for Temprature
    Press 2 for Humidity
    Press 3 for Description
    Press 4 for High and Low Temprature
    Press 5 for Wind Conditions
           (Q)uit
    ------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")  echo "Temperature: $temperature °C";;
    "2")  echo "Humidity: $humidity%";;
    "3")  echo "Description: $weather";;
    "4")  echo "High: $temp_max C  and Low: $temp_min C";;
    "5")  echo "Wind -> Speed: $wind_speed Degree: $wind_deg Gust: $wind_gust";;
    "Q")  exit;;
    "q")  exit;;
     * )  echo "invalid option" ;;
    esac
    sleep 3
done
exit 0
