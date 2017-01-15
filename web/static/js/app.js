import Elm from './main';

const elmDiv = document.getElementById('elm-main')

if (elmDiv) {
  Elm.Main.embed(elmDiv);
}
