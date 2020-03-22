<template lang="pug">
  div
    h1 Fitbit Activities
    div.table-responsive
      table.table.table-hover
        thead
          tr
            th time
            th Activity Name
            th Duration
            th
        tbody
          tr(v-for="activity in activities")
            td {{time(activity)}}
            td {{activity.activity_name}}
            td {{(activity.duration / 60 / 1000).toFixed()}}分
            td
              .btn-group
                router-link.btn.btn-info.btn-sm(:to="{name: 'show_fitbit_activity', params: {id: activity.id}}") 詳細
    pagination(:total-page="totalPage" :current-page="page" :to="{name: 'fitbit_activities'}" v-if="activities.length > 0")
</template>

<script>
  import base from '../base'
  import Pagination from '../common/Pagination.vue'

  export default {
    extends: base,
    data: function () {
      return {
        activities: [],
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
        let path = '/fitbit/activities'
        if (query) {
          path = '/fitbit/activities?' + Object.keys(query).map((key) => {
            return `${key}=${query[key]}`
          }).join('&')
        }
        axios.get(path)
          .then((response) => {
            const data = response.data
            this.activities = data.activities
            this.page = parseInt(data.page)
            this.totalPage = data.total_page
            window.scrollTo(0, 0)
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      time(activity) {
        return moment(activity.start_time).format('YYYY-MM-DD HH:mm')
      },
      importActivities: function () {
        this.setLoading(true)
        axios.get('/fitbit/activities/sync')
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
