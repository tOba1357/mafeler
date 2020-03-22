<template lang="pug">
  div
    h1 Edit Profile
    .form-group
      label Gender
      select.custom-select(v-model="gender")
        option(value="male") male
        option(value="female") female
    .form-group
      label Birthday
      input.form-control(v-model="birthday" type="date")
    .form-group
      label Height
      input.form-control(v-model="height" type="number")
    .form-group
      label Weight
      input.form-control(v-model="weight" type="number")
    button.btn.btn-primary(@click="save") 保存
</template>

<script>
  import base from '../base'
  import {mapActions} from 'vuex'

  export default {
    extends: base,
    data: function() {
      return {
        gender: null,
        birthday: null,
        height: null,
        weight: null,
      }
    },
    methods: {
      ...mapActions('authentication', ['loadProfileSaved']),
      init: function () {
        this.setLoading(true)
        axios.get('/users')
          .then((response) => {
            const {gender, birthday, height, weight} = response.data
            this.gender = gender
            this.birthday = birthday
            this.height = height
            this.weight = weight
            this.setLoading(false)
          })
          .catch((error) => console.error(error))
      },
      save: function () {
        this.setLoading(true)
        const {gender, birthday, height, weight} = this
        const params = {gender, birthday, height, weight}
        axios.put('/users', {users: params})
          .then((_) => this.loadProfileSaved())
          .then((_) => {
            this.setLoading(false)
            this.$router.push({name: 'show_user'})
          })
      }
    }
  }
</script>

<style lang="scss" scoped>

</style>