import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="random-wheel"
export default class extends Controller {
  static targets = ["carousel", "wheel", "users", "result", "restart", "randomize", "intro"]

  connect() {
    console.log("Connecté")
  }

  spin(event){
    event.preventDefault()
    this.introTarget.classList.add("d-none")
    this.wheelTarget.classList.add("d-none")
    this.randomizeTarget.classList.add("d-none")
    this.carouselTarget.classList.remove("d-none")
    setTimeout(() => this.#hide(), 5000);
  }

  restart(event){
    event.preventDefault()
    location.reload()
    this.introTarget.classList.remove("d-none")
    this.resultTarget.classList.add("d-none")
    this.restartTarget.classList.add("d-none")
    this.wheelTarget.classList.remove("d-none")
    this.randomizeTarget.classList.remove("d-none")
  }

  #hide() {
    console.log("hide func")
    this.carouselTarget.classList.add("d-none")
    this.resultTarget.classList.remove("d-none")
    this.randomizeTarget.classList.add("d-none")
    this.restartTarget.classList.remove("d-none")
  }
}
