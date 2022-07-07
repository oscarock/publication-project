import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="publication"
export default class extends Controller {
  connect() {
  }
  validations(){
    var forms = document.querySelectorAll('.needs-validation')

    Array.prototype.slice.call(forms)
        .forEach(function (form) {
          form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
              event.preventDefault()
              event.stopPropagation()
            }

            form.classList.add('was-validated')
          }, false)
        })
  }
}
