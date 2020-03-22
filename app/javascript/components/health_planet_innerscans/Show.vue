<template lang="pug">
  div
    h1 Innserscan
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
        axios.get(`/health_planet/innerscans/${this.$route.params.id}`)
          .then((response) => {
            const data = response.data
            this.data = data
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
    }
  }
</script>

<style lang="sass" scoped>

</style>
