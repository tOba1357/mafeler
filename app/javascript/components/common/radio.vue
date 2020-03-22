<template>
  <label :class="className" :style="style">
    <input type="radio" :name="name" :value="value" :checked="checked" @change="$emit('input', $event)">
    <slot></slot>
  </label>
</template>

<script>
  export default {
    props: ['name', 'value', 'checked', 'color', 'width', 'height'],
    computed: {
      className: function () {
        const classNames = ['radioButton', `radioButton_${this.color}`]
        if (this.checked) {
          classNames.push(`radioButton_${this.color}--checked`)
        }
        return classNames
      },
      style: function () {
        const styles = {}
        if (this.width) {
          styles['width'] = this.width
        }
        if (this.height) {
          styles['height'] = this.height
        }
        return styles
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import '../common';

  .radioButton {
    padding: 5px 10px;
    font-size: 16px;
    border-radius: 3px;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    input {
      display: none;
    }
  }

  .radioButton_primary {
    color: $primary;
    background-color: $white;
  }

  .radioButton_primary--checked {
    color: $white;
    background-color: $primary;
  }

  .radioButton_success {
    color: $success;
    background-color: $white;
  }

  .radioButton_success--checked {
    background-color: $success;
    color: $white;
  }

  .radioButton_warning {
    color: $warning;
    background-color: $white;
  }

  .radioButton_warning--checked {
    background-color: $warning;
    color: $white;
  }

  .radioButton_danger {
    color: $danger;
    background-color: $white;
  }

  .radioButton_danger--checked {
    background-color: $danger;
    color: $white;
  }
</style>
