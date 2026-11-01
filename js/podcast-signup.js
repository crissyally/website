(function () {
  var section = document.getElementById('podcast-updates');
  var error = document.getElementById('podcast-interest-error');
  if (!section || !error) return;

  document.querySelectorAll('.subscribe-show[data-interest]').forEach(function (link) {
    link.addEventListener('click', function () {
      var value = link.getAttribute('data-interest');
      var choice = section.querySelector('input[name="tags[]"][value="' + value + '"]');
      if (choice) {
        choice.checked = true;
        choice.dispatchEvent(new Event('change', { bubbles: true }));
      }
    });
  });

  // Keep Kit's choices available to keyboard and screen-reader users.
  var observer;
  function prepareChoices() {
    var form = section.querySelector('form[data-uid="0fb829734d"]');
    if (!form) return false;
    var choices = form.querySelector('fieldset');
    if (!choices) return false;
    if (observer) observer.disconnect();
    if (choices && choices.parentElement.getAttribute('role') === 'button') {
      choices.parentElement.removeAttribute('role');
      choices.parentElement.removeAttribute('tabindex');
    }
    var name = form.querySelector('input[name="fields[first_name]"]');
    var email = form.querySelector('input[type="email"]');
    if (name && email) {
      name.autocomplete = 'given-name';
      var nameField = name.closest('.formkit-field');
      var emailField = email.closest('.formkit-field');
      if (nameField && emailField && nameField.parentElement === emailField.parentElement) {
        emailField.parentElement.insertBefore(nameField, emailField);
      }
    }
    if (email) email.autocomplete = 'email';
    return true;
  }
  if (!prepareChoices() && 'MutationObserver' in window) {
    observer = new MutationObserver(prepareChoices);
    observer.observe(section, { childList: true, subtree: true });
  }

  // Kit inserts its form asynchronously. Capture submission before Kit handles it.
  section.addEventListener('submit', function (event) {
    var form = event.target;
    if (!form.matches('form[data-uid="0fb829734d"]')) return;
    if (form.querySelector('input[name="tags[]"]:checked')) {
      error.hidden = true;
      return;
    }
    event.preventDefault();
    event.stopImmediatePropagation();
    error.hidden = false;
    var choices = form.querySelector('fieldset');
    if (choices) {
      choices.setAttribute('tabindex', '-1');
      choices.setAttribute('aria-describedby', error.id);
      choices.focus();
    }
  }, true);

  section.addEventListener('change', function (event) {
    if (event.target.matches('input[name="tags[]"]') &&
        section.querySelector('input[name="tags[]"]:checked')) {
      error.hidden = true;
      var choices = section.querySelector('fieldset');
      if (choices) choices.removeAttribute('aria-describedby');
    }
  });
})();
