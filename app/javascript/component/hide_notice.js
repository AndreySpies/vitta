const hideNotice = () => {
  if (document.querySelector('.alert')) {
    setTimeout(function(){ document.querySelector('.alert-info').classList.add('d-none'); }, 5000);
  }
};

export {hideNotice}

