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
  // #post_raty の要素を探す
  let elem = document.querySelector('#post_raty');

  // もし #post_raty がこのページに存在したら
  if (elem) {
    let opt = {
      // HTMLの data-star-on/off から画像パスを取得
      starOn: elem.dataset.starOn,
      starOff: elem.dataset.starOff,
      scoreName: 'post[score]'
    };
    
    // application.js で定義済みの window.raty を呼び出す
    raty(elem, opt);
  }

  let displayElems = document.querySelectorAll('.score-display');
  
  // 取得したすべての要素に対して、それぞれRatyを適用
  displayElems.forEach(function(displayElem) {
    
    // Ratyのオプションを設定
    let opt = {
      // data属性から画像パスを取得
      starOn: displayElem.dataset.starOn,
      starOff: displayElem.dataset.starOff,
      
      // データベースから取得したスコアを data-score から読み込む
      score: displayElem.dataset.score,
      
      // ▼重要▼ 読み取り専用（クリック不可）にする
      readOnly: true 
    };
    
    // 一覧表示用Ratyを実行
    raty(displayElem, opt);
  });
}

document.addEventListener("turbolinks:load", initializeRaty);
