<h1 class="ui dividing header">Dashboard</h1>
{{ javascript_include("js/chart.js") }}
<canvas id="myChart" width="100" height="100"></canvas>
<script>
    function addCommas(nStr)
    {
        nStr += '';
        x = nStr.split('.');
        x1 = x[0];
        x2 = x.length > 1 ? '.' + x[1] : '';
        var rgx = /(\d+)(\d{3})/;
        while (rgx.test(x1)) {
            x1 = x1.replace(rgx, '$1' + ',' + '$2');
        }
        return x1 + x2;
    }
    var ctx = document.getElementById("myChart");
    ctx.height = 30;
    var data = {
        labels: [
            {% for sale in sales %}
                '{{ sale.date|dateFormat }}'
                {% if NOT loop.last %},{% endif %}
            {% endfor %}
        ],

        datasets: [
            {
                label: "Sale Amount",
                fill: true,
                lineTension: 0.1,
                backgroundColor: "rgba(255,0,255,0.4)",
                borderColor: "rgba(255,0,255,1)",
                borderCapStyle: 'butt',
                borderDash: [],
                borderDashOffset: 0.0,
                borderJoinStyle: 'miter',
                pointBorderColor: "rgba(255,0,255,1)",
                pointBackgroundColor: "#fff",
                pointBorderWidth: 1,
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(255,0,255,1)",
                pointHoverBorderColor: "rgba(220,220,220,1)",
                pointHoverBorderWidth: 2,
                pointRadius: 1,
                pointHitRadius: 10,
                data: [ {% for sale in sales %}
                    {{ sale.total }}
                    {% if NOT loop.last %},{% endif %}
                    {% endfor %}],
                spanGaps: false,
            },
            {
                label: "Sale Count",
                fill: true,
                lineTension: 0.1,
                backgroundColor: "rgba(75,192,192,0.4)",
                borderColor: "rgba(75,192,192,1)",
                borderCapStyle: 'butt',
                borderDash: [],
                borderDashOffset: 0.0,
                borderJoinStyle: 'miter',
                pointBorderColor: "rgba(75,192,192,1)",
                pointBackgroundColor: "#fff",
                pointBorderWidth: 1,
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(75,192,192,1)",
                pointHoverBorderColor: "rgba(220,220,220,1)",
                pointHoverBorderWidth: 2,
                pointRadius: 1,
                pointHitRadius: 10,
                data: [ {% for sale in sales %}
                    {{ sale.sale }}
                    {% if NOT loop.last %},{% endif %}
                    {% endfor %}],
                spanGaps: false,
            }
        ]
    };
    var myChart = new Chart(ctx, {
        type: 'line',
        responsive: true,

        maintainAspectRatio: false,
        data: data,

        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %> - <%= value %>",
        options: {
            title:{
                display:true,
                text:"Sale Performance"
            },
            legend:{
                display: true
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true,
                        callback: function(value, index, values) {
                            if(parseInt(value) >= 1000){
                                return 'Rp' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                            } else {
                                return 'Rp' + value;
                            }
                        }
                    }
                }],

            },
            tooltips: {
                enable:true,
                callbacks: {
                    label: function(tooltipItem, data) {
                        return data.datasets[tooltipItem.datasetIndex].label +': '+Number(tooltipItem.yLabel).toFixed(0).replace(/./g, function(c, i, a) {
                                    return i > 0 && c !== "." && (a.length - i) % 3 === 0 ? "," + c : c;
                                });

                    }
                }
            }

        }
    });
</script>