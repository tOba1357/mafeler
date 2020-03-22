<template lang="pug">
  .chartWrapper(v-if="chartData")
    LinChart(
      :data="chartData"
      :options="options"
      :width="width"
      :height="height"
    )
</template>

<script>
  import LinChart from './LinChart'
  import * as palette from 'google-palette';

  export default {
    components: {LinChart},
    props: {
      from: {
        type: String,
        required: true,
      },
      to: {
        type: String,
        required: true,
      },
      width: {
        type: Number,
        required: true,
      },
      height: {
        type: Number,
        required: true,
      },
      data: {
        type: Object,
        required: true,
      }
    },
    computed: {
      labels() {
        const innerscans = this.data.innerscans;
        if (!innerscans) return null;
        return innerscans.map((innerscan) => moment(innerscan.datetime).format('MM-DD'))
      },
      options () {
        return {
          scales: {
            yAxes: [{
              scaleLabel: {
                display: true,
                labelString: '体重',
              },
              id: '体重',
              type: 'linear',
              position: 'left',
            }, {
              scaleLabel: {
                display: true,
                labelString: '筋肉量',
              },
              id: '筋肉量',
              type: 'linear',
              position: 'right',
            }]
          }
        }
      },
      chartData() {
        const innerscans = this.data.innerscans;
        if (!innerscans) return null;

        const colors = palette('mpn65', 2);
        const weight_data = innerscans.map((innerscan) => innerscan.weight)
        const weight_color = `#${colors[0]}`;

        const muscle_mass_data = innerscans.map((innerscan) => innerscan.muscle_mass)
        const muscle_mass_color = `#${colors[1]}`;
        return {
          labels: this.labels,
          datasets: [
            {
              yAxisID: '体重',
              label: '体重',
              data: weight_data,
              borderColor: weight_color,
              backgroundColor: weight_color + '11',
            },
            {
              yAxisID: '筋肉量',
              label: '筋肉量',
              data: muscle_mass_data,
              borderColor: muscle_mass_color,
              backgroundColor: muscle_mass_color + '11',
            }
          ]
        }
      }
    }
  }
</script>
