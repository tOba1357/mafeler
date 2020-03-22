<template lang="pug">
  div
    h1 Fitbit Heart Rate
    div.table-responsive
      table.table.table-hover
        thead
          tr
            th date
            th(style="min-width: 140px;") 安静時
            th
        tbody
          tr(v-for="heartRate in heartRates")
            td {{date(heartRate)}}
            td {{heartRate.resting_heart_rate}}bpm
            td
              .btn-group
                router-link.btn.btn-info.btn-sm(:to="{name: 'show_fitbit_heart_rate', params: {id: heartRate.id}}") 詳細
    pagination(:total-page="totalPage" :current-page="page" :to="{name: 'fitbit_heart_rates'}" v-if="heartRates.length > 0")
</template>

<script>
  import base from '../base'
  import Pagination from '../common/Pagination.vue'

  export default {
    extends: base,
    data: function () {
      return {
        heartRates: [],
        page: 1,
        totalPage: null
      }
    },
    methods: {
      init: function () {
        this.loadActivities()
      },
      loadActivities: function () {
        this.setLoading(true)
        const query = this.$route.query
        let path = '/fitbit/heart_rates'
        if (query) {
          path = '/fitbit/heart_rates?' + Object.keys(query).map((key) => {
            return `${key}=${query[key]}`
          }).join('&')
        }
        axios.get(path)
          .then((response) => {
            const data = response.data
            this.heartRates = data.heart_rates
            this.page = parseInt(data.page)
            this.totalPage = data.total_page
            window.scrollTo(0, 0)
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      date: function (heartRate) {
        return new moment(heartRate.date).format('YYYY-MM-DD')
      },
      importHeartRates: function () {
        this.setLoading(true)
        axios.get('/fitbit/heart_rates/sync')
          .then(() => {
            this.setLoading(false)
            this.loadActivities()
          })
      }
    },
    components: {Pagination}
  }
</script>
