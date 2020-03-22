<template lang="pug">
  .contaienr
    h1
      | Chinese Medicine Diagnosis
      router-link.btn.btn-primary(:to="{name: 'new_chinese_medicine_diagnosis'}") 診断する
    .table-responsive
      table.table.table-hover
        thead
          tr
            th date
            th constitutions
        tbody
          tr(v-for="diagnosis in diagnoses")
            td {{date(diagnosis)}}
            td {{constitutions(diagnosis)}}
</template>

<script>
  import Base from '../base'
  export default {
    extends: Base,
    data() {
      return {
        diagnoses: []
      }
    },
    methods: {
      init () {
        axios.get('/chinese_medicine_diagnoses')
          .then(res => {
            this.diagnoses = res.data
            this.setLoading(false)
          })
      },
      constitutions(diagnosis) {
        return diagnosis.chinese_medicine_constitutions
          .map((constitution) => constitution.label)
          .join(', ')
      },
      date(diagnosis) {
        return new moment(diagnosis.created_at).format('YYYY-MM-DD')
      },
    }
  }
</script>
