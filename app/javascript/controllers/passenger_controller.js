import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "formTemplate", "formContainer", "formField" ];

  formFieldTargetConnected() {
    this.setAttributes();
  }

  formFieldTargetDisconnected() {
    this.setAttributes();
  }

  add() {
    let clone = this.formTemplateTarget.content.firstElementChild.cloneNode(true);
    this.formContainerTarget.appendChild(clone);
  }

  remove(event) {
    event.preventDefault();
    let index = event.params.index;
    this.formFieldTargets[index].remove();
  }

  setAttributes() {
    this.formFieldTargets.forEach((field, index) => {
      let nameInput = field.children[0].firstElementChild;
      nameInput.name = `booking[passengers_attributes][${index}][name]`
      nameInput.id =  `booking_passengers_attributes_${index}_name`
      
      let emailInput = field.children[1].firstElementChild;
      emailInput.name = `booking[passengers_attributes][${index}][email]`
      emailInput.id =  `booking_passengers_attributes_${index}_email`

      let button = field.children[2];
      button.dataset.passengerIndexParam = index;
    })
  }
}