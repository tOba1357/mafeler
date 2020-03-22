<template lang="pug">
  div
    h1 Innerscans
    div.table-responsive
      table.table.table-hover
        thead
          tr
            th datetime
            th weight
            th
        tbody
          tr(v-for="innerscan in innerscans")
            td {{date(innerscan)}}
            td {{innerscan.weight}}kg
            td
              .btn-group
                router-link.btn.btn-info.btn-sm(:to="{name: 'show_health_planet_innerscan', params: {id: innerscan.id}}") 詳細
    pagination(:total-page="totalPage" :current-page="page" :to="{name: 'health_planet_innerscans'}" v-if="innerscans.length > 0")

</template>

<script>
  import base from '../base'
  import Pagination from '../common/Pagination.vue'

  export default {
    extends: base,
    data: function () {
      return {
        innerscans: [],
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
        let path = '/health_planet/innerscans'
        if (query) {
          path = '/health_planet/innerscans?' + Object.keys(query).map((key) => {
            return `${key}=${query[key]}`
          }).join('&')
        }
        axios.get(path)
          .then((response) => {
            const data = response.data
            this.innerscans = data.innerscans
            this.page = parseInt(data.page)
            this.totalPage = data.total_page
            window.scrollTo(0, 0)
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      date: function (innerscan) {
        return new moment(innerscan.datetime).format('YYYY-MM-DD')
      },
      importSleeps: function () {
        this.setLoading(true)
        axios.get('/health_planet/innerscans/sync')
          .then(() => {
            this.setLoading(false)
            this.loadActivities()
          })
      }
    },
    components: {Pagination}
  }
</script>

<style lang="scss" scoped>

</style>
