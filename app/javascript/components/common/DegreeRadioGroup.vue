<template>
  <radio-group :options="options" :name="name" :value="value" @input="val => {$emit('input', val)}"></radio-group>
</template>

<script>
  import RadioGroup from './RadioGroup.vue'
  export default {
    props: ['name', 'value'],
    data: function () {
     return {
       options: [
         {label: '<i class="fas fa-circle" style="font-size: 40px;"></i>', value: 'good', color: 'success', width: '60px', height: '60px'},
         {label: '<i class="fas fa-minus" style="font-size: 40px;"></i>', value: 'so_so', color: 'warning', width: '60px', height: '60px'},
         {label: '<i class="fas fa-times" style="font-size: 40px;"></i>', value: 'bad', color: 'danger', width: '60px', height: '60px'},
       ]
     }
    },
    components: {
      RadioGroup
    }
  }
</script>

<style scoped>

</style>
