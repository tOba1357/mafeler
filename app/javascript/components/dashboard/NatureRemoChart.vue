<template lang="pug">
  lin-chart(:data="chartData" :options="options" :width="width" :height="height")
</template>

<script>
  import LinChart from './LinChart'
  //FIXME: Commonize with Index.vue
  const BORDER_COLOR_PRIMARY = 'rgba(0,103,255,0.8)'
  const BACKGROUND_COLOR_PRIMARY = 'rgba(0,103,255,0.2)'
  const BORDER_COLOR_INFO = 'rgba(40,167,69,0.8)'
  const BACKGROUND_COLOR_INFO = 'rgba(40,167,69,0.2)'
  const BORDER_COLOR_WARNING = 'rgba(255,192,0,0.8)'
  const BACKGROUND_COLOR_WARNING = 'rgba(255,192,0,0.2)'
  const BORDER_COLOR_DANGER = 'rgba(220,53,69,0.8)'
  const BACKGROUND_COLOR_DANGER = 'rgba(220,53,69,0.2)'

  export default {
    components: {LinChart},
    props: {
      width: {
        type: Number,
        required: true,
      },
      height: {
        type: Number,
        required: true,
      },
      natureRemo: {
        type: Object,
        required: true,
      },
    },
    computed: {
      chartData() {
        const {humidities, illuminations, temperatures} = this.natureRemo
        const labels = _.uniq(_.concat(humidities, illuminations, temperatures).map((v) => v.created_at)).sort()
        let beforeValue = null
        const humidityValues = labels.map((label) => {
          const target = humidities.find((v) => v.created_at === label)
          if(target) {
            beforeValue = target.value
            return target.value
          }
          return beforeValue
        })
        beforeValue = null
        const illuminationValues = labels.map((label) => {
          const target = illuminations.find((v) => v.created_at === label)
          if(target) {
            beforeValue = target.value
            return target.value
          }
          return beforeValue
        })
        beforeValue = null
        const temperatureValues = labels.map((label) => {
          const target = temperatures.find((v) => v.created_at === label)
          if(target) {
            beforeValue = target.value
            return target.value
          }
          return beforeValue
        })


        return {
          labels: labels. map((l) => moment(l).format('MM-DD HH:mm')),
          datasets: [{
            label: '気温',
            yAxisID: '気温',
            data: temperatureValues,
            borderColor: BORDER_COLOR_DANGER,
            backgroundColor: BACKGROUND_COLOR_DANGER,
          }, {
            label: '湿度',
            yAxisID: '湿度',
            data: humidityValues,
            borderColor: BORDER_COLOR_PRIMARY,
            backgroundColor: BACKGROUND_COLOR_PRIMARY,
          }, {
            label: '照度',
            yAxisID: '照度',
            data: illuminationValues,
            borderColor: BORDER_COLOR_INFO,
            backgroundColor: BACKGROUND_COLOR_INFO,
          }]
        }
      },
      options() {
        return {
          scales: {
            yAxes: [{
              scaleLabel: {
                display: true,
                labelString: '気温',
              },
              fontColor: '#000',
              id: '気温',
              type: 'linear',
              position: 'left',
            }, {
              scaleLabel: {
                display: true,
                labelString: '湿度',
              },
              labelString: '湿度',
              id: '湿度',
              type: 'linear',
              position: 'left',
            }, {
              scaleLabel: {
                display: true,
                labelString: '照度',
              },
              labelString: '照度',
              id: '照度',
              type: 'linear',
              position: 'left',
            }]
          }
        }
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
