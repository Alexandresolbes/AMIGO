import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['inputCity','displayCity', 'date', 'desc', 'img', 'temp']

  connect() {
    console.log("coucou")
    this.apiKey = "8fb2d6628d33c7f495dbd77884e26a45";
    navigator.geolocation.getCurrentPosition((data) => {
      this.fetchWeather(data.coords.latitude, data.coords.longitude, this.apiKey);
    });
    //
  };

  fetchCity(city, apiKey){
    fetch(`http://api.openweathermap.org/geo/1.0/direct?q=${city}&limit=1&appid=${apiKey}`)
    .then(response => response.json())
    .then((data => {
      this.fetchWeather(data[0].lat, data[0].lon, apiKey);
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
    this.inputCityTarget.placeholder = `Current location : ${name}`;
    this.displayCityTarget.innerText = name;
    this.options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    this.dateTarget.innerText = new Date().toLocaleDateString('fr-FR', this.options);
    this.imgTarget.src = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`;
    this.descTarget.innerText =`${data.weather[0].main} (${data.weather[0].description})`;
    this.tempTarget.innerText = `${Math.round(data.main.temp)}°C`;
  }

  getCity(event) {
    event.preventDefault();
    this.apiKey = "8fb2d6628d33c7f495dbd77884e26a45";
    this.city = this.inputCityTarget.value;
    this.fetchCity(this.city, this.apiKey);
  }
}
