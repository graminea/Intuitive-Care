<template>
  <div>
    <h1>Buscar na Base de Dados</h1>
    <Search />
  </div>
</template>

<script>
import Search from "./components/Search.vue";

export default {
  components: {
    Search
  }
};
</script>

<style>
h1 {
  text-align: center;
}
</style>
