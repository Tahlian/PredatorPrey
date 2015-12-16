		var plot = null;
		var legends = null;
                var updateLegendTimeout = null;
                var latestPosition = null;

                function updateLegend() {

                        updateLegendTimeout = null;

                        var pos = latestPosition;

                        var axes = plot.getAxes();
                        if (pos.x < axes.xaxis.min || pos.x > axes.xaxis.max ||
                                pos.y < axes.yaxis.min || pos.y > axes.yaxis.max) {
                                return;
                        }

                        var i, j, dataset = plot.getData();
                        for (i = 0; i < dataset.length; ++i) {

                                var series = dataset[i];

                                // Find the nearest points, x-wise

                                for (j = 0; j < series.data.length; ++j) {
                                        if (series.data[j][0] > pos.x) {
                                                break;
                                        }
                                }

                                // Now Interpolate

                                var y,
                                        p1 = series.data[j - 1],
                                        p2 = series.data[j];

                                if (p1 == null) {
                                        y = p2[1];
                                } else if (p2 == null) {
                                        y = p1[1];
                                } else {
                                        y = p1[1] + (p2[1] - p1[1]) * (pos.x - p1[0]) / (p2[0] - p1[0]);
                                }

                                legends.eq(i).text(series.label.replace(/=.*/, "= " + y.toFixed(2)));
                        }
}


function drawGraph(){
        $(function() {

		/*
				var d1 = [];
				for (var i = 0; i < 14; i += 0.5) {
					d1.push([i, Math.sin(i)]);
				}*/
		        var x0;
		        var y0;
		        var alpha, beta, delta, gamma;
		        var t=0.0;
		        var tfinal;
		        var nprint;
		        var h;
		        var n;
		        var i;
		        var xt;
		        var yt;
		        var xtph;
		        var ytph;
		        var MooseArray = [];
		        var WolfArray = [];
		        var TimeArray = [];

		        x0=parseInt(document.getElementById("store_prey").value);
		        console.log(document.getElementById("store_prey").value);
		        y0=parseInt(document.getElementById("store_predator").value);
		        console.log(document.getElementById("store_alpha").value);
		        //alpha=0.15;
		        alpha=parseFloat(document.getElementById("store_alpha").value);
		        //beta=0.001;
		        beta=parseFloat(document.getElementById("store_beta").value);
				//delta=0.00015;
		        delta=parseFloat(document.getElementById("store_delta").value);
		        //gamma=0.25;
		        gamma=parseFloat(document.getElementById("store_gamma").value);
		        h=parseFloat(document.getElementById("store_timeincrement").value) / 5;
		        nprint=5;
		        tfinal=parseFloat(document.getElementById("store_time").value);
				
		        n=tfinal/h;
		        xt=x0;
		        yt=y0;

		        console.log("t       Time      X(t) Moose   Y(t) Wolves");
		        var j = 0;
		        for(i=0;i<n;i++){
		                t=i*h;
		                if((i%nprint) ==0){
		                        MooseArray.push([t, xt]);
		                        WolfArray.push([t, yt]);
		                        TimeArray[j] = t;
		                        j++;
		                        console.log(t,xt,yt);
		                }
		                xtph = xt+h*(alpha*xt-beta*xt*yt);
		                ytph = yt+h*(delta*xt*yt-gamma*yt);
		                xt=xtph;
		                yt=ytph;
		        }
				console.log(MooseArray);

				plot = $.plot("#placeholder", [{
					data: MooseArray,
					label: "Moose = -00000.00",
					lines: { show: true }
				},{
					data:WolfArray,
					label: "Wolves = -00000.00",
					lines: { show: true }
				}],{
			series: {
				lines: { show: true },
				points: { show: true }
			}, yaxis: {
				font: {
					size: 14,
					lineHeight: 13,
					style: "italic",
					weight: "bold",
					family: "sans-serif",
					variant: "small-caps",
					color: "#ffffff"
				},
				color: "#bbb"//,
				//tickColor: "#fff"
			}, xaxis: {
				font: {
                                        size: 14,
                                        lineHeight: 13,
                                        style: "italic",
                                        weight: "bold",
                                        family: "sans-serif",
                                        variant: "small-caps",
                                        color: "#ffffff"
                                },
				tickColor: "#bbb"
			}, 
			colors: [ "red", "blue" ], 
			crosshair: {
				mode: "x",
				color: "yellow"
			},
			/*,
			xaxis: {
				ticks: [
					0, [ Math.PI/2, "\u03c0/2" ], [ Math.PI, "\u03c0" ],
					[ Math.PI * 3/2, "3\u03c0/2" ], [ Math.PI * 2, "2\u03c0" ]
				]
			}*//*,
			yaxis: {
				ticks: 10,
				min: -2,
				max: 2,
				tickDecimals: 3
			}*/
			grid: {
				//backgroundColor: { colors: [ "#111", "#eee" ] },
				color: "#fff",
				borderWidth: {
					top: 1,
					right: 1,
					bottom: 2,
					left: 2
				},
				hoverable: true,
				autoHighlight: false
			}, legend: {
				backgroundColor: null,
				backgroundOpacity: 0
			}
			});

				// Add the Flot version string to the footer

				$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
			});

	                legends = $("#placeholder .legendLabel");

        	        legends.each(function () {
       	        	        // fix the widths so they don't jump around
        	                $(this).css('width', $(this).width());
        	        });

			$("#placeholder").bind("plothover",  function (event, pos, item) {
                        latestPosition = pos;
                        if (!updateLegendTimeout) {
                                updateLegendTimeout = setTimeout(updateLegend, 50);
                        }
                });
}



