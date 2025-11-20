// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";

import Raty from "raty.js"
window.raty = function(elem,opt) {
  let raty =  new Raty(elem,opt)
  raty.init();
  return raty;
}

Rails.start()
Turbolinks.start()
ActiveStorage.start()

function initializeRaty() {
  let elem = document.querySelector('#post_raty');

  if (elem) {

    elem.innerHTML = '';
    
    let opt = {
      starOn: elem.dataset.starOn,
      starOff: elem.dataset.starOff,
      scoreName: 'post[score]'
    };
    
    raty(elem, opt);
  }

  let displayElems = document.querySelectorAll('.score-display');
  
  displayElems.forEach(function(displayElem) {

    displayElem.innerHTML = '';

    let opt = {
      starOn: displayElem.dataset.starOn,
      starOff: displayElem.dataset.starOff,
      score: displayElem.dataset.score,
      readOnly: true 
    };
    
    raty(displayElem, opt);
  });
}

document.addEventListener("turbolinks:load", initializeRaty);
