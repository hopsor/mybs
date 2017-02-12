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
    height  = svg.attr("height"),
    margin  = {top: 20, right: 80, bottom: 30, left: 50};
    //g       = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

let x = d3.scaleTime().rangeRound([0, width]);
let y = d3.scaleLinear().rangeRound([height, 0]);
let line = d3.line()
    .x(function(d) { return x(d.f_date); })
    .y(function(d) { return y(d.acum); });

// let xAxis = d3.axisBottom()
//   .scale(x)
//   .ticks(d3.time.months)
//   .tickFormat(d3.time.format("%B"))

let colors = d3.scaleOrdinal(d3.schemeCategory10);

d3.json("/api/races", function(data){
  const dataset = transformDataset(data);
  const maxDistance = d3.max(dataset, function(year) { return year.max_distance; });

  x.domain([new Date(1900, 0, 1), new Date(1900, 11, 31)]);
  y.domain([0, maxDistance]);

  // svg.append("g")
  //     .attr("class", "x axis")
  //     .attr("transform", "translate(0," + height + ")")
  //     .call(xAxis);

  let years = svg.selectAll(".year")
    .data(dataset)
    .enter()
    .append("g")
    .attr("class", "year");

  let path = years.append("path")
    .attr("class", "line")
    .attr("d", function(d){
      return line(d.values);
    })
    .style("stroke", function(d){ return colors(d.id); })
    .style("stroke-width", "2px")
    .style("fill", "none")
});
