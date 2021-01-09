<template>
  <div id="app">
    <p>{{ testField }}</p>
    <ul>
      <li v-for="task in tasks">
        {{ task }}
      </li>
    </ul>
  </div>
</template>

<script>
import gql from "graphql-tag"

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  apollo: {
    testField: gql`query {
      testField
    }`,
    tasks: gql`query {
      tasks {
        id
        title
        createdAt
        updatedAt
      }
    }`,
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
