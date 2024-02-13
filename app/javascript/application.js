// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import $ from "jquery"

$(document).ready(function () {
  $(document).off('click.dropdownButton', '.dropdown-button').on('click.dropdownButton', '.dropdown-button', function () {
    $(this).next('.dropdown-content').toggle(60);
  });

  $(document).off('click.dropdownContent').on('click.dropdownContent', function (event) {
    if (!$(event.target).closest('.dropdown').length) {
      $('.dropdown-content').hide();
    }
  });
});
