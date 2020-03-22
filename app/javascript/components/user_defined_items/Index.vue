<template lang="pug">
  div
    h1
      | User Defined Items
      router-link.btn.btn-primary(:to="{name: 'new_udi'}") 作成
    div.table-responsive
      table.table.table-hover
        thead
          tr
            th name
            th value type
            th
        tbody
          tr(v-for="udi in udis")
            td {{udi.name}}
            td {{udi.value_type}}
            td
              .btn-group
                router-link.btn.btn-info.btn-sm(:to="{name: 'edit_udi', params: {id: udi.id}}") 編集
                button.btn.btn-danger.btn-sm(@click.stop.prevent="destroy(udi)") 削除
</template>

<script>
  import base from '../base'
  import {mapState, mapActions} from 'vuex'
  export default {
    extends: base,
    computed: {
      ...mapState('udis', ['udis'])
    },
    methods: {
      ...mapActions('udis', ['deleteUDI']),
      destroy(udi) {
        if(window.confirm('削除してもよろしいですか？')) {
          this.setLoading(true)
          this.deleteUDI(udi).then(() => this.setLoading(false))
        }
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
