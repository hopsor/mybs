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
    margin  = {top: 20, right: 80, bottom: 60, left: 100},
    width   = svg.attr("width") - margin.left - margin.right,
    height  = svg.attr("height") - margin.top - margin.bottom,
    g       = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

let x = d3.scaleTime().rangeRound([0, width]);
let y = d3.scaleLinear().rangeRound([height, 0]);
let line = d3.line()
    .x(function(d) { return x(d.f_date); })
    .y(function(d) { return y(d.acum); });

let colors = d3.scaleOrdinal(d3.schemeCategory10);

d3.json("http://localhost:4000/api/races", function(data){
  const dataset = transformDataset(data);
  const maxDistance = d3.max(dataset, function(year) { return year.max_distance; });

  x.domain([new Date(1900, 0, 1), new Date(1900, 11, 31)]);
  y.domain([0, maxDistance+50000]);

  g.append("g")
      .attr("class", "axis axis--x")
      .attr("transform", "translate(0," + height + ")")
      .call(
        d3.axisBottom(x)
          .tickFormat(
            d3.timeFormat("%B")
          )
      );

  g.append("g")
      .attr("class", "axis axis--y")
      .call(
        d3.axisLeft(y).tickFormat(function(d){ return d/1000 + " km"; })
      );

  let years = g.selectAll(".year")
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
    .style("stroke-width", "4px")
    .style("fill", "none")

  years.append("text")
      .datum(function(d) { return {id: d.id, value: d.values[d.values.length - 1]}; })
      .attr("transform", function(d) { return "translate(" + x(d.value.f_date) + "," + y(d.value.acum) + ")"; })
      .attr("x", 3)
      .attr("dy", "0.35em")
      .text(function(d) { return d.id; });
});
