<template lang="pug">
  div
    .form-row
      .col
        datepicker(:bootstrap-styling="true" v-model="from" format="yyyy-MM-dd")
      .col
        datepicker(:bootstrap-styling="true" v-model="to" format="yyyy-MM-dd")
    div.charts
      .chartWrapper(v-if="sleepTimesChartData")
        div.graphHeader
          span.column avg:{{averageSleepTimes.toFixed(2)}}h
          span.column std:{{stdSleepTimes.toFixed(2)}}
        lin-chart(:data="sleepTimesChartData" :options="options(0, null)" :width="300" :height="300")
      .chartWrapper(v-if="efficienciesChartData")
        div.graphHeader
          span.column avg:{{averageEfficiencies.toFixed(2)}}
          span.column std:{{stdEfficiencies.toFixed(2)}}
        lin-chart(:data="efficienciesChartData" :options="options(0, 1)" :width="300" :height="300")
      .chartWrapper(v-if="diaryChartData")
        lin-chart(:data="diaryChartData" :options="diaryOptions" :width="300" :height="300")
      .chartWrapper(v-if="activityChartData")
        div.graphHeader
          span.column avg:{{averageActivities.toFixed(2)}}
          span.column std:{{stdActivities.toFixed(2)}}
        lin-chart(:data="activityChartData" :options="options(0, null)" :width="300" :height="300")
      .chartWrapper(v-if="heartRateChartData")
        bar-chart(:data="heartRateChartData" :options="heartRateOptions" :width="300" :height="300")
      HelathPlanetChart(
        :from="from"
        :to="to"
        :width="300"
        :height="300"
        :data="healthPlanet"
      )
      .chartWrapper(v-if="natureRemo")
        NatureRemoChart(:height="300" :width="300" :natureRemo="natureRemo")
      .chartWrapper(v-for="chartData in udisCartData")
        lin-chart(:data="chartData" :options="options()" :width="300" :height="300")
</template>

<script>
  import Base from '../base'
  import LinChart from './LinChart'
  import BarChart from './BarChart'
  import NatureRemoChart from './NatureRemoChart'
  import HelathPlanetChart from './HelathPlanetChart'
  import Datepicker from 'vuejs-datepicker'
  import * as ss from 'simple-statistics'
  import {mapState} from 'vuex'

  const BORDER_COLOR_PRIMARY = 'rgba(0,103,255,0.8)'
  const BACKGROUND_COLOR_PRIMARY = 'rgba(0,103,255,0.2)'
  const BORDER_COLOR_INFO = 'rgba(40,167,69,0.8)'
  const BACKGROUND_COLOR_INFO = 'rgba(40,167,69,0.2)'
  const BORDER_COLOR_WARNING = 'rgba(255,192,0,0.8)'
  const BACKGROUND_COLOR_WARNING = 'rgba(255,192,0,0.2)'
  const BORDER_COLOR_DANGER = 'rgba(220,53,69,0.8)'
  const BACKGROUND_COLOR_DANGER = 'rgba(220,53,69,0.2)'

  export default {
    mixins: [Base],
    components: {LinChart, Datepicker, BarChart, NatureRemoChart, HelathPlanetChart},
    data() {
      return {
        from: moment().add(-2, 'week').format('YYYY-MM-DD'),
        to: moment().format('YYYY-MM-DD'),
        sleeps: [],
        activities: [],
        diaries: [],
        heartRates: [],
        sleepTimesChartData: null,
        efficienciesChartData: null,
        diaryChartData: null,
        activityChartData: null,
        heartRateChartData: null,
        udisCartData: [],
        natureRemo: null,
        healthPlanet: {},
      }
    },
    watch: {
      from() {
        this.loadDashboard()
      },
      to() {
        this.loadDashboard()
      }
    },
    computed: {
      ...mapState('udis', ['udis']),
      dateRange() {
        const dateRange = []
        const from = moment(this.from)
        const to = moment(this.to).add(1, 'day')
        for (let target = from.clone(); target.isBefore(to); target.add(1, 'day')) {
          dateRange.push(target.format('YYYY-MM-DD'))
        }
        return dateRange
      },
      labels() {
        return this.dateRange.map((date) => moment(date).format('MM-DD'))
      },
      diaryOptions() {
        return {
          responsive: true,
          scales: {
            yAxes: [{
              ticks: {
                min: 0,
                max: 2.5,
                stepSize: 1,
              }
            }]
          }
        }
      },
      heartRateOptions() {
        return {
          responsive: true,
          scales: {
            xAxes: [{
              stacked: true,
            }],
            yAxes: [{
              stacked: true,
              ticks: {
                beginAtZero: true,
                min: 0,
                max: 24
              }
            }]
          }
        }
      },
      averageSleepTimes() {
        if (this.sleeps.length === 0) {
          return 0
        }
        return ss.mean(this.sleeps.map(sleep => sleep.sec)) / 3600
      },
      stdSleepTimes() {
        if (this.sleeps.length === 0) {
          return 0
        }
        return ss.standardDeviation(this.sleeps.map(sleep => sleep.sec)) / 3600
      },
      averageEfficiencies() {
        if (this.sleeps.length === 0) {
          return 0
        }
        return ss.mean(this.sleeps.map(sleep => sleep.efficiency)) / 100
      },
      stdEfficiencies() {
        if (this.sleeps.length === 0) {
          return 0
        }
        return ss.standardDeviation(this.sleeps.map(sleep => sleep.efficiency)) / 100
      },
      averageActivities() {
        if (this.activities.length === 0) {
          return 0
        }
        return ss.mean(this.activities.map(activity => activity.duration / 1000 / 60))
      },
      stdActivities() {
        if (this.activities.length === 0) {
          return 0
        }
        return ss.standardDeviation(this.activities.map(activity => activity.duration / 1000 / 60))
      },
    },
    methods: {
      init() {
        this.loadDashboard()
      },
      loadDashboard() {
        this.setLoading(true)
        axios.get('/dashboard', {
          params: {
            from: this.from,
            to: this.to
          }
        })
          .then((response) => {
            const {sleeps, diaries, activities, heart_rates, nature_remo, health_planet} = response.data
            this.sleeps = sleeps
            this.activities = activities
            this.diaries = diaries
            this.heartRates = heart_rates
            this.healthPlanet = health_planet

            this.sleepTimesChartData = this.createSleepTimesChartData(sleeps)
            this.efficienciesChartData = this.createEfficienciesChartData(sleeps)
            this.diaryChartData = this.createDiaryChartData(diaries)
            this.activityChartData = this.createActivityChartData(activities)
            this.heartRateChartData = this.createHeartRateChartData(heart_rates)
            this.udisCartData = this.createUdisChartData(diaries)
            this.natureRemo = nature_remo
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      options(minValue, maxValue) {
        const options = {
          responsive: true,
          scales: {
            yAxes: [{
              ticks: {}
            }]
          }
        }
        if (minValue !== null) {
          options.scales.yAxes[0].ticks.suggestedMin = minValue
          options.scales.yAxes[0].ticks.min = minValue
        }
        if (maxValue !== null) {
          options.scales.yAxes[0].ticks.suggestedMax = maxValue
          options.scales.yAxes[0].ticks.max = maxValue
        }
        return options
      },
      createSleepTimesChartData(sleeps) {
        const sleepTimes = this.dateRange.map((date) => {
          const target = sleeps.find((sleep) => date === sleep.date)
          return target ? target.sec / 3600.0 : null
        })
        return {
          labels: this.labels,
          datasets: [
            {
              label: '睡眠時間',
              data: sleepTimes,
              borderColor: BORDER_COLOR_INFO,
              backgroundColor: BACKGROUND_COLOR_INFO,
            }
          ]
        }
      },
      createEfficienciesChartData(sleeps) {
        const efficiencies = this.dateRange.map((date) => {
          const target = sleeps.find((sleep) => date === sleep.date)
          return target ? target.efficiency / 100.0 : null
        })
        return {
          labels: this.labels,
          datasets: [
            {
              label: '睡眠効率',
              data: efficiencies,
              borderColor: BORDER_COLOR_PRIMARY,
              backgroundColor: BACKGROUND_COLOR_PRIMARY,
            }
          ]
        }
      },
      createDiaryChartData(diaries) {
        const conditions = this.dateRange.map((date) => {
          const target = diaries.find(diary => date === diary.date)
          return target ? this.degreeToInt(target.condition) : null
        })
        const motivations = this.dateRange.map(date => {
          const target = diaries.find(diary => date === diary.date)
          return target ? this.degreeToInt(target.motivation) : null
        })
        const appetites = this.dateRange.map(date => {
          const target = diaries.find(diary => date === diary.date)
          return target ? this.degreeToInt(target.appetite) : null
        })
        return {
          labels: this.labels,
          datasets: [
            {
              label: '体調',
              data: conditions,
              fill: false,
              borderColor: BORDER_COLOR_INFO,
              backgroundColor: BACKGROUND_COLOR_INFO,
            },
            {
              label: 'やる気',
              data: motivations,
              fill: false,
              borderColor: BORDER_COLOR_PRIMARY,
              backgroundColor: BACKGROUND_COLOR_PRIMARY,
            },
            {
              label: '食欲',
              data: appetites,
              fill: false,
              borderColor: BORDER_COLOR_WARNING,
              backgroundColor: BACKGROUND_COLOR_WARNING,
            }
          ]
        }
      },
      degreeToInt(degree) {
        switch (degree) {
          case 'good':
            return 2
          case 'so_so':
            return 1
          case 'bad':
            return 0
          default:
            return null
        }
      },
      createActivityChartData(activities) {
        const durations = this.dateRange.map((date) => {
          const target = activities.find((activity) => date === activity.date)
          return target ? target.duration / 1000 / 60 : 0
        })
        return {
          labels: this.labels,
          datasets: [
            {
              label: 'アクティブ時間',
              data: durations,
              borderColor: BORDER_COLOR_INFO,
              backgroundColor: BACKGROUND_COLOR_INFO,
            }
          ]
        }
      },
      createHeartRateChartData(heartRates) {
        const outOfRanges = this.dateRange.map((date) => {
          const target = heartRates.find((heartRate) => date === heartRate.date)
          return target ? target.out_of_range_minutes / 60 : null
        })
        const fatBurns = this.dateRange.map((date) => {
          const target = heartRates.find((heartRate) => date === heartRate.date)
          return target ? target.fat_burn_minutes / 60 : null
        })
        const cardios = this.dateRange.map((date) => {
          const target = heartRates.find((heartRate) => date === heartRate.date)
          return target ? target.cardio_minutes / 60 : null
        })
        const peaks = this.dateRange.map((date) => {
          const target = heartRates.find((heartRate) => date === heartRate.date)
          return target ? target.peak_minutes / 60 : null
        })
        return {
          labels: this.labels,
          datasets: [
            {
              label: 'out of range',
              data: outOfRanges,
              borderColor: BORDER_COLOR_INFO,
              backgroundColor: BORDER_COLOR_INFO,
            },
            {
              label: 'fat burns',
              data: fatBurns,
              borderColor: BORDER_COLOR_PRIMARY,
              backgroundColor: BORDER_COLOR_PRIMARY,
            },
            {
              label: 'cardio',
              data: cardios,
              borderColor: BORDER_COLOR_WARNING,
              backgroundColor: BORDER_COLOR_WARNING,
            },
            {
              label: 'peak',
              data: peaks,
              borderColor: BORDER_COLOR_DANGER,
              backgroundColor: BORDER_COLOR_DANGER,
            }
          ]
        }
      },
      createUdisChartData(diaries) {
        return this.udis.map((udi) => {
          const data = this.dateRange.map((date) => {
            const targetDiary = diaries.find((diary) => date === diary.date)
            if (!targetDiary) {
              return 0
            }
            const targetUdi = targetDiary.user_defined_item_values.find((udiv) => udiv.user_defined_item_id === udi.id)
            return targetUdi && targetUdi.value ? parseInt(targetUdi.value) : 0
          })
          return {
            labels: this.labels,
            datasets: [
              {
                label: udi.name,
                data: data,
                borderColor: BORDER_COLOR_PRIMARY,
                backgroundColor: BACKGROUND_COLOR_PRIMARY,
              }
            ]
          }
        })
      },
    },
  }

</script>

<style lang="scss" scoped>
  .charts {
    text-align: center;
  }

  .graphHeader {
    text-align: center;
    .column:not(:first-child) {
      margin-left: 10px;
    }
  }

  .chartWrapper {
    display: inline-block;
    vertical-align: bottom;
    margin: 10px;
  }
</style>
