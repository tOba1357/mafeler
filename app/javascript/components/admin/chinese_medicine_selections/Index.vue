<template lang="pug">
  div
    h1
      | Chinese Medicine Selections
      router-link.btn.btn-primary(:to="{name: 'new_chinese_medicine_selections'}") 作成
    div.table-responsive
      table.table.table-hover
        thead
          tr
            th label
            th target_constitution
            th
        tbody
          tr(v-for="selection in chinese_medicine_selections")
            td {{selection.label}}
            td {{findConstitutions(selection.chinese_medicine_constitution_id).label}}
            td
              .btn-group
                router-link.btn.btn-info.btn-sm(:to="{name: 'edit_chinese_medicine_selections', params: {id: selection.id}}") 編集
</template>

<script>
  import base from '../../base'
  import {mapGetters} from 'vuex'
  export default {
    extends: base,
    data() {
      return {
        chinese_medicine_selections: []
      }
    },
    computed: {
      ...mapGetters('chinese_medicine_constitutions', ['findConstitutions']),
    },
    methods: {
      init() {
        this.loadSelections()
      },
      loadSelections() {
        this.setLoading(true)
        axios.get('/admin/chinese_medicine_selections')
          .then((res) => {
            this.chinese_medicine_selections = res.data
            this.setLoading(false)
          })
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
