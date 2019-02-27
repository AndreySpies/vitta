function searchType() {
  const search = document.getElementById('search-type');
  // if (search.value === 'Especialidade') {
  //   console.log('olá')
  // }
  // else  {
  //   console.log('tchau')
  // };
  search.addEventListener('select', (event) => {
    console.log('hello');
  })

};

export {searchType}
