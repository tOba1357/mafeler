<template lang="pug">
  .container
    h1 Chinese Medicine Diagnosis
    .form-check(v-for="selection in selections" :key="selection.id")
      input.form-check-input(type="checkbox" :value="selection.id" v-model="selectedSelectionIds" :id="'selection_' + selection.id")
      label.form-check-label(:for="'selection_' + selection.id") {{selection.label}}
    .btn.btn-primary(@click="diagnosis()") Diagnosis
</template>

<script>
  import Base from '../base'

  export default {
    extends: Base,
    data() {
      return {
        selections: [],
        selectedSelectionIds: [],
      }
    },
    methods: {
      init() {
        axios.get('/chinese_medicine_selections')
          .then(res => {
            this.selections = res.data
            this.setLoading(false)
          })
      },
      diagnosis() {
        this.setLoading(true)
        axios.post('/chinese_medicine_diagnoses', {diagnosis: {selection_ids: this.selectedSelectionIds}})
          .then((_) => {
            this.setLoading(false)
            this.$router.push({name: 'chinese_medicine_diagnosis'})
          })
      }
    }
  }
</script>
