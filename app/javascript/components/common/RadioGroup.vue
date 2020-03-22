<template>
  <div class="radioGroup">
    <radio v-for="(option, key) in options"
           :key="key"
           :name="name"
           :value="option.value"
           :checked="option.value === value"
           :color="option.color"
           :width="option.width"
           :height="option.height"
           @input="onChange">
      <span v-html="option.label"></span>
    </radio>
  </div>
</template>

<script>
  import radio from './radio.vue'

  export default {
    props: ["options", "value", "name"],
    components: {
      radio
    },
    methods: {
      onChange: function (e) {
        if (e.target.checked) {
          this.$emit('input', e.target.value)
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  .radioGroup {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
  }
</style>
