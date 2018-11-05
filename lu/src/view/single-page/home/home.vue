<template>
<div>

  <Row :gutter="20" style="margin-top: 20px;">
    <i-col span="24">
      <Card shadow>
        <chart-bar :value="barData" text="过去七天消费数据" />
      </Card>
    </i-col>
  </Row>
</div>
</template>

<script>
import {
  ChartBar
} from '_c/charts'
export default {
  name: 'home',
  components: {
    ChartBar
  },
  data() {
    return {
      barData: {
        Mon: 13253,
        Tue: 34235,
        Wed: 26321,
        Thu: 12340,
        Fri: 24643,
        Sat: 1322,
        Sun: 1324
      }
    }
  },
  mounted() {
    //
  }
}
</script>

<style lang="less">
.count-style {
    font-size: 50px;
}
</style>
