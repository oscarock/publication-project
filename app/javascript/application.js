// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"
import "popper"
import "bootstrap"
import "trix"
import "@rails/actiontext"

$('.toast-top-right').delay(2000).hide(500);

$('.toast-close-button').on("click", function() {
    $(".toast-top-right").hide()
})