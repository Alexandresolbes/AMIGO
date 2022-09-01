import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="random-wheel"
export default class extends Controller {
  static targets = ["carousel", "wheel", "users", "result", "restart", "randomize"]

  connect() {
    console.log("Connecté")
  }

  spin(event){
    event.preventDefault()
    this.wheelTarget.classList.add("d-none")
    this.carouselTarget.classList.remove("d-none")
    setTimeout(() => this.#hide(), 5000);
  }

  restart(){
    document.reload()
  }

  #hide() {
    console.log("hide func")
    this.carouselTarget.classList.add("d-none")
    this.resultTarget.classList.remove("d-none")
    this.randomizeTarget.classList.add("d-none")
    this.restartTarget.classList.remove("d-none")
  }
}