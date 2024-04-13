import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["exercise", "weightWrapper", "timeWrapper", "distanceWrapper"];

  connect() {
    this.updateFields();
  }

  updateFields() {
    const exercise = this.exerciseTarget.selectedOptions[0];
    const hasWeight = exercise.getAttribute('data-has-weight') === "true";
    const hasTime = exercise.getAttribute('data-has-time') === "true";
    const hasDistance = exercise.getAttribute('data-has-distance') === "true";
  
    this.weightWrapperTarget.style.display = hasWeight ? "block" : "none";
    this.timeWrapperTarget.style.display = hasTime ? "block" : "none";
    this.distanceWrapperTarget.style.display = hasDistance ? "block" : "none";
  }  
}
