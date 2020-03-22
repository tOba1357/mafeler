import {mapMutations} from 'vuex'
export default {
  created () {
    this._beforeRoute()
  },
  watch: {
    '$route': '_beforeRoute'
  },
  computed: {
    loading: function () {
      return this.$router.app.loading
    },
  },
  methods: {
    ...mapMutations(['setLoading']),
    _beforeRoute: function () {
      this.$store.commit('setError', null)
      $(".navbar-collapse").collapse('hide')
      if (this.init) {
        this.setLoading(true)
        this.init()
      }
    },
  }
}
