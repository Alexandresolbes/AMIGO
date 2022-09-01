import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="random-wheel"
export default class extends Controller {
  static targets = ["wheel", "photo"]

  connect() {
  }

  spin(event){
    event.preventDefault();
    this.wheelTarget.classList.add("d-none");
    for (this.photoCounter = this.photoTargets.length - 1; this.photoCounter < 0; this.photoCounter--) {
      setTimeout(hide(this.photoCounter), 3000);
    }
  }

  hide(i){
    this.photoTargets[i].classList.add("d-none");
  }
}
