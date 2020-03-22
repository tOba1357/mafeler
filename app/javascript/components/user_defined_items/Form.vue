<template lang="pug">
  div
    h1 User Defined Item
    form
      .form-group
        label name
        input.form-control(type="text" v-model="data.name")
      .form-group
        label value type
        select.form-control(v-model="data.value_type")
          option(v-for="type in valueTypes" :value="type") {{type}}
      button.btn.btn-primary(@click.stop.prevent="save") 保存
</template>

<script>
  import {mapActions} from 'vuex'
  import base from '../base'
  const VALUE_TYPES = ['integer']
  export default {
    extends: base,
    data() {
      let data = {
        name: '',
        value_type: VALUE_TYPES[0],
      }
      const id = _.parseInt(this.$route.params.id)
      const udi = this.$store.getters['udis/udi'](id)
      if (udi) {
        data = _.cloneDeep(udi)
      }
      return {data}
    },
    computed: {
      id() {
        return this.$route.params.id
      },
      valueTypes() {
        return VALUE_TYPES
      }
    },
    methods: {
      ...mapActions('udis', ['saveUDI', 'updateUDI']),
      save() {
        this.setLoading(true)
        let promise = null
        if (this.id) {
          promise = this.updateUDI(this.data)
        } else {
          promise = this.saveUDI(this.data)
        }
        promise
          .then(() => {
            this.setLoading(false)
            this.$router.push({name: 'udis'})
          })
      },
    }
  }
</script>

<style lang="scss" scoped>

</style>
