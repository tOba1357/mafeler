<template lang="pug">
  div
    h1 Profile
    .table-responsive
      table.table.table-bordered.table-hover
        tbody
          tr(v-for="(value, key) in data")
            th {{key}}
            td {{value}}
    .btn-group
      router-link.btn.btn-warning.btn-sm(:to="{name: 'edit_user'}") 編集
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
        axios.get('/users')
          .then((response) => {
            this.data = response.data
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
    }
  }
</script>

<style lang="scss" scoped>

</style>