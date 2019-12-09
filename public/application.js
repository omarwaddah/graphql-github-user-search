//= require jquery
//= require bootstrap-sprockets
function loadMoreRepositories(link) {
  var container = link.parentElement;
  container.classList.add('loading');

  fetch(link.href).then(function(response) {
    response.text().then(function(text) {
      container.insertAdjacentHTML('afterend', text);
      container.remove();
    })
  })
}
// Basic event delegation
document.addEventListener('click', function(e) {
  var loadMoreLink = e.target.closest('.js-load-more')
  if (loadMoreLink) {
    loadMoreRepositories(loadMoreLink)
    e.preventDefault()
  }
})
