import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('doctor_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
