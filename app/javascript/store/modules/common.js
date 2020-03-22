const state = {
  loading: false,
  error: null,
  alertWarnings: [],
}

const mutations = {
  setLoading(state, payload) {
    state.loading = payload
  },
  setError(state, payload) {
    state.error = payload
  },
  setAlertWarnings(state, payload) {
    state.alertWarnings = payload
  }
}

export default {
  state,
  mutations,
}
