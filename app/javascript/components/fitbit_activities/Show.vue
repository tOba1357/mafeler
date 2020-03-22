<template lang="pug">
  div
    h1 Fitbit Activities
    .table-responsive
      table.table.table-bordered.table-hover
        tbody
          tr(v-for="(value, key) in data")
            th {{key}}
            td {{value}}
</template>

<script>
  import base from '../base'

  export default {
    extends: base,
    data: function() {
      return {data: {}}
    },
    methods: {
      init: function () {
        this.setLoading(true)
        axios.get(`/fitbit/activities/${this.$route.params.id}`)
          .then((response) => {
            this.data = response.data
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
    }
  }
</script>

<style lang="sass" scoped>

</style>
