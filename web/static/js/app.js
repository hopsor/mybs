// import Elm from './main';
//
// const elmDiv = document.getElementById('elm-main')
//
// if (elmDiv) {
//   Elm.Main.embed(elmDiv);
// }

import * as d3 from "d3";

function transformDataset(data){
  let years = new Set(
    data.map((item) => new Date(item.started_at).getFullYear())
  );

  return Array.from(years).map((year) => {
    let acum = 0;

    const values = data.filter((item) => new Date(item.started_at).getFullYear() == year)
      .map((item) => {
        const currentDate = new Date(item.started_at);
        const fDate = new Date(1900, currentDate.getMonth(), currentDate.getDate());
        acum += item.distance;
        return { f_date: fDate, acum: acum };
    });

    return {
      id: year,
      values: values,
      max_distance: acum
    };
  });
};

let svg     = d3.select("svg"),
    width   = svg.attr("width"),
    height  = svg.attr("height");

let x = d3.scaleTime().rangeRound([0, width]);
let y = d3.scaleLinear().rangeRound([height, 0]);
let line = d3.line()
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.acum); });

d3.json("/api/races", function(data){
  console.log(transformDataset(data));
});
