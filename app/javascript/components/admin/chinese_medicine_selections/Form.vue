<template lang="pug">
  div
    h1 Chinese Medicine Selections
    form
      .form-group
        label label
        input.form-control(type="text" v-model="data.label")
      .form-group
        label constitution
        select.form-control(v-model="data.chinese_medicine_constitution_id")
          option(v-for="constitution in constitutions" :value="constitution.id") {{constitution.label}}
      button.btn.btn-primary(@click.stop.prevent="save") 保存
</template>

<script>
  // TODO: apply update
  import {mapState} from 'vuex'
  import base from '../../base'

  export default {
    extends: base,
    data() {
      return {
        data: {
          label: '',
          chinese_medicine_constitution_id: null
        }
      }
    },
    computed: {
      ...mapState('chinese_medicine_constitutions', ['constitutions']),
    },
    methods: {
      save() {
        this.setLoading(true)
        axios.post('/admin/chinese_medicine_selections', {chinese_medicine_selection: this.data})
          .then((_) => {
            this.setLoading(false)
            this.$router.push({name: 'chinese_medicine_selections'})
          })
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>
