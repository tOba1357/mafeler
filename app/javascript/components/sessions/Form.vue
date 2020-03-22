<template>
  <div>
    <h1>Log in</h1>
    <a class="btn btn-primary" href="/oauth2/google/auth">log in</a>
  </div>
</template>

<script>
  import base from '../base'
  import {mapMutations, mapGetters, mapActions} from 'vuex'

  export default {
    extends: base,
    data: function () {
      return {
        email: '',
        password: ''
      }
    },
    computed: {
      ...mapGetters('authentication', [
        'loggedIn'
      ]),
      params: function () {
        return {
          email: this.email,
          password: this.password,
        }
      }
    },
    methods: {
      ...mapMutations('authentication', [
        'setLoggedIn',
      ]),
      ...mapActions('authentication', [
        'doLogIn'
      ]),
      init: function () {
        if (this.loggedIn) {
          const redirect = this.$route.query.redirect
          if (redirect) {
            this.$router.push(redirect)
          } else {
            this.$router.push({name: 'dashboard'})
          }
        }
        this.setLoading(false)
      },
    }
  }
</script>
