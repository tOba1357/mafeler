<template>
  <div class="degreeIconWrapper" :style="wrapperStyle">
    <i :class="className" :style="style"></i>
  </div>
</template>

<script>
  export default {
    props: {
      type: {
        type: String,
        required: true
      },
      size: {
        type: Number,
        required: true
      },
    },
    computed: {
      className: function () {
        switch (this.type) {
          case 'good':
            return ['fas', 'fa-circle']
          case 'so_so':
            return ['fas', 'fa-minus']
          case 'bad':
            return ['fas', 'fa-times']
        }
        return []
      },
      style: function () {
        return {
          'font-size': this.size * 0.9 + 'px',
        }
      },
      wrapperStyle: function () {
        return {
          width: this.size + 'px',
          height: this.size + 'px',
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import '../common';
  .degreeIconWrapper {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .fa-circle {
    color: $success;
  }

  .fa-minus {
    color: $warning;
  }

  .fa-times {
    color: $danger;
  }
</style>
