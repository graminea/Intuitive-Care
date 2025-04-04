<template>
  <div class="search-container">
    <h1>Buscar Registro</h1>
    <div class="controls">
      <select v-model="column">
        <option value="razao_social">Razão Social</option>
        <option value="cnpj">CNPJ</option>
        <option value="nome_fantasia">Nome Fantasia</option>
        <option value="reg_ans">Registro ANS</option>
      </select>
      <input type="text" v-model="value" placeholder="Digite o termo de busca..." />
      <button @click="fetchResults">Buscar</button>
    </div>
    <div class="results">
      <TransitionGroup name="fade">
        <div v-if="allResults.length === 0">
          Nenhum resultado encontrado.
        </div>
        <div v-for="(item, index) in displayedResults" :key="index" class="card">
          <p><strong>Registro ANS:</strong> {{ item.reg_ans }}</p>
          <p><strong>Razão Social:</strong> {{ item.razao_social }}</p>
          <p><strong>CNPJ:</strong> {{ item.cnpj }}</p>
          <p><strong>Nome Fantasia:</strong> {{ item.nome_fantasia }}</p>
          <button class="details-button" @click="toggleDetails(index)">
            {{ item.showDetails ? "Ocultar Detalhes" : "Ver Mais" }}
          </button>
          <Transition name="fade">
            <div v-if="item.showDetails">
              <p><strong>Modalidade:</strong> {{ item.modalidade }}</p>
              <p><strong>Endereço:</strong> {{ item.logradouro }}, {{ item.numero }}, {{ item.bairro }}, {{ item.cidade }} - {{ item.uf }}</p>
              <p><strong>Telefone:</strong> ({{ item.ddd }}) {{ item.telefone }}</p>
              <p><strong>Email:</strong> {{ item.endereco_eletronico }}</p>
              <p><strong>Representante:</strong> {{ item.representante }}</p>
              <p><strong>Registro ANS:</strong> {{ item.reg_ans }}</p>
            </div>
          </Transition>
        </div>
      </TransitionGroup>
      <button v-if="canShowMore" class="show-more-button" @click="showMoreResults">
        Mostrar Mais
      </button>
    </div>
  </div>
</template>
<script>
import "@/assets/Search.css";
export default {
  data() {
    return {
      column: "reg_ans",
      value: "",
      allResults: [], // Armazena todos os resultados da API
      results: [], // Resultados que estão sendo mostrados na tela
      resultsPerPage: 20, // Número de resultados por página
      currentPage: 1, // Página atual da exibição
    };
  },
  computed: {
    displayedResults() {
      return this.allResults.slice(0, this.currentPage * this.resultsPerPage);
    },
    canShowMore() {
      return this.displayedResults.length < this.allResults.length;
    },
  },
  methods: {
    async fetchResults() {
      if (!this.column || !this.value) return;
      try {
        const res = await fetch(
          `https://site-intuitive-care.up.railway.app/search?column=${this.column}&value=${this.value}`
        );
        const data = await res.json();
        this.allResults = data.results.map((item) => ({
          ...item,
          showDetails: false,
        }));
        // Exibir os primeiros 20 resultados
        this.results = this.allResults;
        this.currentPage = 1;
      } catch (error) {
        console.error("Erro na requisição:", error);
        this.allResults = []; // Garante que se houver erro, a mensagem "Nenhum resultado encontrado" seja exibida
      }
    },
    showMoreResults() {
      this.currentPage++;
    },
    toggleDetails(index) {
      this.results[index].showDetails = !this.results[index].showDetails;
    },
  }
};
</script>