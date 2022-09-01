import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['img', 'temp']

  connect() {
    /*
    navigator.geolocation.getCurrentPosition((data) => {
      this.fetchWeather(data.coords.latitude, data.coords.longitude, this.apiKey);
    });
    */
    this.fetchCity()
  };

  fetchCity(){
    this.apiKey = "8fb2d6628d33c7f495dbd77884e26a45";
    this.city = "Tokyo"
    fetch(`http://api.openweathermap.org/geo/1.0/direct?q=${this.city}&limit=1&appid=${this.apiKey}`)
    .then(response => response.json())
    .then((data => {
      this.fetchWeather(data[0].lat, data[0].lon, this.apiKey);
    }))
  };

  fetchWeather(cityLat, cityLon, apiKey) {
    fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${cityLat}&lon=${cityLon}&appid=${apiKey}&units=metric`)
    .then(response => response.json())
    .then((data => {
      this.displayWeather(data.name, data);
    }))
  }

  displayWeather(name, data) {
    this.imgTarget.src = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`;
    this.tempTarget.innerText = `${Math.round(data.main.temp)}°C`;
  }
}
