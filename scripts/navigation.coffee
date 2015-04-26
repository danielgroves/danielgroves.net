---
---


class Navigation
  hiddenClass = 'hidden'
  showingClass = 'showing'
  hiddenPhrase = 'Show Nav'
  showingPhrase = 'Hide Nav'

  constructor: (toggle, navigation, defaultHidden) ->
    @toggle = document.querySelector(toggle)
    @navigation = document.querySelector(navigation)
    @defaultHidden = defaultHidden
    this.setDefault()

    this.toggle.addEventListener 'click', (event) =>
      this.click event

  setDefault: ->
    if @defaultHidden
      add = hiddenClass
    else
      add = showingClass

    @navigation.classList.add add

  click: (event) ->
    event.preventDefault()

    if @navigation.classList.contains showingClass
      @navigation.classList.remove showingClass
      @navigation.classList.add hiddenClass
      @toggle.innerHTML = hiddenPhrase

    else
      @navigation.classList.remove hiddenClass
      @navigation.classList.add showingClass
      @toggle.innerHTML = showingPhrase

ready = ->
  mainNavigation = new Navigation 'header .toggle', 'header nav', true

document.addEventListener 'DOMContentLoaded', ready
