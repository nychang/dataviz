const w = 800;
const h = 400;

var easeType = d3.easeCubic;

function makeRatingsStack(appendTo) {
    // make svg element (box that dots will go into)
    var svg = d3.select(appendTo)
        .append("svg")
        .attrs({
            width: w,
            height: h,
            class: "chart"
        });

    var margin = {
            top: 40,
            right: 40,
            bottom: 40,
            left: 40
        },
        width = +svg.attr("width") - margin.left - margin.right,
        height = +svg.attr("height") - margin.top - margin.bottom,
        g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var x = d3.scaleBand()
        .rangeRound([0, width])
        .padding(0.1)
        .align(0.1);

    var y = d3.scaleLinear()
        .rangeRound([height, 0]);

    // low to high
    var z = d3.scaleOrdinal()
        .range(["#EF4747", "#FF9859", "#FFE74C", "#4FB2FF", "#48F259"]);

    var stack = d3.stack();

    var legend;

    d3.csv("stacked-column-percent-tp.csv", function(error, data) {

        if (error) throw error;

        // data.sort(function(a, b) { return b.total - a.total; });

        x.domain(data.map(function(d) { return d.districtcode; }));

        y.domain([0, 100]);

        z.domain(data.columns.slice(1));

        g.selectAll(".field-column")
            .data(stack.keys(data.columns.slice(1))(data))
            .enter()
            .append("g")
            .attrs({
                class: "field-column",
                fill: function(d) {
                    return z(d.key);
                }
            })
            .selectAll("rect")
            .data(function(d) {
                return d;
            })
            .enter()
            .append("rect")
            .attrs({
                x: function(d) {
                    return x(d.data.districtcode);
                },
                y: function(d) {
                    return y(d[1]);
                },
                height: function(d) {
                    return y(d[0]) - y(d[1]);
                },
                width: x.bandwidth()
            });

        g.append("g")
            .attrs({
                class: "axis x-axis",
                transform: "translate(0," + height + ")"
            })
            .call(d3.axisBottom(x));

        g.append("g")
            .attr("class", "axis y-axis")
            .call(d3.axisLeft(y).ticks(10, "s"));

        svg.append("text")
           .attrs({
                transform: "translate(" + (width/2) + " ," + (height + margin.top + 20) + ")",
                dx: "2em",
                dy: "2.2em",
                "text-anchor": "middle",
                class: "axis-label"
           })
           .text("District");

        svg.append("text")
           .attrs({
                transform: "rotate(-90)",
                x: 0 - (height / 2),
                y: 0 - margin.left,
                dx: "-3em",  // changes vertical because of rotation
                dy: "1.8em",  // changes horizontal
                "text-anchor": "middle",
                class: "axis-label"
           })
           .text("Percent")
      


        legend = g.selectAll(".legend")
                  .data(data.columns.slice(1).reverse())
                  .enter()
                  .append("g")
                  .attrs({
                    class: "legend",
                    transform: function(d, i) {
                        return "translate(0," + i * 20 + ")";
                    }
                  })
                  .style("font", "12px sans-serif");

        legend.append("rect")
              .attrs({
                x: width,
                width: 18,
                height: 18,
                fill: z
              });

        legend.append("text")
              .attrs({
                x: width + 24,
                y: 9,
                dy: "0.35em",
                "text-anchor": "start"
              })
              .text(function(d) { return d; });

    }); // closes motp csv


    d3.select("#motp-ratings-percent")
      .on("click", function() {

            d3.csv("stacked-column-percent-tp.csv", function(error, data) {

                if (error) throw error;

                g.selectAll(".field-column")
                    .data(stack.keys(data.columns.slice(1))(data))
                    // .enter()
                    // .append("g")
                    .attrs({
                        class: "field-column",
                        fill: function(d) {
                            return z(d.key);
                        }
                    })
                    .selectAll("rect")
                    .data(function(d) {
                        return d;
                    })
                    // .enter()
                    // .append("rect")
                    .transition()
                    .duration(1000)
                    .ease(easeType)
                    .attrs({
                        x: function(d) {
                            return x(d.data.districtcode);
                        },
                        y: function(d) {
                            return y(d[1]);
                        },
                        height: function(d) {
                            return y(d[0]) - y(d[1]);
                        },
                        width: x.bandwidth()
                    });

                // not changing axes or legend

            }); // closes motp csv

        }) // closes motp on





    d3.select("#mosl-state-ratings-percent")
        .on("click", function() {

            d3.csv("doe-stack-percent-mosl-state.csv", function(error, data) {

                if (error) throw error;

                g.selectAll(".field-column")
                    .data(stack.keys(data.columns.slice(1))(data))
                    // .enter()
                    // .append("g")
                    .attrs({
                        class: "field-column",
                        fill: function(d) {
                            return z(d.key);
                        }
                    })
                    .selectAll("rect")
                    .data(function(d) {
                        return d;
                    })
                    // .enter()
                    // .append("rect")
                    .transition()
                    .duration(1000)
                    .ease(easeType)
                    .attrs({
                        x: function(d) {
                            return x(d.data.districtcode);
                        },
                        y: function(d) {
                            return y(d[1]);
                        },
                        height: function(d) {
                            return y(d[0]) - y(d[1]);
                        },
                        width: x.bandwidth()
                    });

                // not changing axes or legend

            }); // closes mosl state csv

        }) // closes mosl state on



    d3.select("#mosl-local-ratings-percent")
        .on("click", function() {

            d3.csv("doe-stack-percent-mosl-local.csv", function(error, data) {

                if (error) throw error;

                g.selectAll(".field-column")
                    .data(stack.keys(data.columns.slice(1))(data))
                    // .enter()
                    // .append("g")
                    .attrs({
                        class: "field-column",
                        fill: function(d) {
                            return z(d.key);
                        }
                    })
                    .selectAll("rect")
                    .data(function(d) {
                        return d;
                    })
                    // .enter()
                    // .append("rect")
                    .transition()
                    .duration(1000)
                    .ease(easeType)
                    .attrs({
                        x: function(d) {
                            return x(d.data.districtcode);
                        },
                        y: function(d) {
                            return y(d[1]);
                        },
                        height: function(d) {
                            return y(d[0]) - y(d[1]);
                        },
                        width: x.bandwidth()
                    });

                // not changing axes or legend

            }); // closes mosl local csv

        }) // closes mosl local on

} // closes makeRatingsStack



function makePointsStack(appendTo) {
    // make svg element (box that dots will go into)
    var svg = d3.select(appendTo)
        .append("svg")
        .attrs({
            width: w,
            height: h,
            class: "chart"
        });

    var margin = {
            top: 40,
            right: 40,
            bottom: 40,
            left: 40
        },
        width = +svg.attr("width") - margin.left - margin.right,
        height = +svg.attr("height") - margin.top - margin.bottom,
        g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    var x = d3.scaleBand()
        .rangeRound([0, width])
        .padding(0.1)
        .align(0.1);

    var y = d3.scaleLinear()
        .rangeRound([height, 0]);

    // low to high
    var z = d3.scaleOrdinal()
        .range(["#EF4747", "#FF9859", "#FFE74C", "#4FB2FF", "#48F259"]);

    var stack = d3.stack();

    let categories = ["Highly Ineffective", "Ineffective", "Developing", "Effective", "Highly Effective"];

    d3.csv("district12.csv", function(error, data) {

        if (error) throw error;

        // data.sort(function(a, b) { return b.total - a.total; });

        x.domain(data.map(function(d) {
            return d.lastName;
        }));

        y.domain([0, 100]);

        // z.domain(data.columns.slice(16, data.columns.length));
        z.domain(categories);

        g.selectAll(".field-column")
            .data(stack.keys(data.columns.slice(1))(data))
            .enter()
            .append("g")
            .attrs({
                class: "field-column",
                fill: function(d) { return z(d.key); },
                stroke: "#FFF"
            })
            .selectAll("rect")
            .data(function(d) {
                return d;
            })
            .enter()
            .append("rect")
            .attrs({
                x: function(d) { return x(d.data.lastName); },
                y: function(d) { if (d[1]) return y(d[1]); },
                height: function(d) { return y(d[0]) - y(d[1]); },
                width: x.bandwidth()
            });

        g.append("g")
            .attrs({
                class: "axis x-axis",
                transform: "translate(0," + height + ")"
            })
            .call(d3.axisBottom(x));

        g.append("g")
            .attr("class", "axis y-axis")
            .call(d3.axisLeft(y).ticks(10, "s"));

        svg.append("text")
           .attrs({
                transform: "translate(" + (width/2) + " ," + (height + margin.top + 20) + ")",
                dx: "2em",
                dy: "2.2em",
                "text-anchor": "middle",
                class: "axis-label"
           })
           .text("Last Name");

        svg.append("text")
           .attrs({
                transform: "rotate(-90)",
                x: 0 - (height / 2),
                y: 0 - margin.left,
                dx: "-3em",  // changes vertical because of rotation
                dy: "1.8em",  // changes horizontal
                "text-anchor": "middle",
                class: "axis-label"
           })
           .text("Points")
      


        let legend = g.selectAll(".legend")
            .data(categories.reverse())
            .enter()
            .append("g")
            .attrs({
                class: "legend",
                transform: function(d, i) {
                    return "translate(0," + i * 20 + ")";
                }
            })
            .style("font", "12px sans-serif");

        // ratings (highly ineffective thru highly effective)
        legend.append("rect")
            .attrs({
                x: width,
                width: 18,
                height: 18,
                fill: z
            });

        legend.append("text")
            .attrs({
                x: width + 24,
                y: 9,
                dy: "0.35em",
                "text-anchor": "start"
            })
            .text(function(d) { return d; });

        let legend2 = g.selectAll(".legend2")
            .data(["TP", "SP State", "SP Local"].reverse())
            .enter()
            .append("g")
            .attrs({
                class: "legend",
                transform: function(d, i) {
                    return "translate(0," + i * 20 + ")";
                }
            })
            .style("font", "12px sans-serif");

        // assessment (motp, mosl state, mosl local)
        legend2.append("rect")
            .attrs({
                x: width,
                y: 140,
                width: 18,
                height: 40,
                fill: "#CCC",
                stroke: "#FFF"
            });

        legend2.append("text")
            .attrs({
                x: width + 24,
                y: 149,
                dy: "0.35em",
                "text-anchor": "start"
            })
            .text(function(d) { return d; });

    }); // closes motp csv

} // closes makeStack














