<template lang="pug">
  div
    h1 Settings
    div
      h2 Profile
      router-link.btn.btn-primary(:to="{name: 'show_user'}") 見る
    div
      h2 fitbti
      a.btn.btn-primary.disabled(v-if='fitbitSubscribed') 連携済み
      span.btn.btn-primary(v-else-if='fitbitConnected' @click="subscribeFitbit") 連携
      a.btn.btn-primary(v-else href="/fitbit/authenticate") 連携
    div
      h2 User Defined Items
      router-link.btn.btn-primary(:to="{name: 'udis'}") 一覧を見る
    div
      h2 Nature Remo
      .form-group
        label Access Token
        input.form-control(type="string" v-model="accessToken")
      button.btn.btn-primary(@click="saveNatureRemo") 連携
    div
      h2 Health Planet
      a.btn.btn-primary.disabled(v-if='healthPlanetConnected') 連携済み
      a.btn.btn-primary(v-else href="/health_planet/authenticate") 連携
</template>

<script>
  import {mapState, mapActions} from 'vuex'
  import base from '../base'

  export default {
    extends: base,
    data() {
      return {
        accessToken: ''
      }
    },
    computed: {
      ...mapState('authentication', ['fitbitConnected', 'healthPlanetConnected', 'fitbitSubscribed'])
    },
    methods: {
      ...mapActions('authentication', ['loadFitbitConnected']),
      saveNatureRemo() {
        axios.post('/nature_remo', {access_token: this.accessToken})
          .then((_) => alert('連携しました'))
      },
      subscribeFitbit() {
        this.setLoading(true)
        axios.post('/fitbit/subscription')
          .then((_) => this.loadFitbitConnected())
      }
    }
  }
</script>

<style lang="sass" scoped>

</style>
