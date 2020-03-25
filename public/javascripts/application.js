document.addEventListener('DOMContentLoaded', function() {
  const backButton = this.querySelector('#back')
  if(backButton) {
    backButton.addEventListener('click', () => window.history.back());
  }
});
