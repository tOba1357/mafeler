<template lang="pug">
  div
    h1 Sleeps
    div.table-responsive
      table.table.table-hover
        thead
          tr
            th date
            th(style="min-width: 140px;") time
            th
        tbody
          tr(v-for="sleep in sleeps")
            td {{date(sleep)}}
            td {{time(sleep)}}
            td
              .btn-group
                router-link.btn.btn-info.btn-sm(:to="{name: 'show_fitbit_sleep', params: {id: sleep.id}}") 詳細
    pagination(:total-page="totalPage" :current-page="page" :to="{name: 'fitbit_sleeps'}" v-if="sleeps.length > 0")
</template>

<script>
  import base from '../base'
  import Pagination from '../common/Pagination.vue'

  export default {
    extends: base,
    data: function () {
      return {
        sleeps: [],
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
        let path = '/fitbit/sleeps'
        if (query) {
          path = '/fitbit/sleeps?' + Object.keys(query).map((key) => {
            return `${key}=${query[key]}`
          }).join('&')
        }
        axios.get(path)
          .then((response) => {
            const data = response.data
            this.sleeps = data.sleeps
            this.page = parseInt(data.page)
            this.totalPage = data.total_page
            window.scrollTo(0, 0)
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      date: function (sleep) {
        return new moment(sleep.date).format('YYYY-MM-DD')
      },
      time: function (sleep) {
        const sleptAt = moment(sleep.start_time).format('H:mm')
        const wokeUpAt = moment(sleep.end_time).format('H:mm')
        return `${sleptAt} ~ ${wokeUpAt}`
      },
      importSleeps: function () {
        this.setLoading(true)
        axios.get('/fitbit/sleeps/sync')
          .then(() => {
            this.setLoading(false)
            this.loadActivities()
          })
      }
    },
    components: {Pagination}
  }
</script>

<style lang="sass" scoped>

</style>
